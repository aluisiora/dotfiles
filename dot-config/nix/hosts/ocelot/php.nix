{ pkgs, ... }:
let
  composerEnv = pkgs.php84Packages.composer;
  phpEnv = pkgs.php84.buildEnv {
    extensions = ({ enabled, all }: enabled ++ (with all; [
      bcmath
      ctype
      curl
      dom
      fileinfo
      gd
      grpc
      intl
      mbstring
      memcached
      openssl
      opentelemetry
      pdo
      pdo_mysql
      pdo_sqlite
      protobuf
      redis
      session
      sockets
      tokenizer
      xdebug
      zip
    ]));
    extraConfig = ''
      memory_limit = 4G
      xdebug.mode=develop,coverage,debug
      xdebug.start_with_request=trigger
    '';
  };
in
{
  environment.systemPackages = [ phpEnv composerEnv pkgs.memcached ];
}
