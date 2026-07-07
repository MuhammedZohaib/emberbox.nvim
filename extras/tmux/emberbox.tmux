# Emberbox tmux theme

set -g status-bg "#211a16"
set -g status-fg "#c8b99b"

set -g status-left "#[fg=#211a16,bg=#a9b665,bold] #S #[fg=#a9b665,bg=#211a16]"

set -g window-status-format "#[fg=#6f6252,bg=#211a16] #I:#W "
set -g window-status-current-format "#[fg=#211a16,bg=#e0b45c,bold] #I:#W #[fg=#e0b45c,bg=#211a16]"

set -g window-status-activity-style "fg=#e78a4e,bg=#211a16"
set -g window-status-bell-style "fg=#ea6962,bg=#211a16,bold"

set -g status-right "#[fg=#4d3c30,bg=#211a16]#[fg=#e6d6b8,bg=#4d3c30] %H:%M  %d %b #[fg=#e0b45c,bg=#4d3c30]#[fg=#211a16,bg=#e0b45c,bold] #h "

set -g pane-border-style "fg=#4d3c30"
set -g pane-active-border-style "fg=#e0b45c"

set -g message-style "fg=#e0b45c,bg=#362a22"
set -g message-command-style "fg=#e78a4e,bg=#362a22"

set -g mode-style "fg=#211a16,bg=#e0b45c,bold"

set -g clock-mode-colour "#e0b45c"
set -g popup-style "fg=#e6d6b8,bg=#2d241e"
set -g popup-border-style "fg=#5d493a,bg=#2d241e"

