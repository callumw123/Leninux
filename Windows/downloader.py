import os
import stat
import shutil
import shutil
import tempfile


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


def remove_readonly(func, path, excinfo):
    os.chmod(path, stat.S_IWRITE)
    func(path)


install_and_import("shutil", "shutil")
install_and_import("gitpython", "git")
from git import Repo
# from git import Repo:
# git_url = 'stack@127.0.1.7:/home2/git/stack.git'
# repo_dir = '/root/gitrepo/'
# if __name__ == "__main__":
#     Repo.clone_from(git_url, repo_dir, branch='master', bare=True)
#     print("OK")


# Create temporary dir
t = tempfile.mkdtemp()
# Clone into temporary dir
Repo.clone_from('https://github.com/callumw123/Leninux/',
                t, branch='master', depth=1)
# Copy desired file from temporary dir
try:
    shutil.move(os.path.join(t, 'windows/filestodownload.txt'), '.')
except:
    print("file  already exists")

filestodownload = open("filestodownload.txt").read()

for file in filestodownload.splitlines():
    try:
        shutil.move(os.path.join(t, 'windows/' + file), '.')
    except:
        print("file %s already exists" % file)

# Remove temporary dir
shutil.rmtree(t, onerror=remove_readonly)

userinput = input(
    "are you sure you want to run these files straight away? (y / n) \n").upper()
if userinput.upper() == "Y":
    print("files downloaded to %s" % os.getcwd())

    # import subprocess
    # subprocess.check_call([package])  # try to run downloaded files
else:
    print("files downloaded to %s" % os.getcwd())


# https://stackoverflow.com/questions/51239168/how-to-download-single-file-from-a-git-repository-using-python
# https://stackoverflow.com/questions/14120502/how-to-download-and-write-a-file-from-github-using-requests
