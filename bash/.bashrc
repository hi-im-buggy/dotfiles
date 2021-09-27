#############
# ~/.bashrc #
#############

files=(
	"~/.bash_defaults"
	"~/.env"
	"~/.bash_aliases"
	"~/.customfunctions"
	# fzf - the fuzzy finder
	"/usr/share/fzf/key-bindings.bash"
	"/usr/share/fzf/completion.bash"
	"~/.fzf.bash"
)

for file in ${files[@]}; do
	if test -f "$file"; then
		source "$file"
	fi
done
