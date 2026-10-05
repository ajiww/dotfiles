# Flatpak alias
alias brave="flatpak run com.brave.Browser --ozone-platform=x11 --disable-features=UseOzonePlatform"
alias drawio="flatpak run com.jgraph.drawio.desktop"
alias gimp="flatpak run org.gimp.GIMP"
alias inkscape="flatpak run org.inkscape.Inkscape"
alias jabref="flatpak run org.jabref.jabref"
alias obs="flatpak run com.obsproject.Studio"
alias okular="flatpak run org.kde.okular"
alias pdfarranger="flatpak run com.github.jeromerobert.pdfarranger"
alias wezterm="flatpak run org.wezfurlong.wezterm"
alias zotero="env -u GTK_PATH -u GDK_PIXBUF_MODULE_FILE -u LD_LIBRARY_PATH flatpak run org.zotero.Zotero"

# Snap alias
#alias firefox="snap run firefox --env=MOZ_DISABLE_CSD=1"
alias firefox="flatpak run org.mozilla.firefox --env=MOZ_DISABLE_CSD=1"

# System alias
#alias nvim="/usr/bin/nvim"
#alias vim="nvim"
#alias vi="nvim"
