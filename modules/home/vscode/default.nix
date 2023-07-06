{pkgs, ...}:
#let
#  marketplace-extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
#    bierner.github-markdown-preview
#    # codeium.codeium
#    mtxr.sqltools
#    mtxr.sqltools-driver-pg
#    mtxr.sqltools-driver-sqlite
#    rvest.vs-code-prettier-eslint
#    zixuanchen.vitest-explorer
#  ];
#in
{
  programs.vscode = with pkgs; {
    enable = true;
    package = vscode;
    mutableExtensionsDir = true;

    #    extensions = with vscode-extensions;
    #      [
    #        astro-build.astro-vscode
    #        bradlc.vscode-tailwindcss
    #        catppuccin.catppuccin-vsc
    #        catppuccin.catppuccin-vsc-icons
    #        davidanson.vscode-markdownlint
    #        dbaeumer.vscode-eslint
    #        eamodio.gitlens
    #        esbenp.prettier-vscode
    #        foxundermoon.shell-format
    #        humao.rest-client
    #        jnoortheen.nix-ide
    #        kamadorueda.alejandra
    #        mikestead.dotenv
    #        ms-vsliveshare.vsliveshare
    #        ms-python.python
    #        prisma.prisma
    #      ]
    #      ++ marketplace-extensions;

    # userSettings = import ./settings.nix
  };
}
