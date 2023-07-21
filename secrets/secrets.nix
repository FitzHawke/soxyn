let
  will = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMPxvQbxhePTrxcb8zJ4UNttu+L44yCqGsa3VaEcFoxl";
  users = [ will ];

  dinraal = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBugVOYnQxNF+pvH2a8FezHf8Vt9S4UuuTnXEe9op6eT";
  farosh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoJd/82YaD9tRcQdKGfQQzy5LvLR7pE/epbKLeGi4NE";
  systems = [ farosh dinraal ];
in
{
  "fitz-pass.age".publicKeys = users ++ systems;
  "wl-loc.age".publicKeys = users ++ systems;
  "syncthing/dinraal.age".publicKeys = [ will farosh ];
  "syncthing/farosh.age".publicKeys = [ will dinraal ];
  "syncthing/naydra.age".publicKeys = users ++ systems;
  "syncthing/gleeok.age".publicKeys = users ++ systems;
  "syncthing/riju.age".publicKeys = users ++ systems;
  "syncthing/web_pass.age".publicKeys = users ++ systems;
}