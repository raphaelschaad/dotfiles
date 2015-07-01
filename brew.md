# Installed Homebrew formulas

Tools installed with `brew` -- for reference when I setup a new machine. Listing only top level formulas, not including all dependencies (unlike `$ brew list`).

## Essentials
- wget
- git: Newer version than the one that comes with the system
- hub: See `.profile`

## Everything else
- exiftool: Rename photos imported with Image Capture to “Dropbox filename format” http://ninedegreesbelow.com/photography/exiftool-commands.html#rename
- tesseract: OCR originally from HP now developed at Google. Leading open source solution if image input is well-formed; had mixed results. Installed with `--HEAD` to get 3.03+ (at the time of writing) for built in PDF support.
- imagemagick: CLI tool is called `convert`. Installed with `--with-ghostscript` for PDF to image conversion.
- ffmpeg
- libass: Fonts to add subtitles with ffmpeg, see `.profile`.
