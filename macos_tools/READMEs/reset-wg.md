# RESET-WG.SH
## EXPECTED SHELL
`zsh`

## DESCRIPTION
Turns off wireguard and wifi -> turns them back on.

## EXPECTATIONS
1) Can be ran from anywhere. 
2) Requires sudo.
3) Users must add `export WG=$YOUR_WIREGUARD_INTERFACE_NAME` to their .zshrc before
where the script is sourced.
