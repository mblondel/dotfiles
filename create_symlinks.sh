CURRDIR="$( cd -P "$( dirname "$0" )" && pwd )"

for file in `ls -a $CURRDIR | egrep "^\.[a-zA-Z]" | grep -v ssh`; do
    rm -rf $HOME/$file
    ln -s $CURRDIR/$file $HOME/$file
done

rm -rf $HOME/.git
rm -f $HOME/.gitmodules
rm -f $HOME/.ssh/config
mkdir -p .ssh
ln -s $CURRDIR/.ssh/config $HOME/.ssh/config 
