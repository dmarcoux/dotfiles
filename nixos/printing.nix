# System configuration for printing

{ pkgs, ... }:

{
  services.printing = {
    # Enable CUPS to print documents.
    enable = true;
    drivers = with pkgs; [
      # Install drivers for many different printers from many different vendors
      gutenprint
      # Install drivers for HP printers
      hplip
      # Install proprietary drivers for Samsung printers
      samsung-unified-linux-driver_1_00_37
      # Install drivers for printers supporting Samsung Printer Language
      splix
    ];
  };

  # Install GUI for CUPS administration
  programs.system-config-printer.enable = true;

  # Configure printers available to print documents
  hardware.printers.ensurePrinters = [
    {
      name = "Samsung_M2070_Series";
      description = "Samsung M2070 Series";
      location = "Home";
      deviceUri = "socket://31.1.90.10";
      model = "Samsung_M2070_Series.ppd.gz"; # Search available models with `lpinfo -m | less`
      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];
}
