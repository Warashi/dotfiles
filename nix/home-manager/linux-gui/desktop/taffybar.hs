{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent.MVar qualified as MV
import Control.Monad.Trans.Class (lift)
import Data.Default (def)
import Data.List
import Data.Maybe
import Data.Unique (newUnique)
import Graphics.UI.GIGtkStrut
import System.Taffybar
import System.Taffybar.Context (getStateDefault)
import System.Taffybar.Context qualified as BC (BarConfig (..), TaffybarConfig (..))
import System.Taffybar.Hooks
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig hiding (toTaffyConfig)
import System.Taffybar.Util
import System.Taffybar.Widget

--- functions for generate config {{{
-- borrow from System.Taffybar.SimpleConfig
toStrutConfig :: SimpleTaffyConfig -> Int -> StrutConfig
toStrutConfig
  SimpleTaffyConfig
    { barHeight = height,
      barPadding = padding,
      barPosition = pos
    }
  monitor =
    defaultStrutConfig
      { strutHeight = height,
        strutYPadding = fromIntegral padding,
        strutXPadding = fromIntegral padding,
        strutAlignment = Center,
        strutMonitor = Just $ fromIntegral monitor,
        strutPosition =
          case pos of
            Top -> TopPos
            Bottom -> BottomPos
      }

toBarConfig :: SimpleTaffyConfig -> Int -> IO BC.BarConfig
toBarConfig config monitor = do
  let strutConfig = toStrutConfig config monitor
  barId <- newUnique
  return
    BC.BarConfig
      { BC.strutConfig = strutConfig,
        BC.widgetSpacing = fromIntegral $ widgetSpacing config,
        BC.startWidgets = startWidgets config,
        BC.centerWidgets = centerWidgets config,
        BC.endWidgets = endWidgets config,
        BC.barId = barId
      }

createBarConfig :: SimpleTaffyConfig -> Int -> IO BC.BarConfig
createBarConfig config monitor = do
  let config' = setWidgetsForMonitor config monitor
  toBarConfig config' monitor

newtype SimpleBarConfigs = SimpleBarConfigs (MV.MVar [(Int, BC.BarConfig)])

-- | Convert a 'SimpleTaffyConfig' into a 'BC.TaffybarConfig' that can be used
-- with 'startTaffybar' or 'dyreTaffybar'.
toTaffyConfig :: SimpleTaffyConfig -> BC.TaffybarConfig
toTaffyConfig conf =
  def
    { BC.getBarConfigsParam = configGetter,
      BC.cssPaths = cssPaths conf,
      BC.startupHook = startupHook conf
    }
  where
    configGetter = do
      SimpleBarConfigs configsVar <-
        getStateDefault $ lift (SimpleBarConfigs <$> MV.newMVar [])
      monitorNumbers <- monitorsAction conf

      let lookupWithIndex barConfigs monitorNumber = (monitorNumber, lookup monitorNumber barConfigs)

          lookupAndUpdate barConfigs = do
            let (alreadyPresent, toCreate) = partition (isJust . snd) $ map (lookupWithIndex barConfigs) monitorNumbers
                alreadyPresentConfigs = mapMaybe snd alreadyPresent

            newlyCreated <-
              mapM (forkM return (createBarConfig conf) . fst) toCreate
            let result = map snd newlyCreated ++ alreadyPresentConfigs
            return (barConfigs ++ newlyCreated, result)

      lift $ MV.modifyMVar configsVar lookupAndUpdate

--- }}}

--- my config {{{
myTaffybarConfig :: BC.TaffybarConfig
myTaffybarConfig = toTaffyConfig mySimpleTaffyConfig

mySimpleTaffyConfig :: SimpleTaffyConfig
mySimpleTaffyConfig =
  defaultSimpleTaffyConfig
    { barHeight = ExactSize 96
    }

setWidgetsForMonitor :: SimpleTaffyConfig -> Int -> SimpleTaffyConfig
setWidgetsForMonitor config monitor =
  config
    { startWidgets =
        [ workspacesNew (myWorkspacesConfig monitor)
        ],
      centerWidgets =
        [ windowsNew myWindowsConfig
        ],
      endWidgets =
        [ sniTrayNew,
          textClockNewWith myClockConfig,
          textMemoryMonitorNew "mem: $used$ swap $swapUsed$" 5,
          textCpuMonitorNew "cpu: $total$" 5
        ]
    }

myWorkspacesConfig :: Int -> WorkspacesConfig
myWorkspacesConfig monitor =
  defaultWorkspacesConfig
    { labelSetter = myWorkspaceLabelSetter monitor,
      showWorkspaceFn = myShowWorkspaceFn monitor
    }

myWorkspaceLabelSetter :: Int -> Workspace -> WorkspacesIO String
myWorkspaceLabelSetter monitor workspace = do
  let prefix = show monitor ++ "_"
  return $ fromMaybe "unnamed" (stripPrefix prefix (workspaceName workspace))

myShowWorkspaceFn :: Int -> Workspace -> Bool
myShowWorkspaceFn monitor workspace =
  let prefix = show monitor ++ "_"
   in prefix `isPrefixOf` workspaceName workspace

myWindowsConfig :: WindowsConfig
myWindowsConfig = defaultWindowsConfig

myClockConfig :: ClockConfig
myClockConfig =
  defaultClockConfig
    { clockFormatString = "%F %H:%M:%S",
      clockUpdateStrategy = ConstantInterval 1
    }

--- }}}

main = dyreTaffybar myTaffybarConfig
