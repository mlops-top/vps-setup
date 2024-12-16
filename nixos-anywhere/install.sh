# https://github.com/nix-community/nixos-anywhere/issues/346
# https://github.com/nix-community/nixos-anywhere/issues/429

nix run github:nix-community/nixos-anywhere -- \
    --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
    --flake .#generic \
    --build-on-remote \
    --kexec-extra-flags "--no-ifdown" \
    --target-host root@195.200.14.118
