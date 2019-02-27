PREFIX = /usr/local

OS = $(shell uname -s)

USER = _tiggit
GROUP = daemon
ifeq ($(OS),Darwin)
	UID = $(shell expr "$$(dscl . -list /Users UniqueID | awk '$$2<500 {print $$2}' | sort -rn | head -n 1)" + 1)	# based on ideas from https://stackoverflow.com/questions/9028383/find-the-highest-user-id-in-mac-os-x & https://stackoverflow.com/questions/32810960/create-user-for-running-a-daemon-on-macos-x
	GID = $(shell id -g $(GROUP))
endif

user:
	dscl . -create /Users/$(USER)
	dscl . -create /Users/$(USER) UniqueID $(UID)
	dscl . -create /Users/$(USER) UserShell /usr/bin/false
	dscl . -create /Users/$(USER) RealName "tiggit daemon"
	dscl . -create /Users/$(USER) NFSHomeDirectory /Library/GitMirrors
	dscl . -create /Users/$(USER) PrimaryGroupID $(GID)
	dscl . -create /Users/$(USER) Password \*

install: bin/tiggit user
	mkdir -p $(PREFIX)/bin
	install -m755 bin/tiggit $(PREFIX)/bin
	install man/tiggit.1 $(PREFIX)/share/man/man1
	install man/tiggit-conf.5 $(PREFIX)/share/man/man5
	install -m644 etc/tiggit.conf.default /etc
	mkdir -p /Library/GitMirrors
	chown -R _tiggit /Library/GitMirrors
	touch /var/log/tiggit.log
	chown _tiggit /var/log/tiggit.log
ifeq ($(OS),Darwin)
	install Library/LaunchDaemons/com.makkintosshu.tiggit.plist /Library/LaunchDaemons
endif
