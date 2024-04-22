{ pkgs, ... }:
let
  pythonEnv = pkgs.python311.withPackages (python-packages: with python-packages; [
    numpy
    pandas
    epc
    scipy
    matplotlib
    ipython
    jupyter
    python-lsp-server
  ]);
in
{
  home.sessionPath = [ "${pythonEnv}/bin" ];
  home.packages = [ pythonEnv ];
}

# { pkgs, ... }: 

# {
#   home.packages = [
#     (pkgs.python311.withPackages (
#       ppkgs: with ppkgs [
#         numpy
#         pandas
#         epc
#         scipy 
#         matplotlib 
#         Pillow 
#         ipython
#         jupyter
#         python-lsp-server
#       ];
#       )
#     )
#   ];
# }
