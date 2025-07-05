{ pkgs, lib, ... }:

{
  ############################################################
  # Shell principal: Zsh
  ############################################################
  programs.zsh = {
    enable = true;

    autosuggestion.enable         = true;
    syntaxHighlighting.enable     = true;
    historySubstringSearch.enable = true;

    history = {
      ignoreDups = true;
      save       = 10000;
      size       = 10000;
    };

    shellAliases = {
      ls  = "eza -T";
      cat = "bat";
      cd  = "z";
    };
  };

  ############################################################
  # Navegação inteligente: zoxide
  ############################################################
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "z" ];
  };

  ############################################################
  # Substituto do ls: eza
  ############################################################
  programs.eza = {
    enable = true;

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--git-ignore"
      "--icons=always"
    ];
  };

  ############################################################
  # Substituto do cat: bat (+ bat-extras)
  ############################################################
  programs.bat = {
    enable = true;

    config = {
      pager = "less -FR";  # fecha se couber na tela, respeita cores
    };

    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
      batgrep
    ];
  };

  ############################################################
  # Fuzzy finder: fzf com integração ao Zsh e preview em bat
  ############################################################
  programs.fzf = {
    enable               = true;
    enableZshIntegration = true;

    # Paleta simples (pode ajustar depois)
    colors = lib.mkForce {
      "fg+"     = "#8ec07c";
      "bg+"     = "-1";
      "fg"      = "#ebdbb2";
      "bg"      = "-1";
      "prompt"  = "#458588";
      "pointer" = "#d3869b";
    };

    defaultOptions = [
      "--margin=1"
      "--layout=reverse"
      "--border=none"
      "--info=hidden"
      "--header="
      "--prompt=/ "
      "-i"
      "--no-bold"
      "--bind=enter:execute(nvim {})"
      "--preview=bat --style=numbers --color=always --line-range :500 {}"
      "--preview-window=right:60%:wrap"
    ];
  };

  ############################################################
  # Pacotes auxiliares (garantem binários usados nos aliases e fzf)
  ############################################################
  home.packages = with pkgs; [
    eza
    bat
    fzf
    zoxide
    neovim            # usado pelo --bind do fzf
  ];
}
