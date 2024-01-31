_: {
  hardware.uinput.enable = true;
  users.groups = {
    input.members = ["warashi"];
    uinput.members = ["warashi"];
  };
}
