{
  elpaBuild,
  emacs,
  fetchurl,
  lib,
}:
elpaBuild {
  pname = "org";
  ename = "org";
  version = "9.6.30";
  src = fetchurl {
    url = "https://elpa.gnu.org/packages/org-9.6.30.tar";
    sha256 = "0h2p7gjiys5ch68y35l6bpw9pp852vprmfzi0dk86z1wkilhycip";
  };
  packageRequires = [emacs];
  meta = {
    homepage = "https://elpa.gnu.org/packages/org.html";
    license = lib.licenses.free;
  };
}
