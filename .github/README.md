My dotfiles
-----------
This repository contains my home directory setup, including many scripts and 
configuration files built up over years. I decided to make it public in order 
to share it with colleagues and others who might be interested. 

Licensed under the [UNLICENSE](https://unlicense.org).


How it's used
-------------
Other than git and a few helper scripts, there's no tool I used to "manage" my
dotfiles. Namely, my home directory *is* a git clone. That is, `$HOME/.git`
exists. So to set up my dotfiles on a new machine, I usually do something like
this:

```
mkdir -p tmp/old
mv .bashrc .bash_profile other things tmp/old
git init
git remote add origin git@github.com:casmith/dotfiles.git 
git pull origin main --ff-only
git branch --set-upstream-to origin/main main
chmod 0600 "$HOME/.ssh/config"
```

Note that some files in this repository, such as my SSH configuration, are
encrypted. Some secrets are stored in .secret and sourced in my .zshrc. For
more on how the encryption works, check out https://github.com/AGWA/git-crypt.

Finish Installation
-------------------

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Motivation
----------
In general, I'm making this public for the purposes of edification and easy
sharing. It is not a goal for this setup to be used and supported by others.
With that said, small fixes to existing scripts or suggestions on how to
improve my setup are welcome.


Caveats
-------
I may occasionally rewrite history of this repository and force push. This may
occur if I discover that I have accidentally published sensitive information.

Credit
------
I drew much inspiration for this from https://github.com/BurntSushi/dotfiles
