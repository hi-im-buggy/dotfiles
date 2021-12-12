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
	~/.tmux-nvr-setup.bash
)

# NOTE:
# Shell expansion of `~` happens after variable expansion,
# which is why the filename identifiers in the array above
# are left unquoted. Using $HOME is the way to go if the
# filenames need to be in quotes for some reason.

for file in ${files[@]}; do
	[[ -f "$file" ]] && source "$file"
done
