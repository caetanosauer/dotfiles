import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops   -- fullscreenEventHook fixes chrome fullscreen
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import qualified Data.Map as M
import System.IO

main =  do
  xmproc <- spawnPipe "xmobar -x 0" -- start xmobar
  xmonad $ withUrgencyHook NoUrgencyHook $ ewmh defaultConfig
    { manageHook =  myManageHook <+> manageHook defaultConfig
    , layoutHook = myLayoutHook
    , logHook = myLogHook xmproc
    , workspaces = myWorkspaces
    , keys = myKeys
    , modMask = mod4Mask -- Rebind Mod to Windows key
    , focusedBorderColor = "#CC0000"
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    , normalBorderColor = "#222222"
    , borderWidth = 1
    , focusFollowsMouse = True
    , terminal = "urxvt"
    }

-- , manageHook = ( isFullscreen --> doFullFloat ) <+> manageHook defaultConfig <+> manageDocks
-- send windows into their desired workspace and float some as all
myManageHook = composeAll . concat $
  [ 
    [ isFullscreen --> doFullFloat ],
    [ className=? w --> doFloat | w <- floats ],
    [ className=? w --> doShift "3" | w <- webs ],
    [ className=? w --> doShift "4" | w <- pdfs ],
    [ className=? w --> doShift "5" | w <- files ]
  ]
  where floats = ["Gimp"]
        webs = ["Firefox", "Chrome", "Google-chrome"]
        pdfs = ["Adobe Reader", "Document Reader", "Okular"]
        files = ["Nautilus", "Thunar"]

myLayoutHook = avoidStruts $ layoutHook defaultConfig

myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

-- Key combinations
myKeys conf = M.union (keys defaultConfig conf) $ M.fromList $
  [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
  , ((mod4Mask .|. shiftMask, xK_R), spawn "/home/csauer/bin/xrandr-work")
  -- XF86AudioLowerVolume
  , ((0, 0x1008FF11), spawn "amixer set Master playback 3-")
  -- XF86AudioRaiseVolume
  , ((0, 0x1008FF13), spawn "amixer set Master playback 3+")
  -- XF86AudioMute
  , ((0, 0x1008FF12), spawn "amixer set Master playback 0")
  ]

-- PP
customPP = defaultPP
  { ppHidden = xmobarColor "#00FF00" ""
	, ppCurrent = xmobarColor "#FAC033" "" . wrap "[" "]"
	, ppUrgent = xmobarColor "#FAC033" "" . wrap "*" "*"
  , ppLayout = xmobarColor "#FAC033" ""
  , ppTitle = xmobarColor "#DEDEDE" "" . shorten 80
  , ppSep = "<fc=#0033FF> | </fc>"
  }

myWorkspaces = map show [1..9]
