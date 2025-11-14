# Dotfiles


## Setup

```
git clone git@github.com:adam-r-kowalski/dotfiles.git ~/dotfiles
cd ~/.config
ln -s ~/dotfiles/nvim .
ln -s ~/dotfiles/tmux .
```


## Language server protocol

### Lua

```
brew install lua-language-server
```

### Rust

```
brew install rust-analyzer
```

### WGSL

```
git clone https://github.com/wgsl-analyzer/wgsl-analyzer.git
cd wgsl-analyzer
cargo build --release -p wgsl-analyzer
```

ensure that wgsl-analyzer/target/release is in your path


## Tree sitter
