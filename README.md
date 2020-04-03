# linux-bootstrap

Bootstrap an Ubuntu/Debian based system effortlessly

## Why?

When you first login to a new linux box, you have many default packages you typically install:

- Your [dotfiles](https://github.com/drmikecrowe/dotphiles)
- [nodenv](https://github.com/nodenv/nodenv)
- Standard utilities like `git`, midnight commander, `jq`, `direnv` [(here's my article on it)](https://dev.to/drmikecrowe/direnv-take-control-of-your-development-environment-1dk), etc

I've experimented with multiple ways to do this (and there are many). This seems to be the easiest way to maintain and expand as your preferences change.

## Running

Download the main script and make it executable:

```
wget -q https://raw.githubusercontent.com/drmikecrowe/linux-bootstrap/master/target/bootstrap-1.0.0.sh
chmod +x bootstrap-1.0.0.sh
./bootstrap-1.0.0.sh all
```

You can see all the options as follows:

```
./bootstrap-1.0.0.sh
```

You can also install a single item like this:

```
./bootstrap-1.0.0.sh goenv
```

## Demonstration

![Peek 2020-04-02 20-32.gif](https://github.com/drmikecrowe/linux-bootstrap/blob/master/resources/Peek%202020-04-02%2020-32.gif)

## Key concepts

This script uses [Bashing](https://github.com/xsc/bashing) to create the executable.

The key things I like to install are:

- [My dotfiles](https://github.com/drmikecrowe/dotphiles.git)
- [Bash-it](https://github.com/Bash-it/bash-it.git)
- Node via nodenv
- Go via goenv
- Python via pyenv
- [xonsh](https://xon.sh)
- docker
- AWS cli
- etckeeper
- Increase fs.inotify.max_user_watches by increasing to 524288
- Remove password prompt when executing `sudo`

If it's a GUI based system:

- Install my favorite GUI packages like `glogg` `meld` `synaptic` `kupfer` `remmina`
- Visual Studio Code
- Opera
- Spotify
- TerraForm
- Peek gif recorder
- google-chrome
- [copyq](https://hluk.github.io/CopyQ/)
- wavebox
- etc.

## Adapting to your needs

The genius of this system is how easy it is to add new items:

- Fork the repo (natually)
- Run the `./stub.sh abc` to add `abc` as `src/tasks/abc.sh`
- Edit `src/tasks/abc.sh`:
  - Add a test to determine if `abc` is already installed
  - Add the code to install it
- Build using `./build.sh` and push to your repo

## Innards

- Each task you answer (Y)es to writes the install steps from each install function (such as `install_dotfiles`) to `~/_todo.sh`
- Run all the commands in `~/_todo.sh`
