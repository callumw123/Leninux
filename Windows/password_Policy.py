#!python3
# must be run using py -3 ........

import pip
import os
import subprocess


# this uses pip to install modules required for this kind of thing. It is also fully self contained. Th packageName variable is used for when a package has different name from what you call when you import. package name is the one you would put in import [foo]
def install_and_import(package, packageName):
    import importlib
    try:
        importlib.import_module(packageName)
    except ImportError:
        import subprocess
        subprocess.check_call(
            ["py", '-3', '-m', 'pip', 'install', package])  # install pkg
        subprocess.check_call(
            ["py", '-3', '-m', 'pip', 'install', "--upgrade", package])  # upgrade pkg
    finally:
        importlib.invalidate_caches()
        globals()[package] = importlib.import_module(packageName)


install_and_import("PyGitHub", 'github')

subprocess.run(['Net', 'accounts', '/uniquepw:', '5'])  # password history
