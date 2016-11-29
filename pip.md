# Installed Python modules

Tools installed with `pip` – for reference when I setup a new machine. Listing only top level formulas, not including all dependencies (unlike `$ pip list`).

The proper way to do it would be to use virtualenv and feed this list as requirements.txt to install all the dependencies. One day …

To avoid confusion which Python version I install a module for, use:
    $ python<2|3> -m pip install <module name>

## Python2
- gsutil: Copy folders recursively from Google Cloud Storage. Authentication guide: https://cloud.google.com/storage/docs/gsutil_install#creds-gsutil

## Python3
