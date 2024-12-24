## Tools
1. Clone this repository in user home.
2. Add the following to `.bashrc`/`.zshrc`:
```bash
if [ -f "$HOME/scripts/tools_aliases.sh" ]; then
	source "$HOME/scripts/tools_aliases.sh"
fi
```
3. Add scripts to tools and they'll be sourced in as aliases named after the script. 
