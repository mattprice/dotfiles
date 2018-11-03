# mattprice's dotfiles

This repository contains my macOS and Ubuntu 18.04 (GNOME) configurations, powered by [Dotbot](https://github.com/anishathalye/dotbot) and years of procrastination.

To install it, clone the repository and run: `./install`.

## Sudo With Touch ID

If you have a MacBook with Touch ID, you may also want to [enable sudo using your fingerprint](https://twitter.com/cabel/status/931292107372838912) by editing `/etc/pam.d/sudo` and adding the following line to the top:

```text
auth       sufficient     pam_tid.so
```

## Ubuntu Post-Install Steps

1. To finish setting up `vanilla-gnome-desktop`, log out and select "GNOME on Xorg" from the settings menu before logging back in.
2. Install [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/).
3. Enable shell and icon themes using Gnome Tweaks.
