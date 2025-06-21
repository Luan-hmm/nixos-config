{ config, pkgs, ... }:

{
  home.username = "luanhmm";
  home.homeDirectory = "/home/luanhmm";

  home.stateVersion = "25.05";

  programs.zsh.enable = true;
  programs.git.enable = true;

  home.packages = with pkgs; [
    #starship
    #neofetch
  ];
}
