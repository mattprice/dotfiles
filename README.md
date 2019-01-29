# mattprice's dotfiles

This repository contains my macOS and Ubuntu 18.04 (GNOME) configurations, powered by [Dotbot](https://github.com/anishathalye/dotbot) and years of procrastination.

To install it, clone the repository and run: `./install`.

## Sudo With Touch ID

If you have a MacBook with Touch ID, you may also want to [enable sudo using your fingerprint](https://twitter.com/cabel/status/931292107372838912) by editing `/etc/pam.d/sudo` and adding the following line to the top:

```text
auth       sufficient     pam_tid.so
```

## Ubuntu Post-Install

To finish setting up `vanilla-gnome-desktop`, log out and select "GNOME on Xorg" from the settings menu before logging back in. Then, enable the shell, icon, and application themes using Gnome Tweaks.

### Suggested Applications

- Calendar: [MineTime](https://minetime.ai)
- Dock: [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
- Email: [Mailspring](https://getmailspring.com)
- GNOME Terminal Theme: [One Dark Theme](https://github.com/denysdovhan/one-gnome-terminal)
- Git: [Gitg](https://wiki.gnome.org/Apps/Gitg)
- Image Editing: [Krita](https://krita.org/)
- Screen Recording: [Green Recorder](https://github.com/foss-project/green-recorder)
- Text Expansion: [AutoKey](https://github.com/autokey/autokey)
