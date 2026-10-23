{ config, pkgs, ... }:

{
  security.pki.certificateFiles = [
    ../assets/dod-certificates.pem
  ];

  environment.etc."opt/policies/managed/smartcard.json".text = builtins.toJSON {
    BuiltInDnsClientEnabled = true; # (just an example placeholder)
    # Configure external PKCS#11 modules to load automatically
    SecurityKeyPinningEnabled = false;
  };

  services.pcscd = {
    enable = true;
    plugins = [
      pkgs.ccid
    ];
  };

  environment.systemPackages = with pkgs; [
    pcsc-tools
    opensc
    gnupg
    p11-kit
  ];

  environment.etc."pkcs11/modules/opensc-pkcs11" = {
    text = ''
      module: ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';
  };

  system.userActivationScripts.setupNssDb = ''
    NSSDB="$HOME/.pki/nssdb"
    if [ ! -d "$NSSDB" ]; then
      mkdir -p "$NSSDB"
      ${pkgs.nss.tools}/bin/modutil -dbdir sql:"$NSSDB" -create -force
    fi
    # Check if OpenSC is already registered in the user's NSS database
    if ! ${pkgs.nss.tools}/bin/modutil -dbdir sql:"$NSSDB" -list | grep -q "OpenSC"; then
      ${pkgs.nss.tools}/bin/modutil -dbdir sql:"$NSSDB" -add "OpenSC" -libfile "${pkgs.opensc}/lib/opensc-pkcs11.so" -mechanisms "ALL" -force || true
    fi
  '';
}
