{
  pkgs,
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "sddm-rose-pine-theme";
  version = "1.2";
  dontBuild = true;

  propagatedUserEnvPkgs = [
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];

  src = fetchFromGitHub {
    owner = "lwndhrst";
    repo = "sddm-rose-pine";
    rev = "v${version}";
    sha256 = "+WOdazvkzpOKcoayk36VLq/6lLOHDWkDykDsy8p87JE=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';

  meta = {
    description = "The sweetest dark theme around for SDDM, the Simple Desktop Display Manager.";
    homepage = "https://github.com/lwndhrst/sddm-rose-pine";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
