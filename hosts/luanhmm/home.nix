{ config, pkgs, lib, ... }:

{
  imports = [
    ./home/terminal.nix
  ];

  home.username = "luanhmm";
  home.homeDirectory = "/home/luanhmm";

  home.stateVersion = "25.05";

  programs.git.enable = true;

  home.packages = with pkgs; [
    pipeline
    termusic
    yt-dlp
    (writeShellScriptBin "youtube-dl" ''
      exec ${pkgs.yt-dlp}/bin/yt-dlp "$@"
    '')
    audacity
    thunderbird
    qbittorrent-enhanced
  ];
}
