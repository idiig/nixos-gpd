_:

{
 
  # Keyboard
  console.useXkbConfig = true;
  services = {
    # xserver = {
    #   xkb = {
    #     layout = "us";
    #     options = "ctrl:nocaps";
    #   };   
    # };

    keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          # overloads the capslock key to function as both escape (when tapped) and control (when held)
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };
  };
}
