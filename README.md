# linux-bootstrap

Bootstrap an Ubuntu/Debian based system effortlessly

## Why?

When you first login to a new linux box, you have many default packages you typically install:

- Your [dotfiles](https://github.com/drmikecrowe/dotphiles)
- [nodenv](https://github.com/nodenv/nodenv)
- Standard utilities like `git`, midnight commander, `jq`, `direnv` [(here's my article on it)](https://dev.to/drmikecrowe/direnv-take-control-of-your-development-environment-1dk), etc

I've experimented with multiple ways to do this (and there are many). This seems to be the easiest way to maintain and expand as your preferences change.

## Running

```
wget -q https://raw.githubusercontent.com/drmikecrowe/linux-bootstrap/master/target/bootstrap-1.0.0.sh
bash bootstrap-1.0.0.sh all
```

## Demonstration

![Peek 2020-04-02 20-32.gif](/resources/Peek 2020-04-02 20-32.gif)
