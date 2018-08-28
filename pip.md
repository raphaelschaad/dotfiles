# Installed Python modules

Tools installed with `pip` – for reference when I setup a new machine. Listing only top level modules, not including all dependencies (unlike `$ pip list`).

The proper way to do it would be to use virtualenv and feed this list as requirements.txt to install all the dependencies. One day …

To avoid confusion which Python version I install a module for, use:

    $ python<2|3> -m pip install <module name>

Upgrade pip to the latest version:

    $ python<2|3> -m pip install --upgrade pip

Install setuptools (or upgrade, if already installed):

    $ python<2|3> -m pip install -U pip setuptools

## Python2
- gsutil: Copy folders recursively from Google Cloud Storage. Authentication guide: https://cloud.google.com/storage/docs/gsutil_install#creds-gsutil
- networkx: Create, manipulate, and analyze graph networks.
- matplotlib: Required by NetworkX.
- selenium: Required by audible-activator.

## Python3
- lxml: Wrapper for libxml2 used by AxiDraw's axicli.py
