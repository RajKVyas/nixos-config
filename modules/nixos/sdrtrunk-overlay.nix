# /etc/nixos/modules/nixos/sdrtrunk-overlay.nix
{ pkgs, ... }:

{
  # This adds our new package to the set of all packages.
  nixpkgs.overlays = [
    (final: prev: {
      sdrtrunk = prev.buildGradlePackage {
        pname = "sdrtrunk";
        version = "0.6.1-unstable-2025-06-30"; # Using a descriptive version

        src = prev.fetchFromGitHub {
          owner = "DSheirer";
          repo = "sdrtrunk";
          # From the GitHub page you found, this is the latest commit as of today
          rev = "912925e0e7a77611ab4b82d49931b6713988f01b";
          # Nix needs a hash to verify the download. We'll get this in a moment.
          hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };

        # This tells the builder where to find the Java dependency hashes
        gradleDeps = ./sdrtrunk-deps.json;

        # These are the system libraries needed for JavaFX (the GUI) to work
        buildInputs = with prev; [
          webkitgtk
          gtk3
          glib
        ];

        # Tell Nix to fix the bundled binaries to work on NixOS
        nativeBuildInputs = with prev; [
          autoPatchelfHook
        ];

        # Add the required libraries to the runtime path for the application
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
