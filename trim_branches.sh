# I am following a feature branch workflow, where each new feature/task related to my project is stored in a feature branch.
# Once the feature is done, that feature branch is merged into master and the process restarts.
#
# This process leaves my local machine with lots of useless branches hanging around. They aren't on GitHub since I delete
# feature branches that are merged into master.
#
# The following commands are meant for folks with git versions 2.6.X and older who wish to delete local branches
# that have been successfully merged into master. It will preserve the master branch.
#
# For more information, please see: https://stackoverflow.com/a/26152574/7954106
for branch in $(git for-each-ref --format '%(refname:short)' refs/heads/)
do
    git merge-base --is-ancestor ${branch} HEAD && git branch -d ${branch}
done
