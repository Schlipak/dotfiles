# Path to Oh My Fish install.
set -gx OMF_PATH "/home/schlipak/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Remove greeting
set -e fish_greeting

# Update PATH
set -gx PATH $PATH /home/$USER/bin /home/$USER/.gem/ruby/2.3.0/bin
set -gx LIBRARY_PATH $LIBRARY_PATH /usr/local/lib
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH $LIBRARY_PATH

# Load personal config
set -gx VISUAL emacs
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -e DESKTOP_SESSION

source /home/schlipak/.config/fish/functions/aliases.fish
source /home/schlipak/.config/fish/functions/colorscheme.fish

# TheFuck
eval (thefuck --alias | tr '\n' ';')
