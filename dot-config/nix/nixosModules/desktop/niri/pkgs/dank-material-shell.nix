{
  quickshell,
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "dank-material-shell";
  version = "e6296f20b9c0ac044beb0d09b8af736db0ce10f5";

  src = fetchFromGitHub {
    owner = "AvengeMedia";
    repo = "DankMaterialShell";
    rev = "${version}";
    sha256 = "sha256-vT7laGgjhSCgJ7aO42TnegK2SkJk+B7pJGTq/XGXgkk=";
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
