# dotfiles aliases
# 이 파일은 ~/.zshrc, ~/.bashrc에서 source됩니다.

# dotfiles 변경사항 pull + tmux conf 리로드 (tmux 켜져 있을 때만 reload 수행)
alias dotpull='cd ~/dotfiles && git pull && tmux source-file ~/.tmux.conf 2>/dev/null; echo "✔ dotfiles updated"'

# 현재 tmux 서버에 conf 리로드만 적용
alias tmr='tmux source-file ~/.tmux.conf && echo "✔ tmux.conf reloaded"'
