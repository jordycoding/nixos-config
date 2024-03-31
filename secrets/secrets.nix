let
  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEoNnqZOuKhcAnkiWyroX3pfeWSnLnHwS41e7vEesjJ";
  system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILWZW4sR9cz9Y5o+9nxEt+Uo80U+BxtO1oL5Ks4xjZjH";
  systems = [ system1 system2 ];
in
{
  "wgPrivkey.age".publicKeys = [ system1 ];
}
