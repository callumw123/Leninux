import os
from git import Repo
git_url = 'stack@127.0.1.7:/home2/git/stack.git'
repo_dir = '/root/gitrepo/'
if __name__ == "__main__":
    Repo.clone_from(git_url, repo_dir, branch='master', bare=True)
    print("OK")
    
import os
import git
import shutil
import tempfile

# Create temporary dir
t = tempfile.mkdtemp()
# Clone into temporary dir
git.Repo.clone_from('stack@127.0.1.7:/home2/git/stack.git', t, branch='master', depth=1)
# Copy desired file from temporary dir
shutil.move(os.path.join(t, 'setup.py'), '.')
# Remove temporary dir
shutil.rmtree(t)

#https://stackoverflow.com/questions/51239168/how-to-download-single-file-from-a-git-repository-using-python
#https://stackoverflow.com/questions/14120502/how-to-download-and-write-a-file-from-github-using-requests
