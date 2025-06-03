mkdir -p tmp/old
mv .bashrc .bash_profile other things tmp/old
git init
git remote add origin git@github.com:casmith/dotfiles.git 
git pull origin main --ff-only
git branch --set-upstream-to origin/main main
chmod 0600 "$HOME/.ssh/config"
