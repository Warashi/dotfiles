import Data.Map qualified as M
import Data.Monoid
import System.Exit
import XMonad
import XMonad.Layout.ThreeColumns
import XMonad.StackSet qualified as W

myTerminal = "alacritty"

myFocusFollowsMouse = False

myBorderWidth = 1

myModMask = controlMask .|. shiftMask .|. mod1Mask

myWorkSpaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myNormalBorderColor = "#dddddd"

myFocusedBorderColor = "#ff0000"

myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ ((mod4Mask, xK_space), spawn "rofi -show drun"),
      ((modm, xK_space), sendMessage NextLayout),
      ((modm, xK_Return), windows W.focusMaster),
      ((modm, xK_j), windows W.focusDown),
      ((modm, xK_k), windows W.focusUp),
      ((modm .|. mod4Mask, xK_Return), windows W.swapMaster),
      ((modm .|. mod4Mask, xK_j), windows W.swapDown),
      ((modm .|. mod4Mask, xK_k), windows W.swapUp),
      ((modm, xK_q), io exitSuccess)
    ]
      ++ [ ((m .|. modm, k), windows $ f i)
           | (i, k) <- zip (workspaces conf) [xK_1 .. xK_9],
             (f, m) <- [(W.greedyView, 0), (W.shift, mod4Mask)]
         ]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.empty

myLayout = ThreeColMid nmaster delta frac ||| Full
  where
    nmaster = 1
    delta = 1 / 300
    frac = 1 / 2

myManageHook =
  composeAll
    [ className =? "MPlayer" --> doFloat,
      className =? "Gimp" --> doFloat,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

myEventHook = mempty

myLogHook = return ()

myStartupHook = return ()

main =
  xmonad
    def
      { terminal = myTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        modMask = myModMask,
        workspaces = myWorkSpaces,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys = myKeys,
        mouseBindings = myMouseBindings,
        layoutHook = myLayout,
        manageHook = myManageHook,
        handleEventHook = myEventHook,
        logHook = myLogHook,
        startupHook = myStartupHook
      }
