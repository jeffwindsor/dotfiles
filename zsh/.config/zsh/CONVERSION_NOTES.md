# Nushell to Zsh Conversion Notes

## Files Created

### Main Configuration
- **`zsh/.zshrc`** - Main Zsh configuration file with:
  - Zinit plugin manager setup
  - Zsh options (history, completion, keybindings)
  - Environment variables (XDG, SOURCE, HOMEBREW, ARGC)
  - PATH configuration
  - Core `cdl` function (needed by aliases)
  - Module loading
  - External integrations (fzf, starship, mise)

### Module Files
- **`zsh/.config/zsh/aliases.zsh`** - All shell aliases
- **`zsh/.config/zsh/functions.zsh`** - All custom functions

## Key Conversions

### Environment Variables
All Nushell `$env.VAR` converted to Zsh `export VAR`:
```zsh
# Nushell: $env.EDITOR = "nvim"
# Zsh:     export EDITOR="nvim"
```

### PATH Management
Nushell's PATH manipulation converted to Zsh array syntax:
```zsh
# Zsh uses lowercase 'path' array that syncs with $PATH
path=(
  "/opt/homebrew/bin"
  "${ARGC_COMPLETIONS_ROOT}"
  "${HOME}/.local/bin"
  $path  # Existing path entries
)
export PATH
```

### Functions
All Nushell `def` functions converted to Zsh functions:
```zsh
# Nushell: def funcname [] { ... }
# Zsh:     funcname() { ... }
```

### Aliases
All Nushell aliases converted to Zsh aliases:
```zsh
# Nushell: alias x = eza
# Zsh:     alias x='eza'
```

### Color Functions
Nushell's `ansi` colors converted to ANSI escape codes:
```zsh
colorize() {
  case "$color" in
    red) echo -e "\033[31m${text}\033[0m" ;;
    green) echo -e "\033[32m${text}\033[0m" ;;
    # ...
  esac
}
```

## Notable Pattern Changes

### Piping and Command Substitution
```bash
# Nushell: let var = (command | parse | filter)
# Zsh:     local var=$(command | awk | grep)
```

### Conditionals
```bash
# Nushell: if ($var | is-empty)
# Zsh:     if [[ -z "$var" ]]
```

### String Interpolation
```bash
# Nushell: $"text ($var) more"
# Zsh:     "text ${var} more"
```

### Path Operations
```bash
# Nushell: $env.HOME | path join "subdir"
# Zsh:     "${HOME}/subdir"
```

### Array/List Operations
```bash
# Nushell: $list | sort | lines | to text
# Zsh:     echo "$list" | sort
```

## Functions Requiring External Tools

Some functions rely on external tools that need to be installed:

- **`tv`** - Terminal viewer (assumed to be installed)
- **`bat`** - Better cat
- **`fd`** - Better find
- **`rg`** - Ripgrep
- **`eza`** - Modern ls replacement
- **`lazygit`** - Git TUI
- **`yazi`** - File manager
- **`zellij`** - Terminal multiplexer
- **`mise`** - Runtime manager
- **`stow`** - Symlink manager

## Testing the Configuration

### 1. Source the new configuration
```bash
source ~/Source/github.com/jeffwindsor/dotfiles/zsh/.zshrc
```

### 2. Test environment variables
```bash
echo $EDITOR        # Should show: nvim
echo $DOTFILES      # Should show: /Users/jefwinds/Source/github.com/jeffwindsor/dotfiles
echo $SOURCE_JEFF   # Should show: /Users/jefwinds/Source/github.com/jeffwindsor
```

### 3. Test aliases
```bash
type d    # Should show: d is aliased to `cdl $DOTFILES'
type v    # Should show: v is aliased to `nvim'
type gg   # Should show: gg is aliased to `lazygit'
```

### 4. Test functions
```bash
type cdl           # Should show function definition
type section       # Should show function definition
type brew-diff     # Should show function definition
```

### 5. Test color functions
```bash
section "Test Section"
info "Test info message"
warning "Test warning"
success "Test success"
fail "Test failure"
```

## Stow Deployment

To deploy the zsh configuration:
```bash
cd ~/Source/github.com/jeffwindsor/dotfiles
stow zsh
```

This will create a symlink from `~/.zshrc` to your dotfiles repository.

## Differences from Nushell

### What's Different
1. **No structured data** - Zsh uses text streams instead of tables
2. **No built-in parsing** - Need external tools (awk, sed, grep)
3. **Different string handling** - Quoting is more important
4. **Array syntax** - Different from Nushell lists
5. **No type system** - Everything is strings

### What's the Same
1. All environment variables preserved
2. All aliases preserved
3. All functions converted with equivalent logic
4. Directory structure follows XDG standards
5. Modular configuration approach

## Next Steps

1. **Backup your current ~/.zshrc** if you have one
2. **Test the new configuration** in a new shell session
3. **Deploy with stow** once satisfied
4. **Adjust color codes** if your terminal requires different ANSI codes
5. **Install missing tools** (tv, bat, fd, rg, eza, etc.)

## Known Limitations

1. **`tv` command** - Assumed to be a terminal viewer, implementation unknown
2. **Regex parsing** - Some complex Nushell regex operations simplified
3. **Error handling** - Some Nushell error handling converted to basic checks
4. **Interactive prompts** - Zsh `read` works differently than Nushell `input`

## Troubleshooting

### If aliases don't work
- Ensure `cdl` function is loaded before aliases
- Check that all environment variables are set

### If functions fail
- Check if external tools are installed (bat, fd, rg, etc.)
- Verify PATH includes necessary directories

### If colors don't show
- Your terminal may need different ANSI escape codes
- Try adjusting the `colorize` function

### If sourcing fails
- Check syntax: `zsh -n ~/.zshrc`
- Look for missing closing quotes or braces
- Verify file paths exist
