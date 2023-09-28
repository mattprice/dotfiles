# mattprice's dotfiles

This repository contains my macOS and WSL configurations, powered by [Dotbot](https://github.com/anishathalye/dotbot) and years of procrastination.

To install it, clone the repository and run: `./install`.

## macOS Post-Install

### Hotkey to Select the Current Word

Pressing Cmd+D to select the current word is one of my favorite text editor features, and it's snuck into my muscle memory. You can [set up a system-wide hotkey](https://mattprice.me/2015/osx-hotkey-select-current-word/) in `~/Library/Keybindings/DefaultKeyBinding.dict` that does the same, but unfortunately, macOS doesn't like that file to be a symlink:

```swift
{
  "@d" = (selectWord:);
}
```

### Sudo With Touch ID

If you have a MacBook with Touch ID, you can [enable sudo using your fingerprint](https://twitter.com/cabel/status/931292107372838912) by editing `/etc/pam.d/sudo` and adding the following line to the top:

```text
auth       sufficient     pam_tid.so
```
