inputs: [
  {
    name = "gnu";
    type = "elpa";
    path = inputs.gnu-elpa.outPath + "/elpa-packages";
    auto-sync-only = true;
  }
  {
    name = "melpa";
    type = "melpa";
    path = inputs.melpa.outPath + "/recipes";
    exclude = [
      "bbdb"
    ];
  }
  {
    name = "nongnu";
    type = "elpa";
    path = inputs.nongnu.outPath + "/elpa-packages";
    exclude = [
      "org-contrib"
    ];
  }
  {
    name = "emacsmirror";
    type = "gitmodules";
    path = inputs.epkgs.outPath + "/.gitmodules";
  }
]
