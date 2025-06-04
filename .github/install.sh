mkdir -p tmp/old
mv .bashrc .bash_profile other things .zshrc tmp/old 2> /dev/null

git init --initial-branch main
git remote add origin https://github.com/casmith/dotfiles.git 
git pull origin main --ff-only
git checkout main
git branch --set-upstream-to origin/main main

git remote set-url origin git@github.com:casmith/dotfiles.git

mkdir -p "$HOME/.ssh"
chmod 0600 "$HOME/.ssh/config"
