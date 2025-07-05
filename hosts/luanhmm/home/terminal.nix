{ pkgs, ... }:

{
  # Shell principal
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "pattern" "regexp" "root" "line" ];
    };
    historySubstringSearch.enable = true;
    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };
    shellAliases = {
      ls = "eza --icons";
      cat = "bat";
      cd = "z";
    };
  };

  # Navegação inteligente
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ];  # permite usar "cd" como atalho pro z
  };

  # Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Ferramentas auxiliares
  home.packages = with pkgs; [
    eza
    bat
  ];
}
