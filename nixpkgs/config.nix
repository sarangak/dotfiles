{
  packageOverrides = pkgs: rec {
    nix-npm-install = pkgs.writeScriptBin "nix-npm-install" ''
      #!/usr/bin/env bash
      tempdir="/tmp/nix-npm-install/$1"
      mkdir -p $tempdir
      pushd $tempdir
      # note the differences here:
      ${pkgs.nodePackages.node2nix}/bin/node2nix --input <( echo "[\"$1\"]")
      nix-env --install --file .
      popd
    '';
  };
}