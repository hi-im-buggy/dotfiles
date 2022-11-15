#############
# ~/.bashrc #
#############

files=(
	~/.bash_defaults
	~/.env
	~/.bash_aliases
	~/.customfunctions
	# fzf - the fuzzy finder
	/usr/share/fzf/key-bindings.bash
	/usr/share/fzf/completion.bash
	~/.fzf.bash
	# tmux-nvr
	~/.tmux-nvr-setup.bash
	# git
	/etc/bash_completion.d/git-extras
)

# NOTE:
# Shell expansion of `~` happens after variable expansion,
# which is why the filename identifiers in the array above
# are left unquoted. Using $HOME is the way to go if the
# filenames need to be in quotes for some reason.

for file in ${files[@]}; do
	[[ -f "$file" ]] && source "$file"
done


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/buggy/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/buggy/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/buggy/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/buggy/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

