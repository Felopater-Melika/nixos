{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "nx";
  version = "17.1.2";

  # To update versions, go to the github, click on tags, and select whichever
  # version you want to use. Change the version variable above to match it.
  # Build the package. Then look at the error message where it says the sha256
  # hash doesn't match. Copy the correct sha256 hash from that and replace the
  # hash variable in the fetchFromGitHub below with it.
  #
  # You may also then need to update the npmDepsHash below via the same process:
  # build the package, and if there's an error copy the correct hash and replace
  # npmDepsHash with it.
  src = fetchFromGitHub {
    owner = "nrwl";
    repo = pname;
    rev = version; 
    hash = "sha256-PYSonVyclGSH3ArbqJuKrBNGbJaQEp6XemwnHboVwPk=";
  };

  npmDepsHash = "sha256-sjr4Hy1/zWPAlVGsMkyQIQcBT86KLaN2/UAaAd7Mn6Q=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  NODE_OPTIONS = "--openssl-legacy-provider";

  meta = with lib; {
    description = "Nx is a next generation build system with first class monorepo support and powerful integrations.";
    homepage = "https://github.com/nrwl/nx";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
