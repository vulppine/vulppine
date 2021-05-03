# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PATH=~/go/bin/:~/.cargo/bin:$PATH

### ALIASES ###

### POSIX ###
alias ls='ls -lh'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -Iv'

### EDITORS ###
alias vi=vim
alias emacs='emacs -nw'

### GIT ###
# if you seriously think i'm going to
# write out every single git command
# every time i want to do something
# do i have news for you!!!!!!!!!!!!!

alias ggc='git commit' # ah, ah, ah, too close to gcc
alias gga='git add'
alias gpp='git push -v'
alias gpf='git pull -v'
alias gba='git branch'
alias gbu='git branch -u'
# alias ggs='git status'
alias gbl='git branch --list -a'
alias gra='git remote add'
alias grl='git remote -v'

# list all branches if the first arg is empty, otherwise switch
gbb() {
	if [[ $1 == "" ]]; then
		git branch --list -a
	else
		git checkout $1
	fi
}

# detailed status
ggs() {
	local branch=$(git branch --show-current)
	local remote=$(git config branch.$branch.pushRemote)
	if [[ $remote == "" ]]; then; remote=$(git config remote.pushDefault); fi # otherwise, nothing
	local upstream=$(git rev-parse --abbrev-ref $branch@{upstream} 2>/dev/null)
	if [[ $? != 0 ]]; then; upstream=""; fi

	echo "--- --- ---"
	echo "Local HEAD:" $(git show --oneline --no-notes | head -n 1)
	if [[ $remote != "" ]]; then
		echo "Remote (" $remote ") HEAD:" $(git show --oneline --no-notes $remote/$branch | head -n 1)
	fi
	if [[ $upstream != "" ]]; then
		echo "Upstream (" $upstream ") HEAD:" $(git show --oneline --no-notes $upstream | head -n 1)
	fi
	echo "--- --- ---"
	git status
}

### GITHUB ###
# assumes that gh is a registered remote repo

alias ghpp='git push -v gh'
alias ghpf='git pull -v gh'

# sets the current branch's remote to the given github repository
ghrs() {
	if [[ $1 == "" || $2 == "" ]]; then
		echo "ghrs usage: ghrs (username) (repository)"
		return
	fi
	git remote add gh git@github.com:$1/$2
	git config branch.$(git branch --show-current).pushRemote gh
	git branch --set-upstream gh/$(git branch --show-current)
}

# sets the current branch's upstream to whatever branch is specified here from the 'gh' remote
ghbu() {
	git branch -u gh/$1
}

### ETC ###
alias alsamixer='alsamixer -g'
alias scroth='/bin/scrot -s screen.png'
alias scrot='/bin/scrot -s ~/screenshots/%Y-%m-%d_scrot.png'
alias scrot-clip='/bin/scrot -e "xclip -in $f"'

#-bg #1d1f21 \

alias emacs-term='urxvt \
+sb \
-b 0 \
-fn "xft:Monoid:pixelsize=12,xft:FontAwesome:pixelsize=12" \
-letsp -1 \
-fg #c5c8c6 \
-bg #111111 \
-color0 #1d1f21 \
-color8 #969896 \
-color1 #cc6666 \
-color9 #cc6666 \
-color2 #b5bd68 \
-color10 #b5bd68 \
-color3 #f0c674 \
-color11 #f0c674 \
-color4 #81a2be \
-color12 #81a2be \
-color5 #b294bb \
-color13 #b294bb \
-color6 #8abeb7 \
-color14 #8abeb7 \
-color7 #c5c8c6 \
-color15 #ffffff \
-e emacs -nw'

### BYOND ###
source ~/BYOND-513/bin/byondsetup

### ENV VARS ###
if [ $TERM = "linux" ]; then
	PS1=' %~ > '
else
	PS1='%~ > '
fi

export EDITOR=vim
