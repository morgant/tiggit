prefix = /usr/local

install: tiggit Library/LaunchDaemons/com.makkintosshu.tiggit.plist
	install -m755 tiggit $(prefix)/bin
	install -m644 tiggit.conf.default /etc/tiggit.conf
	install Library/LaunchDaemons/com.makkintosshu.tiggit.plist /Library/LaunchDaemons
	mkdir -p /Library/GitMirrors