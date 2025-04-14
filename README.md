# SCRIPTS
A collection of useful utility scripts. Each script has its own specified domain
according to where we made them.

## TOOLS
1. Clone this repository in user home.
2. Add the following to `.bashrc`/`.zshrc`:
```bash
if [ -f "$HOME/scripts/tools_aliases.sh" ]; then
	source "$HOME/scripts/tools_aliases.sh"
fi
```
3. Add scripts to tools and they'll be sourced in as aliases named after the script. 
<br>
Put scripts that you don't want an alias for in `no_alias` of their respective tools directory.

## DOCUMENTATION (WIP)
Documentation for each script are provided in each directory's `READMEs`

## Offering an improvement?
Submit a pull request with a valid reason on why the improvement should be 
incorporated.

Owners:
@agge3
@kpowkitty
