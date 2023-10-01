import Xmobar

config :: Config
config =
  defaultConfig
    { font = "PlemolJP Console NF 18",
      additionalFonts = ["Noto Color Emoji 18"],
      position = TopH 30,
      allDesktops = True,
      commands =
        [ Run StdinReader,
          Run $ Cpu ["--template", "<total>%"] 100,
          Run $ Memory ["--template", "<usedratio>%"] 100,
          Run $ Swap ["--template", "<usedratio>%"] 100,
          Run $
            Wireless
              ""
              ["--template", "<essid> <quality>"]
              100,
          Run $
            Battery
              [ "--template",
                "<acstatus>",
                "--",
                "-o",
                "BAT: <left>%",
                "-O",
                "AC: <left>%",
                "-i",
                "AC: <left>%"
              ]
              100,
          Run $
            DateZone "%F %a %T" "ja_JP.utf8" "Japan" "date" 10
        ],
      template = "%StdinReader% }{ CPU: %cpu% | Mem: %memory% | Swap: %swap% | Wi-Fi: %wireless% | %battery% | %date%",
      alignSep = "}{"
    }

main :: IO ()
main = xmobar config
