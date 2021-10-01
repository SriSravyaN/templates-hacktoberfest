In Github, click on Fork. For example, if you go to https://github.com/SriSravyaN/templates-hacktoberfest and click on Fork, I'll get my own copy on https://github.com/srisravyan/templates-hacktoberfest

Clone your copy of the repo

    $ git clone https://github.com/SriSravyaN/templates-hacktoberfest

Now you have a master branch

    $ git branch
    * master

but instead of working on my master, I should leave it for synchronising with the original master. I'll work on a new branch named after the specific addition that I am proposing

    $ git checkout -b https

creates a new branch and switches to it.

 $ git branch
    * https
      master

Now we are ready to add changes and commit to our feature branch but notice that the feature branch is local. In order to push it to our remote we need to

    git push -u origin https

and now we are ready to go to Github and perform a pull request

If during the process the original repo changes, we will want to sync with it. The master is an easy one

    git remote add upstream https://github.com/SriSravyaN/templates-hacktoberfest
    git checkout master
    git fetch --all
    git merge upstream/master

Then we can rebase our master onto our feature branch and then push the feature branch to our repo. Remember that changes pushed to a branch from wich we have already requested a pull will be integrated in the pull request. That's another reason why it is convenient to request the pull from our feature branch, and not from our master.

