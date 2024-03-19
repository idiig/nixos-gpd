_:

{
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Flakes etc.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ]; 
}
