{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              # Basic dependencies (lazy + fzf native compilation)
              # ==================================================
              git
              cmake
              # telescope
              ripgrep

              # Neovim itself
              # =============
              neovim

              # Language servers
              # ================

              # clangd
              clang-tools
              # dockerls
              dockerfile-language-server-nodejs
              # gopls
              go gopls
              # kotlin-language-server
              kotlin-language-server
              # lua_ls
              lua-language-server
              # nixd
              nixd nixpkgs-fmt
              # eslint
              nodePackages.eslint
              # bashls
              nodePackages_latest.bash-language-server
              # pylsp
              python312Packages.flake8 python312Packages.python-lsp-server
              # vimls
              vim-language-server
            ];
          };
        }
      );
}