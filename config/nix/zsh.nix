{ pkgs, ... }:
{
programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    sessionVariables = {
      PATH = "$PATH:$HOME/Code/academy/go/bin";
      GOPATH = "$HOME/Code/academy/go";
      #FZF_DEFAULT_COMMAND = "find . -type f -not -path '*/\.git/*'";
      DOCKER_BUILDKIT = 1;
    };
    shellAliases = {
      nocomments = "grep -v \"^#'";
      noblanks = "sed \"/^$/d\"";
      nohistory = "history | sed \"s/^\s*[0-9]*\s*\(.*\)/\1/\"";
    };
    initExtra = "
eval \"$(starship init zsh)\"
eval \"$(direnv hook zsh)\"

function kport {
    lsof -i tcp:$1 | grep LISTEN | awk '{print $2}'
}
      
    ";
    plugins = with pkgs; [
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
          #sha256 = lib.fakeSha256; #leave hash empty if rev changes - update after it's processed
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-completions";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.34.0";
          sha256 = "sha256-qSobM4PRXjfsvoXY6ENqJGI9NEAaFFzlij6MPeTfT0o=";
          #sha256 = lib.fakeSha256; #leave hash empty if rev changes - update after it's processed
        };
        file = "zsh-syntax-highlighting.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
      ];
    };
  };
}
