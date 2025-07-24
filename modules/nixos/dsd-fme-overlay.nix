# /etc/nixos/modules/nixos/dsd-fme-overlay.nix
{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Digital Speech Decoder - Florida Man Edition
      dsd-fme = prev.stdenv.mkDerivation rec {
        pname = "dsd-fme";
        version = "unstable-2025-07-14";

        src = prev.fetchFromGitHub {
          owner = "lwvmobile";
          repo = "dsd-fme";
          # From the GitHub page you found, this is the latest commit as of today
          rev = "698a991f8ef4e1121d532f144358509c1356e9c6";
          # We'll use the same trick to get the correct hash
          hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };

        # These are build-time tools needed
        nativeBuildInputs = [ prev.cmake ];

        # These are the libraries the program needs to build and run
        buildInputs = with prev; [
          mbelib      # Required for AMBE voice decoding
          libsndfile
          itpp
          rtl-sdr
          ncurses
          pulseaudio
          codec2
        ];

        meta = with prev.lib; {
          description = "Digital Speech Decoder - Florida Man Edition";
          homepage = "https://github.com/lwvmobile/dsd-fme";
          # From the COPYRIGHT file in the repository
          license = licenses.isc;
          platforms = platforms.linux;
          mainProgram = "dsd-fme";
        };
      };
    })
  ];
}
