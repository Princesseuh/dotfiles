
function launch-sway --description 'Set various environment variables for Wayland compatibility and launch Sway'
    set -x QT_QPA_PLATFORM wayland
    set -x QT_QPA_PLATFORMTHEME qt5ct
    set -x CLUTTER_BACKEND wayland

    exec sway
end
