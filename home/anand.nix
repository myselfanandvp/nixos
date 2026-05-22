{ config, pkgs, inputs, ... }:

{
  home.username = "anand";
  home.homeDirectory = "/home/anand";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    vim
  ];
programs.git = {
enable = true;
settings.user.name = "myselfanandvp";
settings.user.email = "mailanandvp@gmail.com";
settings.extraConfig = {
    init.defaultBranch = "main";
    safe.directory = "etc/nixos";
  };


};
}
