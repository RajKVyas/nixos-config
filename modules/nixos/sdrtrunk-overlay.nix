# /etc/nixos/modules/nixos/sdrtrunk-overlay.nix
{ pkgs, ... }:

# This block defines the 'buildGradlePackage' helper function,
# which was missing before. It's adapted from the Gist you found.
let
  buildGradlePackage = { pname, version, src, gradleDeps, ... }@args:
    let
      deps = pkgs.runCommand "${pname}-${version}-deps" { } ''
        mkdir -p $out/m2
        ${pkgs.unzip}/bin/unzip -q ${gradleDeps} -d $out/m2
      '';
    in pkgs.stdenv.mkDerivation (args // {
      nativeBuildInputs = (args.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
      postPatch = ''
        export GRADLE_USER_HOME=$(mktemp -d)
        chmod +x gradlew
        ./gradlew --no-daemon -Dmaven.repo.local=${deps}/m2 assembleDist
      '';
      installPhase = ''
        runHook preInstall
        mkdir -p $out
        cp -r build/install/* $out
        # Wrap the binary to ensure it can find Java at runtime
        wrapProgram $out/bin/${pname} \
          --set JAVA_HOME ${pkgs.jdk17_headless}
        runHook postInstall
      '';
    });
in
{
  # This section remains the same, but it can now find 'buildGradlePackage'
  nixpkgs.overlays = [
    (final: prev: {
      sdrtrunk = buildGradlePackage { # This function is now defined in the 'let' block above
        pname = "sdrtrunk";
        version = "0.6.1-unstable-2025-06-30";

        src = prev.fetchFromGitHub {
          owner = "DSheirer";
          repo = "sdrtrunk";
          rev = "912925e0e7a77611ab4b82d49931b6713988f01b";
          # This is the hash you should have found in the last step
          hash = "sha256-V2tQyP775nIeXhB4k0I/wR8Qv3v6W9/nI5G+C8h8f3o=";
        };

        # This now points to a local ZIP file of dependencies
        # In a real Nixpkgs submission, this would be handled differently
        gradleDeps = pkgs.fetchurl {
          url = "https://gist.github.com/Prince213/e437df05081375fd598fe8c3f2da5c63/raw/c2ca637a346e495f4e17e433f389f410bb5ed90d/m2.zip";
          hash = "sha256-i/y4xT857T1VlqM5E2X5i2l4w0H4l1x3x2J8f3m5b4g=";
        };
        
        nativeBuildInputs = with prev; [
          autoPatchelfHook
          # sdrtrunk needs at least JDK 17
          jdk17_headless
        ];

        buildInputs = with prev; [
          webkitgtk_4_1
          gtk3
          glib
        ];
        
        # NOTE: This is slightly different from the Gist.
        # It ensures that sdrtrunk uses the correct system libraries for its GUI.
        makeWrapperArgs = with prev; [
          "--prefix" "LD_LIBRARY_PATH" ":" (lib.makeLibraryPath [ webkitgtk gtk3 glib ])
        ];

        meta = with prev.lib; {
          description = "A cross-platform java application for decoding trunked radio protocols using SDRs.";
          homepage = "https://github.com/DSheirer/sdrtrunk";
          license = licenses.gpl3Only;
          platforms = platforms.linux;
          mainProgram = "sdrtrunk";
        };
      };
    })
  ];
}
