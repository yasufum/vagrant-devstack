#!/bin/sh

TARGET=helper/git_setup.sh

echo "#!/bin/sh" > ${TARGET}
echo "" >> ${TARGET}
echo git config --global user.name \"$(git config --get user.name)\" >>  ${TARGET}
echo git config --global user.email \"$(git config --get user.email)\" >> ${TARGET}
echo git config --global gitreview.username \"$(git config --get gitreview.username)\" >> ${TARGET}
chmod 775 ${TARGET}
