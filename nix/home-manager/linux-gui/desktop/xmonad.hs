import Data.Map qualified as M
import System.Exit
import XMonad
import XMonad.Actions.CycleWS qualified as WS
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.IndependentScreens
import XMonad.Layout.ThreeColumns
import XMonad.StackSet qualified as W
import XMonad.Util.Cursor
import XMonad.Util.Run
import System.Taffybar.Support.PagerHints (pagerHints)

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
      ((modm, xK_i), proc $ inTerm >-> setXClass "input_method_neovim" >-> execute "nvim"),
      ((modm, xK_m), windows W.focusMaster),
      ((modm, xK_j), windows W.focusDown),
      ((modm, xK_k), windows W.focusUp),
      ((modm, xK_h), WS.prevScreen),
      ((modm, xK_l), WS.nextScreen),
      ((modm, xK_Left), WS.prevWS),
      ((modm, xK_Right), WS.nextWS),
      ((modm, xK_Return), windows W.swapMaster),
      ((modm .|. mod4Mask, xK_j), windows W.swapDown),
      ((modm .|. mod4Mask, xK_k), windows W.swapUp),
      ((modm .|. mod4Mask, xK_h), WS.shiftPrevScreen >> WS.prevScreen),
      ((modm .|. mod4Mask, xK_l), WS.shiftNextScreen >> WS.nextScreen),
      ((modm .|. mod4Mask, xK_Left), WS.shiftToPrev >> WS.prevWS),
      ((modm .|. mod4Mask, xK_Right), WS.shiftToNext >> WS.nextWS),
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
      className =? "input_method_neovim" --> doSideFloat SE,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

myEventHook = mempty

myLogHook = return ()

myStartupHook = setDefaultCursor xC_left_ptr

myPolybarConfig = statusBarProp "polybar warashi" (pure polybarPPdef)

polybarPPdef =
  def
    { ppCurrent = polybarFgColor "#FF9F1C" . wrap "[" "]",
      ppTitle = const ""
    }

polybarFgColor :: String -> String -> String
polybarFgColor fore_color = wrap ("%{F" <> fore_color <> "} ") " %{F-}"

polybarBgColor :: String -> String -> String
polybarBgColor back_color = wrap ("%{B" <> back_color <> "} ") " %{B-}"

main = do
  nScreens <- countScreens
  xmonad $
    withSB myPolybarConfig $
      ewmh $
        docks $
        pagerHints $
          def
            { terminal = myTerminal,
              focusFollowsMouse = myFocusFollowsMouse,
              borderWidth = myBorderWidth,
              modMask = myModMask,
              workspaces = withScreens nScreens myWorkSpaces,
              normalBorderColor = myNormalBorderColor,
              focusedBorderColor = myFocusedBorderColor,
              keys = myKeys,
              mouseBindings = myMouseBindings,
              layoutHook = avoidStruts myLayout,
              manageHook = myManageHook,
              handleEventHook = myEventHook,
              logHook = myLogHook,
              startupHook = myStartupHook
            }
