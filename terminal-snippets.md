# Terminal Snippets

A collection of useful terminal snippets.

**What commands do I use the most?**

    $ sed -e "s/| /\n/g" ~/.bash_history | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | head


**List folders ordered by contents size**

    $ du -d 1 . 2> /dev/null | sort -nr | grep -v '/\.' | cut -f 2 | while read i; do du -sh "$i" 2> /dev/null; done


**Show current Unix timestamp**

    $ date +%s


**Convert Unix timestamp to date**

    $ date -r 1234567890


**Search and replace in streams**

    $ ls | sed s/SEARCH/REPLACE/g

`s` substitute  
`g` all non-overlapping matches, not just first one  


**Count characters in a string**

    $ echo "912ec803b2ce49e4a541068d495ab570" | wc -m


**Delete all dot-files like `.DS_STORE` recursively**

    $ find . -name ".*" -exec rm {} \;


**Find Mac folder aliases recursively (Spotlight has to be enabled)**

    $ mdfind "kMDItemKind == 'Alias'" -onlyin .


**Delete all folders recursively (deletes even if non-empty)**

    $ find . -type d -exec rm -r {} \;


**Search for "foo" in contents of any files**

    $ grep -r -i foo *

`-r` recursively (same as `-R`)  
`-i` ignore case (default is case sensitive)  


**Search for "foo" in contents of .txt-files only (ignore "Permission denied" output)**

    $ find . -type f -name "*.txt" -exec grep -i foo /dev/null {} \; 2> /dev/null


**How much free disk space do I have?**

    $ df -hT hfs


**How much memory is installed? (in Bytes, `/1024^3` to go to GB)**

    $ sysctl -a | grep hw.memsize:


**Simulate network latency (good for mobile app testing on desktop; there’s now an easier to use "Network Link Conditioner" for macOS or a "Throttling" option in "Charles Web Debugging Proxy")**

    # ipfw add pipe 1 src-port http
    # ipfw pipe 1 config delay 200 bw 700kbit/s

Don’t forget to reset!

    # ipfw flush


**HTTP GET and show response with headers**

    $ wget -S -O - http://example.com/webservice 2>&1

`-S` print headers  
`-O -` concatenate results together and print to standard output  
`2>&1` wget prints the headers to stderr, redirect to stdout instead  

Enclose the URL with quotes if it contains ampersands.


**Split file**

    $ split -b 2990m file.avi file-parts.avi


**Concatenate multiple split file parts**

    $ cat file-parts.avi[a-z][a-z] > file.avi


**Create password-protected ZIP-file of folder**

    $ zip -re archive.zip dir/

`-r` recursive (for folders)  
`-e` encrypt (prompts for password)  


**Unpack ZIP-file in folder (gets created)**

    $ unzip archive.zip -d new_dir

If unzip and The Unarchiver.app fail, try `tar` or `jar` (same options as `tar`).  


**Create tarball of folder**

    $ tar -cf tarball.tar dir/


**Unpack tarball in folder (must already exist)**

    $ tar -xf tarball.tar -C dir/


**Clean up after a poorly-formed tarball**

    $ tar ztf tar-lacking-subdirectory.tar.gz | xargs rm


**List all `figlet` ASCII art fonts**

    $ (cd /usr/local/share/figlet/fonts; for i in `find .`; do figlet -f $i "Cool Cafe" && echo $i; done)


**Show manpage in Preview.app**

    $ man -t ls | open -fa preview


**Convert mp4 into animated GIF**

    $ ffmpeg -i ScreenFlow.mp4 -r 10 %4d.png

FFmpeg direct GIF export is dithered as hell, so go via PNG  
`-r` for lower FPS  
`%4d` for leading zeros because Gifsicle needs that  

    $ for i in *.png; do convert $i $i.gif; done
    $ gifsicle --delay=100 *.gif --loop > animated.gif

`--delay=100` for 1 second delay between frames. Default is "none", commonly played as 0.2 centiseconds.

**Export a single still frame from mp4 (e.g. for poster image)**

    $ ffmpeg -i input.mp4 -ss 00:01:02 -vframes 1 -qscale:v 2 output.jpg

`-qscale:v` for JPG output quality (2-31, 31 being the worst)


**Convert any image into a 1-bit black/white PNG**

    $ convert -monochrome -colors 2 in.jpg out.png


**Set DPI for an image**

    $ convert -density 600 -units pixelsperinch in.jpg out.png


**Print DPI of an image**

    $ identify -verbose -units pixelsperinch in.png | grep Resolution
      Resolution: 600x600

If it doesn't print a line like this, then it doesn't specify a resolution.  


**Using the bundled webserver (OS X El Capitan 10.11)**

    $ sudo apachectl start
    $ sudo ln -s ~/dir-to-be-served/ /Library/WebServer/Documents/dir-to-be-served

Ensure parent directory is drwxr-xr-x (if needed, change: # chmod 755 parent-directory)  
Now browse to http://localhost/dir-to-be-served/  


**Download a set of images from incrementing URLs**

    $ for i in $(seq -f "%03g" 00 181); do wget http://thestandardsmanual.com/images/large/nycta_gsm_$i.jpg; done


**Validate JSON (also pretty-prints)**

    $ cat inputfile.json | python -mjson.tool


**Hide desktop icons (`true` to reverse)**

    $ defaults write com.apple.finder CreateDesktop false
    $ killall Finder

Show again with `CreateDesktop true` and restarting Finder  


**Copy terminal output to system clipboard**

    $ echo hello | pbcopy


**Copy file contents to system clipboard**

    $ cat file | pbcopy


**Unpause "not responding" macOS app**

    $ kill -CONT <pid>


**Schedule and test user background process ("user agent") with launchd**

    $ launchctl load com.raphaelschaad.test.plist
    $ launchctl start com.raphaelschaad.test
    $ launchctl list | grep com.raphaelschaad
    $ launchctl stop com.raphaelschaad.test
    $ launchctl unload com.raphaelschaad.test.plist

launchd PList files go in ~/Library/LaunchAgents.  
launchd is the preferred way of scheduling such processes on macOS (not cron jobs). User agents are similar to daemons but user-specific and execute only when the user is logged in and the computer is not asleep.  
