{ pkgs, ...}:

{
  home.packages = with pkgs; [
    zsh
  ];
   
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      sudoe = "sudo -E HOME=$HOME";  # use user environment to edit root files
      sup = "su --preserve-environment";  # the same
      ranger = "ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd \"$LASTDIR\"";
    };
    
    initExtra = ''
      bindkey '^ ' autosuggest-accept
      AGKOZAK_CMD_EXEC_TIME=5
      AGKOZAK_COLORS_CMD_EXEC_TIME='yellow'
      AGKOZAK_COLORS_PROMPT_CHAR='magenta'
      AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' )
      AGKOZAK_MULTILINE=0
      AGKOZAK_PROMPT_CHAR=( ❯ ❯ ❮ )
      autopair-init
    '';

    plugins = with pkgs; [
      {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.7.0";
          sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
      {
        name = "formarks";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "formarks";
          rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
          sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
        };
        file = "formarks.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-abbrev-alias";
        src = fetchFromGitHub {
          owner = "momo-lab";
          repo = "zsh-abbrev-alias";
          rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
          sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
        };
        file = "abbrev-alias.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };  
 
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

}
