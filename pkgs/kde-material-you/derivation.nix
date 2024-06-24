{ lib, python3Packages, fetchFromGitHub, fetchPypi }:
with python3Packages;

let
  materialyoucolor =
    buildPythonPackage
      rec
      {
        pname = "materialyoucolor";
        version = "2.0.9";

        src = fetchPypi {
          inherit pname version;
          hash = "sha256-J35//h3tWn20f5ej6OXaw4NKnxung9q7m0E4Zf9PUw4=";
        };
        doCheck = false;

        build-system = [
          setuptools
        ];
      };
in
buildPythonPackage rec {
  pname = "kde-material-you-colors";
  version = "1.9.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "kde-material-you-colors";
    rev = "e3e2904";
    sha256 = "0d4plxpjlp1wrjra6yvlb40rjif31vywf38vnf9nlnnzcrlkxv45";
  };
  build-system = [
    setuptools
  ];

  doCheck = false;
  dependencies = [
    dbus-python
    pywal
    numpy
    pillow
    materialyoucolor
  ];

  meta = {
    description = "Kde material you colors";
  };
}
