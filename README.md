# linux-bootstrap

Bootstrap an Ubuntu/Debian based system effortlessly. This script is idempotent, allowing you to re-run it at any time. Existing changes are detected and ignored, and you are only prompted for uninstalled changes.

## Why?

When you first login to a new linux box, you have many default packages you typically install:

- Your [dotfiles](https://github.com/drmikecrowe/dotphiles)
- [nodenv](https://github.com/nodenv/nodenv)
- Standard utilities like `git`, midnight commander, `jq`, `direnv` [(here's my article on it)](https://dev.to/drmikecrowe/direnv-take-control-of-your-development-environment-1dk), etc

I've experimented with multiple ways to do this (and there are many). This seems to be the easiest way to maintain and expand as your preferences change.

## Adapting to Your Needs

- Fork the repo (natually)
- If you want to use some/all of my defaults:
  - Remove whatever packages you don't want out of `src/tasks/all.sh` (and delete those files in `src/tasks/___.sh`)
- If you would like to start from scratch:
  - Setup my repo as a remote: `git remote add drmikecrowe https://github.com/drmikecrowe/linux-bootstrap.git`
  - Checkout the `blank` branch: `git checkout -b blank drmikecrowe/blank`
  - Make your changes
  - Push your changes back to _your_ master: `git push origin blank:master`
  - If you get a `blank -> master (non-fast-forward)` message:
    - Force-push your update: `git push origin blank:master --force`

**NOTE**: Make sure to read the [Default GUI Packages](#default-gui-packages) section below

## Adding New Items

The genius of this system is how easy it is to add new items:

- Run the `./stub.sh abc` to add `abc` as `src/tasks/abc.sh`
- Edit `src/tasks/abc.sh`:
  - Add a test to determine if `abc` is already installed
  - Add the code to install it
- Build using `./build.sh` and push to your repo
- If you use the `cat <<EOF >>somefile` in the install function, you need to use `EOF` to terminate your block of lines (see [How it works](#how-it-works) below)

## Default GUI Packages

Whenever I find a new GUI package that I always want on any system, I add it to `src/tasks/default_gui_packages.sh` as follows:

- Add the package on line 11 to the end of the `sudo apt install`
- Use that packages executable to in the test in line 6 so it's missing the next time you run

## Running

Download the main script and make it executable:

```
wget -q https://raw.githubusercontent.com/drmikecrowe/linux-bootstrap/master/target/bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh all
```

You can see all the options as follows:

```
./bootstrap.sh
```

You can also install a single item like this:

```
./bootstrap.sh goenv
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

## How it works

- Each task you answer (Y)es to writes the install steps from each install function (such as `install_dotfiles`) to `~/_todo.sh`
- All the commands in `~/_todo.sh` are run to install your choices
- This system takes advantage of the bash `type` command. Each install script has this line:

```
type install_goenv | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
```

- This line essentially prints the install function, then I use `sed` to remove the function declarations and leading spaces
- I like using the `cat <<EOF >>somefile` when writing lots of lines. Unfortunately, [Bashing](https://github.com/xsc/bashing) indents the code when it builds the `target/bootstrap.sh`, so my `./build.sh` makes sure that any `EOF` on a line by itself has no leading spaces
