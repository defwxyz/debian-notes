# notes

[debian](debian.md) * [haskell](haskell.md)

### Rocky Linux 8

#### pandoc notes

```bash
sudo dnf install epel-release
sudo dnf config-manager --set-enabled powertools
sudo dnf install pandoc
```
To write markdown for literate haskell use '=' instead of '#' in section prefix, and then use:

```
pandoc -f markdown+lhs some.md
```


