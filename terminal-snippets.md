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


**Find Mac folder aliases recursively (Spotlight needs to be enabled)**

    $ mdfind "kMDItemKind == 'Alias'" -onlyin .


**Delete all folders recursively (deletes even if non-empty)**

    $ find . -type d -exec rm -r {} \;


**Search for „foo“ in contents of any files**

    $ grep -r -i foo *

`-r` recursively (same as `-R`)  
`-i` ignore case (default is case sensitive)  


**Search for „foo“ in contents of .txt-files only (ignore „Permission denied“ output)**

    $ find . -type f -name "*.txt" -exec grep -i foo /dev/null {} \; 2> /dev/null


**How much free disk space do I have?**

    $ df -hT hfs


**How much memory is installed? (in Bytes, `/1024^3` to go to GB)**

    $ sysctl -a | grep hw.memsize:


**Simulate network latency (good for mobile app testing on desktop; there’s now an easier to use „Network Link Conditioner“ for OS X or a „Throttling“ option in „Charles Web Debugging Proxy“)**

    # ipfw add pipe 1 src-port http
    # ipfw pipe 1 config delay 200 bw 700kbit/s

Don’t forget to reset!

    # ipfw flush


**HTTP GET and show response with headers**

    $ wget -S -O - http://example.com/webservice 2>1

`-S` print headers  
`-O -` concatenate all together and print to standard output  
`2>&1` wget prints the headers to stderr, redirect to stdout  


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

    $ ffmpeg -i ScreenFlow.mp4 -r 10 %04d.png

FFmpeg direct GIF export is dithered as hell, so go via PNG  
`-r` for lower FPS  
`%04d` for leading zeros because Gifsicle needs that  

    $ for i in *.png; do convert $i $i.gif; done
    $ gifsicle *.gif --loop > animated.gif


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
    $ sudo ln -s ~/<dir to be served>/ /Library/WebServer/Documents/<dir to be served>

Now browse to http://localhost/<dir to be served>/
