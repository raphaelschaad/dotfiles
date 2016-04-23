# Installed Homebrew formulas

Tools installed with `brew` – for reference when I setup a new machine. Listing only top level formulas, not including all dependencies (unlike `$ brew list`).

## Essentials
- wget
- git: Newer version than the one that comes with the system
- hub: See `.profile`

## Development
- carthage: FLAnimatedImage supports this
- python: Currently the latest 2.x Homebrew python is 2.7.11. OS X El Cap's stock python in /usr/bin is 2.7.10. Only the Homebrew one comes with pip. To get pip on stock Python without the Homebrew installation: $ sudo easy_install pip
- python3: OS X El Cap only comes with 2.x stock. Python3 comes with pip by default.
- opencv: first tap homebrew/science
- opencv3: also from homebrew/science; installed `--with-python3`; used `brew unlink opencv` + `brew link --force opencv3` (can be reverted by `brew unlink opencv3` + `brew link opencv` + `brew link --overwrite numpy`)
- nvm: only brew nvm, not node; use nvm to install node: http://stackoverflow.com/a/28025834/251440

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
- gdal: convert shapefiles to JSON (CLI tool `ogr2ogr`)
