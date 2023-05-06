# System configuration for udiskie

{
  # The Udisks2 DBus service is needed for udiskie to run, otherwise mounting will fail
  services.udisks2.enable = true;
}
