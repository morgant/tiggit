# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

* Added this `CHANGELOG.md` file with documentation for all prior releases

### Changed

* The tiggit mirrors path (overridden by the `TIGGIT_MIRRORS_PATH` environment
    variable) default location has changed from the macOS-specific
    `/Library/GitMirrors/` to the POSIX-friendly `/var/db/tiggit/`. However,
    the `com.makkintosshu.tiggit.plist` launchd.plist(5) for macOS still
    overrides the `TIGGIT_MIRRORS_PATH` environment variable to
    `/Library/GitMirrors/` for backwards compatibility for existing
    installations. (Issue [#6](https://github.com/morgant/tiggit/issues/6))
* Updated [tiggit(1)](man/tiggit.1) manual page regarding new default for the
    `TIGGIT_MIRRORS_PATH` environment variable, including updated examples in
    [tiggit-conf(5)](man/tiggit-conf.5) (issue
    [#6](https://github.com/morgant/tiggit/issues/6))
* New tiggit icon derived from [tiger icon](doc/tiger/README.md).
* Improved formatting of [`README.md`](README.md)

### Removed

* Removed dependancy on ruby and ruby gems, especially
    [ronn](https://github.com/rtomayko/ronn) (previously used to generate
    manual pages from Markdown files; issue
    [#5](https://github.com/morgant/tiggit/issues/5))
* Removed `.ronn` and `.html` versions of manual pages in [`man/`](man/)
    (issue [#5](https://github.com/morgant/tiggit/issues/5))

## [0.1.1] - 2019-03-15

### Added

* Improved logging, including new `TIGGIT_LOG` (default: `tiggit.log`) and
    `TIGGIT_LOG_PATH` (default: `/var/log`) environment variables

## [0.1.0] - 2019-02-26

### Added

*  Initial release

[unreleased]: https://github.com/morgant/tiggit/compare/0.1.1...main
[0.1.1]: https://github.com/morgant/tiggit/compare/0.1...0.1.1
[0.1.0]: https://github.com/morgant/tiggit/releases/tag/0.1
