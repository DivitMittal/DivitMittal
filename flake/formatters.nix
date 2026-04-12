{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    settings.global = {
      excludes = [
        ".github/*"
        "README.md"
        "AGENTS.md"
        "*.svg"
      ];
    };

    flakeCheck = false;

    programs = {
      ## Nix
      alejandra.enable = true;
      deadnix.enable = true;
      statix.enable = true;
    };
  };
}
