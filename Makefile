prefix = /usr/local

user = _tiggit
uid = $(shell dscl . -list /Users UniqueID | awk '$$2<500 {print $$2}' | sort -rn | head -n 1)	# based on ideas from https://stackoverflow.com/questions/9028383/find-the-highest-user-id-in-mac-os-x & https://stackoverflow.com/questions/32810960/create-user-for-running-a-daemon-on-macos-x
gid = $(shell gid -g daemon)

_tiggit:
	# create the user
	dscl . -create /Users/$(user)
	dscl . -create /Users/$(user) UniqueID $(uid)
	dscl . -create /Users/$(user) UserShell /usr/bin/false
	dscl . -create /Users/$(user) RealName "tiggit daemon"
	dscl . -create /Users/$(user) NFSHomeDirectory /Library/GitMirrors
	dscl . -create /Users/$(user) PrimaryGroupID $(gid)
	dscl . -create /Users/$(user) Password \*

install: tiggit Library/LaunchDaemons/com.makkintosshu.tiggit.plist _tiggit
	install -m755 tiggit $(prefix)/bin
	install -m644 etc/tiggit.conf.default /etc/tiggit.conf
	install Library/LaunchDaemons/com.makkintosshu.tiggit.plist /Library/LaunchDaemons
	mkdir -p /Library/GitMirrors