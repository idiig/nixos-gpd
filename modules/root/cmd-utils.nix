{
  pkgs,
  ...
}: 

{

  environment.systemPackages = with pkgs; [

    # Text Processing
    # Docs: https://github.com/learnbyexample/Command-line-text-processing
    gnugrep # GNU grep, provides `grep`/`egrep`/`fgrep`
    gnused # GNU sed, very powerful(mainly for replacing text in files)
    gawk # GNU awk, a pattern scanning and processing language
    jq # A lightweight and flexible command-line JSON processor
    silver-searcher # Ag
    ripgrep
    fd
    fzf # fuzzy search
    ranger
    lsof
    tmux
    eza
    
    # misc
    neofetch
    wget
    curl
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    file
    findutils
    which
    tree
    gnutar
    rsync
    gnumake
    openssl

    gcc
    cmake

    # cmd apps
    htop  # monitor
    flameshot # A command-line screen capture utility
  ];

}
