# back — directory jump utility

(Basically, I wanted to learn shell scripting, use loops, write a function and understand IFS (internal field separator).Started to see where I could implement something small, and found this use case to learn and use for later as well.)

A function that lets you jump back to any ancestor directory by name, without having to type the entire `cd ../../` hence helping me be lazy about this task by removing repetitive `../`.



## problem

When you're deep inside a path like this:

```
/home/NOT_MY_NAME/Desktop/Projects/learn-shell/back
```
and I wanted to get to `Projects`, I'd normally type `cd ../../../../Projects` while counting the levels. This is annoying. the `back` function lets you just type the name and then navigate to where I want to go.

## usage

```zsh
back <directory-name>
```

```zsh
# say you're in /home/NOT_MY_NAME/Desktop/Projects/learn-shell/back

back Projects     # → /home/NOT_MY_NAME/Desktop/Projects
back Desktop      # → /home/NOT_MY_NAME/Desktop
back home         # → /home/NOT_MY_NAME
```

## setup

**1. clone the repo**

```zsh
git clone <your-repo-url>
```

**2. source it in your `.zshrc`**

```zsh
echo 'source /path/to/back.sh' >> ~/.zshrc
source ~/.zshrc
```

now `back` is available in EVERY terminal on my machine.

## how it works

- splits `$PWD` into an array of directory names using zsh's `${(s:/:)PWD}` NOTE: I found that I need to use this pattern for zsh; the regular `${PWD}` is sufficient for bash 
- loops through the array to find a match for the name typed
- calculates how many levels up to go
- builds a relative path by appending `/..` for each level
- runs `cd` on that path 

## what I learned

- IFS (Internal Field Separator) and how bash/zsh splits strings
- arrays in zsh — creating, looping, getting length
- `local` variables inside functions
- why you need `source` instead of `./` when a script uses `cd`
- minor (:3) understanding of the difference between bash and zsh syntax 

## notes

- only works for ancestor directories (directories above you in the path)
- for obvious reasons: it is case sensitive — `back projects` won't find `Projects`
- zsh only : NOTE: I found that I need to use `${(s:/:)PWD}` pattern for zsh; the regular `${PWD}` is sufficient for bash 