import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops

--  Tree Select
import Data.Tree
import XMonad.Actions.TreeSelect
import XMonad.Hooks.WorkspaceHistory
import qualified XMonad.StackSet as W



--  Main Process
main :: IO()
main = do
	configs <- xmobar myConfig
	xmonad $ ewmh configs


--  Configs
myTerminal = "alacritty"
myFont="xft:Bitstream Vera Sans Mono:size=10:antialias=true"
myKeys = [
		("M-f", treeselectWorkspace myTreeConf myWorkspaces W.greedyView),
		("M-S-f", treeselectWorkspace myTreeConf myWorkspaces W.shift),
		("<XF86AudioRaiseVolume>", spawn "pulsemixer --change-volume +5"),
		("<XF86AudioLowerVolume>", spawn "pulsemixer --change-volume -5"),
		("<XF86AudioMute>",        spawn "pulsemixer --toggle-mute")
	]

--  Tree Select
myWorkspaces :: Forest String
myWorkspaces = [
		Node "Browser" [],
		Node "Home" [
			Node "1" [],
			Node "2" [],
			Node "3" [],
			Node "4" []
		]
	]

myStartupHook = do
	spawnOnce "gnome-settings-daemon"
	spawnOnce "nm-applet"
	spawnOnce "blueman-applet"
	spawnOnce "xscreensaver -no-splash"
	spawnOnce "fcitx -rd"
	spawnOnOnce "Browser" "google-chrome-stable"

myConfig = defaultConfig { 
		terminal    = myTerminal,
		borderWidth = 3,
		workspaces = toWorkspaces myWorkspaces,
		startupHook = myStartupHook,
		logHook = workspaceHistoryHook,
		handleEventHook = handleEventHook def <+> fullscreenEventHook <+> ewmhDesktopsEventHook
    } `additionalKeysP` myKeys

myTreeConf = tsDefaultConfig {
	ts_font = myFont,
	ts_node_width = 200,
	ts_node_height = 60
}

