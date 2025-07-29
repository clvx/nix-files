{ pkgs, ... }:
{
programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion = {
      enable = true; 
    };
    enableCompletion = true;
    sessionVariables = {
      #PATH = "$PATH:$HOME/Code/academy/go/bin";
      #GOPATH = "$HOME/Code/academy/go"; #using default GOPATH
      #FZF_DEFAULT_COMMAND = "find . -type f -not -path '*/\.git/*'";
      DOCKER_BUILDKIT = 1;
    };
    shellAliases = {
      nocomments = "grep -v \"^#'";
      noblanks = "sed \"/^$/d\"";
      nohistory = "history | sed \"s/^\s*[0-9]*\s*\(.*\)/\1/\"";
    };
    initContent = "
eval \"$(starship init zsh)\"
eval \"$(direnv hook zsh)\"

# lua exec path is defined in ZLUA_LUAEXE inside the z.lua. 
eval \"$(/etc/profiles/per-user/clvx/bin/z.lua --init zsh)\"

function kport {
    lsof -i tcp:$1 | grep LISTEN | awk '{print $2}'
}
      
    ";
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
      ];
    };
  };
}
