
# Table of Contents

1.  [Configuration Backup](#org6b0f583)
    1.  [How to use GNU Stow](#orgf9edb70)
        1.  [Configuration directory structure](#orgc03b5b0)
        2.  [Applying configuration](#org29c927b)
        3.  [Problem 1: Doom Emacs Revert to Vanilla Emacs](#orgb639607)
        4.  [Problem 2: Doom Emacs custom configuration has no effect](#org367e69c)


<a id="org6b0f583"></a>

# Configuration Backup

This is the guide to reuse configuration of various app.
The dependency is a GNU Stow to create symlink. Take a note that Stow will symlink following the directory structure.


<a id="orgf9edb70"></a>

## How to use GNU Stow


<a id="orgc03b5b0"></a>

### Configuration directory structure

The structure of symlink will follow how the configuration inside &ldquo;dotfiles&rdquo; is arranged.

~/dotfiles   
├── doom   
│ . . │   
│ . . ├── .config/doom/config.el   
│ . . │   
│ . . └── .config/doom/init.el   
│   
├── ghostty   
│ . . │   
│ . . └── .config/ghostty/config   
│   
└── &hellip;   


<a id="org29c927b"></a>

### Applying configuration

    cd ~/dotfiles
    stow -t ~ doom
    stow -t ~ zsh
    stow -t ~ wezterm
    stow -t ~ ghostty
    ...


<a id="orgb639607"></a>

### Problem 1: Doom Emacs Revert to Vanilla Emacs

When executing command &ldquo;emacs -nw&rdquo; or &ldquo;emacs&rdquo;, sometimes system is creating directory &ldquo;~/.emacs.d/\*&rdquo; unintentionally by user.
The &ldquo;~/.emacs.d&rdquo; directory was used by older version of Emacs to save its configuration, but the latest vanilla Emacs and Doom Emacs is using XDG environment variable that put the configuration of application inside &ldquo;~/.config/emacs&rdquo; directory.

**Solution** : run command to create symbolic link with command below!

    ln -s ~/.config/emacs ~/.emacs.d

The system won&rsquo;t replace existing &ldquo;~/.emacs.d&rdquo; symlink, but will use the symlink which will trace back to &ldquo;~/.config/emacs&rdquo; and use the configuration files inside.


<a id="org367e69c"></a>

### Problem 2: Doom Emacs custom configuration has no effect

The problem of automatically directory creation of &ldquo;~/.emacs.d/\*&rdquo; also happen for &ldquo;~/.doom.d/\*&rdquo;. This will hinder Doom manual costumization.

**Solution** : run command to create symbolic link with command below!

    ln -s ~/.config/doom ~/.doom.d

