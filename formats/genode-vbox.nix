{ config, lib, pkgs, modulesPath, ... }:

let flake = getFlake "genodepkgs";
in {
  imports = [

    flake.nixosModules.vbox

    "${modulesPath}/virtualisation/virtualbox-image.nix"

    {
      system.build.virtualBoxVDI =
        import "${modulesPath}/../lib/make-disk-image.nix" {
          inherit pkgs lib config;
          diskSize = config.virtualbox.baseImageSize;
          partitionTableType = "legacy";
          fsType = "ext4";
          name = "nixos-${pkgs.stdenv.hostPlatform.system}.vdi";
          format = "vdi";
        };
    }

  ];

  formatAttr = "genodeDiskImage";
}
