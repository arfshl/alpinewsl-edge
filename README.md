# AlpineWSL-Edge
Forked from [yuk7/AlpineWSL](https://github.com/yuk7/AlpineWSL)

Alpine Linux Edge on WSL (Windows 10 1803 or later)
based on [wsldl](https://github.com/yuk7/wsldl)

![screenshot](https://private-user-images.githubusercontent.com/98870352/569870761-9578acb1-9c64-45b0-a791-2af471d139d2.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzQ1NDAyNDcsIm5iZiI6MTc3NDUzOTk0NywicGF0aCI6Ii85ODg3MDM1Mi81Njk4NzA3NjEtOTU3OGFjYjEtOWM2NC00NWIwLWE3OTEtMmFmNDcxZDEzOWQyLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAzMjYlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMzI2VDE1NDU0N1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTE4Mjk1YjYzNDNhMDI3NWM2NmJjOTkzYjI1ZDAxZWU1NzgyMjFhNmY0YWM2ZjFmNDc5MDVkOGU2ZGQ3ZTZlMzkmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.w6Tysy94umH2BmzGW3z_EncV1aMQIin2N1tnnZrgOuY)

[![GitHub Workflow Build Status](https://img.shields.io/github/actions/workflow/status/arfshl/AlpineWSL-Edge/build-zip.yaml?style=flat-square)](https://github.com/arfshl/AlpineWSL-Edge/actions/workflows/build-zip.yaml)
[![GitHub Workflow Release Status](https://img.shields.io/github/actions/workflow/status/arfshl/AlpineWSL-Edge/release-zip.yaml?style=flat-square)](https://github.com/arfshl/AlpineWSL-Edge/actions/workflows/release-zip.yaml)
[![Github All Releases](https://img.shields.io/github/downloads/arfshl/AlpineWSL-Edge/total.svg?style=flat-square)](https://github.com/arfshl/AlpineWSL-Edge/releases/latest)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![License](https://img.shields.io/github/license/arfshl/AlpineWSL-Edge.svg?style=flat-square)

### [Download](https://github.com/arfshl/AlpineWSL-Edge/releases/latest)


## Requirements
* Windows 10 1803 April 2018 Update x64/arm64 or later.
* Windows Subsystem for Linux feature is enabled.

## Install
#### 1. [Download](https://github.com/arfshl/AlpineWSL-Edge/releases/latest) installer zip

#### 2. Extract all files in zip file to same directory

#### 3.Run Alpine-Edge.exe to Extract rootfs and Register to WSL
Exe filename is using to the instance name to register.
If you rename it, you can register with a different name and have multiple installs.


## How-to-Use(for Installed Instance)
#### exe Usage
```dos
Usage :
    <no args>
      - Open a new shell with your default settings.

    run <command line>
      - Run the given command line in that instance. Inherit current directory.

    runp <command line (includes windows path)>
      - Run the given command line in that instance after converting its path.

    config [setting [value]]
      - `--default-user <user>`: Set the default user of this instance to <user>.
      - `--default-uid <uid>`: Set the default user uid of this instance to <uid>.
      - `--append-path <true|false>`: Switch of Append Windows PATH to $PATH
      - `--mount-drive <true|false>`: Switch of Mount drives
      - `--default-term <default|wt|flute>`: Set default type of terminal window.

    get [setting]
      - `--default-uid`: Get the default user uid in this instance.
      - `--append-path`: Get true/false status of Append Windows PATH to $PATH.
      - `--mount-drive`: Get true/false status of Mount drives.
      - `--wsl-version`: Get the version os the WSL (1/2) of this instance.
      - `--default-term`: Get Default Terminal type of this instance launcher.
      - `--lxguid`: Get WSL GUID key for this instance.

    backup [contents]
      - `--tar`: Output backup.tar to the current directory.
      - `--reg`: Output settings registry file to the current directory.

    clean
      - Uninstall that instance.

    help
      - Print this usage message.
```


#### How to uninstall instance
```dos
>Alpine-Edge.exe clean

```

## How-to-Build
AlpineWSL can build on GNU/Linux or WSL.

`curl`,`bsdtar`,`tar`(gnu) and `sudo` is required for build.
```shell
$ make
```

with flags:
```
$ make ARCH=arm64 OUT_ZIP=Alpine_arm64.zip
```

### Basic Params
|  Parameter |  Value  |  Default  |
| ---- | ---- | ---- |
|  ARCH  |  x64/arm64  | x64 |
|  LNCR_EXE  |  launcher file name  | Alpine-Edge.exe |
|  OUT_ZIP  |  zip file name  | Alpine.zip |
|  DLR  |  file downloader  | curl |
|  DLR_FLAGS  |  downloader flags  | -L |
|  BASE_URL  |  base rootfs url  | https:~ |
|  ROOTFS_TARBALL_CKSM_URL  |  sha-sum for the base rootfs tarball  |  https:~ |
