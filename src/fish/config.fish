# Path to Oh My Fish install.
set -gx OMF_PATH "/home/schlipak/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Remove greeting
set -e fish_greeting

# Update PATH
set -gx PATH $PATH /home/$USER/bin /home/$USER/.gem/ruby/2.3.0/bin

# Load personal config
set -gx VISUAL emacs

source /home/schlipak/.config/fish/functions/aliases.fish
source /home/schlipak/.config/fish/functions/colorscheme.fish
