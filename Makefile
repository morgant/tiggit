PREFIX = /usr/local

USER = _tiggit
UID = $(shell dscl . -list /Users UniqueID | awk '$$2<500 {print $$2}' | sort -rn | head -n 1)	# based on ideas from https://stackoverflow.com/questions/9028383/find-the-highest-user-id-in-mac-os-x & https://stackoverflow.com/questions/32810960/create-user-for-running-a-daemon-on-macos-x
GID = $(shell id -g daemon)

user:
	dscl . -create /Users/$(USER)
	dscl . -create /Users/$(USER) UniqueID $(UID)
	dscl . -create /Users/$(USER) UserShell /usr/bin/false
	dscl . -create /Users/$(USER) RealName "tiggit daemon"
	dscl . -create /Users/$(USER) NFSHomeDirectory /Library/GitMirrors
	dscl . -create /Users/$(USER) PrimaryGroupID $(GID)
	dscl . -create /Users/$(USER) Password \*

install: tiggit user
	mkdir -p $(PREFIX)/bin
	install -m755 tiggit $(PREFIX)/bin
	install -m644 etc/tiggit.conf.default /etc
	install Library/LaunchDaemons/com.makkintosshu.tiggit.plist /Library/LaunchDaemons
	mkdir -p /Library/GitMirrors
	chown -R _tiggit /Library/GitMirrors
	touch /var/log/tiggit.log
	chown _tiggit /var/log/tiggit.log
