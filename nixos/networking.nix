# System configuration for networking

{
  services.avahi = {
    # Enable Avahi daemon to use Avahi's service discovery (so finding printers and other computers)
    enable = true;
    # Enable the mDNS NSS (Name Service Switch) plug-in to allow applications to resolve names in the `.local' domain by transparently querying the Avahi daemon
    nssmdns4 = true;
  };

  # Provides resolver services for Domain Name System (DNS), Multicast DNS (mDNS) and Link-Local Multicast Name Resolution (LLMNR)
  services.resolved.enable = true;
}
