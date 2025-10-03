{
  lib,
  stdenv,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "gabarito";
  version = "1.000";

  src = fetchzip {
    url = "https://github.com/naipefoundry/gabarito/releases/download/v${version}/gabarito-fonts.zip";
    sha256 = "hIK8YwxwUDnid6OnW2GyYYUDi72THMsWRj6w83s2lSc=";
  };

  installPhase = ''
    runHook preInstall

    install -d $out/share/fonts/truetype
    install -m444 -t $out/share/fonts/truetype $src/fonts/ttf/*.ttf
    install -m444 -t $out/share/fonts/truetype $src/fonts/variable/*.ttf

    runHook postInstall
  '';

  meta = with lib; {
    description = "Gabarito is a light-hearted geometric sans typeface with 6 weights ranging from Regular to Black originally designed for an online learning platform in Brazil.";
    homepage = "https://github.com/naipefoundry/gabarito";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
