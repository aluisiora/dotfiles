{
  quickshell,
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "end-4-dots-hyprland";
  version = "unstable-2025-09-10";

  src = fetchFromGitHub {
    owner = "end-4";
    repo = "dots-hyprland";
    rev = "f648137a8e338223170c1cfd7deb159a74b7da7e";
    sha256 = "sha256-efQZH6cc99xjaSmc+4bfaEFpg80C35SLz8svs7Vhiwo=";
  };

  dontPatchShebangs = true;

  postInstall = ''
    substituteInPlace $out/share/illogical-impulse/shell/Translation.qml \
      --replace "Directories.config + \"/quickshell/translations/\"" "\"$out/share/illogical-impulse/translations\""
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/illogical-impulse

    cp -r $src/.config/quickshell/ii $out/share/illogical-impulse/shell
    cp -r $src/.config/quickshell/translations $out/share/illogical-impulse/translations
    cat > $out/bin/illogical-impulse << EOF
    #!/usr/bin/env sh
    ${quickshell}/bin/quickshell --path $out/share/illogical-impulse/shell
    EOF
    chmod +x $out/bin/illogical-impulse

    patchShebangs $out/bin/illogical-impulse

    runHook postInstall
  '';

  meta = {
    description = "Rice built for usability";
    homepage = "https://end-4.github.io/dots-hyprland-wiki/en/";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
