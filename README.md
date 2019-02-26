![tiger](docs/tiger.svg)

# tig|git
by Morgan Aldridge <morgant@makkintosshu.com>

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=DBY3R8ARLDELE&currency_code=USD&source=url)

## OVERVIEW

`tiggit` provides simple, automatic mirroring of remote git repositories for backup purposes. Not to be confused with [gittig](https://github.com/tuler/gittig).

## INSTALLATION

Installation is performed as follows:

    sudo make install

_Note: Installation currently only supports creating the `_tiggit` daemon user on macOS (née OS X), but I'm happy to add support for additional operating systems._

If you intend to mirror private repositories, you will have to ensure that SSH keys are configured correctly. If you will be mirroring private repositories with `tiggit` running as a daemon, then the SSH keys will need to be configured for the the `_tiggit` user (in macOS, keys should exist in `/Library/WebServer/.ssh`). See [GitHub SSH Host Keys] for further details.

## USAGE

`tiggit` can be run manually, or automatically as a daemon. For further usage instructions, run `tiggit -h`.

### Manual

`tiggit list` will list all mirrored repositories.

`tiggit mirror <uri>` will mirror the git repository from the specified URI.

`tiggit update <repo>` will update the git repository specified by just the repository name.

### Daemon

In daemon mode, `tiggit` will read the list of repositories it should mirror and keep updated from `/etc/tiggit.conf` (see [CONFIGURATION](#CONFIGURATION) for further details). After the initial mirroring of any repositories it's not already mirroring, it will fetch updates every 15 minutes.

One can manually run it as a daemon as follows:

    tiggit --verbose --daemon >> /var/log/tiggit.log &

Or:

    tiggit -vd >> /var/log/tiggit.log &

Alternatively, on macOS, `tiggit` will be automatically run via `launchd`. You can start the `launchd` job as follows (or it'll start automatically upon boot):

    sudo launchctl load /Library/LaunchDaemons/com.makkintosshu.tiggit.plist

Or, stop it:

    sudo launchctl unload /Library/LaunchDaemons/com.makkintosshu.tiggit.plist

## GITHUB SSH HOST KEYS

SSH host keys are required to mirror repositories via git/SSH URIs, esp. private repositories. There are special considerations when running `tiggit` as a daemon.

### Manual

If you will be working with `tiggit` manually using your own GitHub account, see [Adding a new SSH key to your GitHub account](https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account).

### Daemon

If you'll be running `tiggit` as a daemon, the following instructions are suggested to create a "machine user" GitHub account, with its own SSH keys:

1. If you haven't already, create a [machine user](https://developer.github.com/v3/guides/managing-deploy-keys/#machine-users) account on GitHub.

2. Configure and/or copy the SSH key for your `_tiggit` daemon user:

  a. Run `sudo -u _tiggit ls -al ~_tiggit/.ssh/` to list the `_tiggit` user's SSH keys.

  b. If an `id_rsa.pub` public key file already exists, skip to Step 2.g.

  c. Run `sudo -u _tiggit ssh-keygen -t rsa -b 4096 -C "your_email@example.com"` (replacing `your_email@example.com` with the email address for your GitHub machine user account).

  d. When prompted to "Enter a file in which to save the key," press enter to save it in the default location (in macOS, this should be `/Library/GitMirrors/.ssh/`).

  e. When prompted to enter a passphrase, press return twice to save without a passphrase (a passphrase will prevent the daemon from being able to use the SSH key).

  f. Run `sudo -u _tiggit ssh-keyscan -H github.com >> ~_tiggit/.ssh/known_hosts` to add GitHub to the `_tiggit` user's list of authorized hosts.

  g. Run `sudo -u _tiggit cat ~_tiggit/.ssh/id_rsa.pub` to display the `_tiggit` user's public key.

  h. Copy the output from the previous command (it should begin with "ssh-rsa" and end with the email address you entered in Step 2.c.)

3. Add the `_tiggit` daemon user's SSH public key to the GitHub machine user's account:

  a. Log into GitHub using your machine user account.

  b. Navigate to the GitHub [SSH and GPG keys settings](https://github.com/settings/keys).

  c. Click the [New SSH key](https://github.com/settings/ssh/new) button.

  d. Enter `_tiggit@<hostname>` in the Title field (replacing `<hostname>` with the hostname or IP address of the computer running `tiggit` as a daemon).

  e. Paste the `_tiggit` user's SSH public key into the Key field (as copied in Step 2.h. above).

  f. Click the "Add SSH key" button

4. Give your GitHub machine user account access to the repositories you want to mirror (as either a collaborator, an outside collaborator, or a team member).

## CONFIGURATION

When run in daemon mode, `tiggit` will read repos to mirror & update from `/etc/tiggit.conf`. The configuration file format supports comments, groups, and repository URLs.

### Comments

Comments are lines that begin with a hash/pound symbol (`#`):

    # This is a comment

_Important:_ Currently, only full-line comments are supported.

### Groups

Groups namespace repositories to prevent conflicts, but also for organization, specified by wrapping the group name in square brackets:

    [group]

A special `auto` group exists which will automatically group repositories by username parsed from the URI. Currently, only GitHub URIs are supported, but others can easily be added.

### Repository URIs

Each non-comment line following a group should be a repository URI to be mirrored:

    https://github.com/morgant/tiggit.git

Currently, HTTPS & SSH URIs are supported.

## ENVIRONMENT VARIABLES

`TIGGIT_CONFIG`: name of config file (default: `tiggit.conf`)

`TIGGIT_CONFIG_PATH`: path to configuration file (default: `/etc`)

`TIGGIT_MIRRORS_PATH`: path to mirrored repositories (default: `/Library/GitMirrors`)

`TIGGIT_UPDATE_INTERVAL`: seconds between fetching updates to repositories (seconds; default: `900` [seconds] or 15 minutes)

## ACKNOWLEDGEMENTS

Icons made by [Freepik](https://www.freepik.com/) from [https://www.flaticon.com/](www.flaticon.com) are licensed by [CC 3.0 BY](http://creativecommons.org/licenses/by/3.0/)