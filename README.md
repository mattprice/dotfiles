# mattprice's dotfiles

This repository contains (most of) my macOS configuration, powered by [Dotbot](https://github.com/anishathalye/dotbot) and years of procrastination.

To install it, clone the repository and run: `./install`.

## Sudo With Touch ID

If you have a MacBook with Touch ID, you may also want to [enable sudo using your fingerprint](https://twitter.com/cabel/status/931292107372838912) by editing `/etc/pam.d/sudo` and adding the following line to the top:

```text
auth       sufficient     pam_tid.so
```
