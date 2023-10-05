import Data.Map qualified as M
import System.Exit
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.TaffybarPagerHints
import XMonad.Layout.IndependentScreens
import XMonad.Layout.ThreeColumns
import XMonad.StackSet
import XMonad.Util.Cursor
import XMonad.Util.Run

myTerminal = "alacritty"

myFocusFollowsMouse = False

myBorderWidth = 1

myModMask = controlMask .|. shiftMask .|. mod1Mask

myWorkSpaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myNormalBorderColor = "#dddddd"

myFocusedBorderColor = "#ff0000"

myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList
    [ ((mod4Mask, xK_space), spawn "rofi -show drun"),
      ((modm, xK_space), sendMessage NextLayout),
      ((modm, xK_i), proc $ inTerm >-> setXClass "input_method_neovim" >-> execute "nvim"),
      ((modm, xK_m), windows focusMaster),
      ((modm, xK_j), windows focusDown),
      ((modm, xK_k), windows focusUp),
      ((modm, xK_h), prevScreen),
      ((modm, xK_l), nextScreen),
      ((modm, xK_Left), prevWS),
      ((modm, xK_Right), nextWS),
      ((modm, xK_Return), windows swapMaster),
      ((modm .|. mod4Mask, xK_j), windows swapDown),
      ((modm .|. mod4Mask, xK_k), windows swapUp),
      ((modm .|. mod4Mask, xK_h), shiftPrevScreen >> prevScreen),
      ((modm .|. mod4Mask, xK_l), shiftNextScreen >> nextScreen),
      ((modm .|. mod4Mask, xK_Left), shiftToPrev >> prevWS),
      ((modm .|. mod4Mask, xK_Right), shiftToNext >> nextWS),
      ((modm, xK_q), io exitSuccess)
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

main = do
  nScreens <- countScreens
  xmonad $
    ewmh $
      docks $
        pagerHints
          def
            { terminal = myTerminal,
              focusFollowsMouse = myFocusFollowsMouse,
              borderWidth = myBorderWidth,
              modMask = myModMask,
              XMonad.workspaces = withScreens nScreens myWorkSpaces,
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
