![tiger](docs/tiger.svg)

# tig|git
by Morgan Aldridge <morgant@makkintosshu.com>

## OVERVIEW

`tiggit` provides simple, automatic mirroring of remote git repositories for backup purposes. Not to be confused with [gittig](https://github.com/tuler/gittig).

## INSTALLATION

Installation is performed as follows:

    sudo make install

_Note: Installation currently only supports creating the `_tiggit` daemon user on macOS (née OS X), but I'm happy to add support for additional operating systems._

If you intend to mirror private repositories, you will have to ensure that SSH keys are configured correctly. If you will be mirroring private repositories with `tiggit` running as a daemon, then the SSH keys will need to be configured for the the `_tiggit` user (in macOS, keys should exist in `/Library/WebServer/.ssh`).

## USAGE

`tiggit` can be run manually, or automatically as a daemon. For further usage instructions, run `tiggit -h`.

### Manual

`tiggit list` will list all mirrored repositories.

`tiggit mirror <uri>` will mirror the git repository from the specified URI.

`tiggit update <repo>` will update the git repository specified by just the repository name.

### Daemon

In daemon mode, `tiggit` will read the list of repositories it should mirror and keep updated from `/etc/tiggit.conf` (one per line). After the initial mirroring of any repositories it's not already mirroring, it will fetch updates every 15 minutes.

One can manually run it as a daemon as follows:

    tiggit --verbose --daemon >> /var/log/tiggit.log &

Or:

    tiggit -vd >> /var/log/tiggit.log &

Alternatively, on macOS, `tiggit` will be automatically run via `launchd`. You can start the `launchd` job as follows (or it'll start automatically upon boot):

    sudo launchctl load /Library/LaunchDaemons/com.makkintosshu.tiggit.plist

Or, stop it:

    sudo launchctl unload /Library/LaunchDaemons/com.makkintosshu.tiggit.plist

## ENVIRONMENT VARIABLES

`TIGGIT_CONFIG`: name of config file (default: `tiggit.conf`)

`TIGGIT_CONFIG_PATH`: path to configuration file (default: `/etc`)

`TIGGIT_MIRRORS_PATH`: path to mirrored repositories (default: `/Library/GitMirrors`)

`TIGGIT_UPDATE_INTERVAL`: seconds between fetching updates to repositories (seconds; default: `900` [seconds] or 15 minutes)

## ACKNOWLEDGEMENTS

Icons made by [Freepik](https://www.freepik.com/) from [https://www.flaticon.com/](www.flaticon.com) are licensed by [CC 3.0 BY](http://creativecommons.org/licenses/by/3.0/)