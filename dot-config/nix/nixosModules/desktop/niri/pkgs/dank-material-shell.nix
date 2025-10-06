{
  quickshell,
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "dank-material-shell";
  version = "e24ddb804da7482af9db1b6893209fc47a43b753";

  src = fetchFromGitHub {
    owner = "AvengeMedia";
    repo = "DankMaterialShell";
    rev = "${version}";
    sha256 = "sha256-am7/XCvi6epD6I88o+o9tgOyfkrnmBTXM10uMpCbz58=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/dank-material

    cp -r $src $out/share/dank-material/shell
    cat > $out/bin/dms-shell << EOF
    #!/usr/bin/env sh
    ${quickshell}/bin/quickshell --path $out/share/dank-material/shell \$@
    EOF
    chmod +x $out/bin/dms-shell

    patchShebangs $out/bin/dms-shell

    runHook postInstall
  '';

  meta = {
    description = "Quickshell optimized for niri & hyprland.";
    homepage = "https://github.com/AvengeMedia/DankMaterialShell";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
