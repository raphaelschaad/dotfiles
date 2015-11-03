# Installed Homebrew formulas

Tools installed with `brew` -- for reference when I setup a new machine. Listing only top level formulas, not including all dependencies (unlike `$ brew list`).

## Essentials
- wget
- git: Newer version than the one that comes with the system
- hub: See `.profile`

## Development
- carthage: FLAnimatedImage supports this
- python: Currently the latest 2.x Homebrew python is 2.7.10, which is also the OS X El Cap stock python in /usr/bin, but the Homebrew one comes with pip. To get pip on stock Python: $ sudo easy_install pip
- python3: OS X comes with 2.7.10, which is also the latest 2.x version in Homebrew.

## Design
- boost-python: For Antimony. Installed with `--with-python3`.
- qt5: For Antimony.
- lemon: For Antimony.
- flex: For Antimony.

## Everything else
- exiftool: Rename photos imported with Image Capture to “Dropbox filename format” http://ninedegreesbelow.com/photography/exiftool-commands.html#rename
- tesseract: OCR originally from HP now developed at Google. Leading open source solution if image input is well-formed; had mixed results. Installed with `--HEAD` to get 3.03+ (at the time of writing) for built in PDF support.
- imagemagick: Included CLI tools I use most: `convert`, `identify`. Installed with `--with-ghostscript` for PDF to image conversion.
- ffmpeg
- libass: Fonts to add subtitles with ffmpeg, see `.profile`.
