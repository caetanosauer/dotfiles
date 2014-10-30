import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops   -- fullscreenEventHook fixes chrome fullscreen
import XMonad.Util.NamedWindows
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import System.IO

main =  do
  xmproc <- spawnPipe "xmobar -x 0" -- start xmobar
  xmonad $ withUrgencyHook LibNotifyUrgencyHook $ ewmh defaultConfig
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
    [ className=? w --> doShift "5" | w <- files ],
    [ className=? w --> doShift "9" | w <- media ],
    [ className=? c --> doIgnore | c <- ignore ]
  ]
  where floats = ["Gimp", "Zenity"]
        webs = ["Firefox", "Chrome", "Google-chrome"]
        pdfs = ["Adobe Reader", "Document Reader", "Okular", "Mendeleydesktop.x86_64"]
        files = ["Nautilus", "Thunar"]
        media = ["Spotify", "Deluge", "Filezilla"]
        ignore = ["trayer"]

myLayoutHook = avoidStruts $ layoutHook defaultConfig

myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

-- Key combinations
myKeys conf = M.union (keys defaultConfig conf) $ M.fromList $
  [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
  , ((mod4Mask .|. shiftMask, xK_r), spawn "bash /home/csauer/bin/xrandr-work")
  , ((mod4Mask .|. shiftMask, xK_s), spawn "sudo -n pm-suspend")
  , ((mod4Mask .|. shiftMask, xK_h), spawn "sudo -n pm-hibernate")
  , ((mod4Mask .|. shiftMask, xK_n), spawn "quicknote")
  -- XF86AudioLowerVolume
  , ((0, 0x1008FF11), spawn "amixer set Master playback 3-")
  -- XF86AudioRaiseVolume
  , ((0, 0x1008FF13), spawn "amixer set Master playback 3+")
  -- XF86AudioMute
  , ((0, 0x1008FF12), spawn "amixer set Master playback 0")
  -- XF86MonBrightnessUp
  , ((0, 0x1008FF02), spawn "xbacklight +20")
  -- XF86MonBrightnessUp
  , ((0, 0x1008FF03), spawn "xbacklight -20")
  -- Play
  , ((0, 0x1008FF14), spawn "spotifyctl play")
  -- Previous
  , ((0, 0x1008FF16), spawn "spotifyctl prev")
  -- Next
  , ((0, 0x1008FF17), spawn "spotifyctl next")
  ]

-- PrettyPrint (xmobar input with workspaces and window title)
-- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-DynamicLog.html#v:defaultPP
customPP = defaultPP
  { ppHidden = xmobarColor "#eeeeec" ""
  , ppCurrent = xmobarColor "#729fcf" "" . wrap "[" "]"
  , ppUrgent = xmobarColor "#fce94f" "" . wrap "*" "*"
  , ppLayout = xmobarColor "#729fcf" ""
  , ppTitle = xmobarColor "#babdb9" "" . shorten 50
  , ppSep = "<fc=#555753> | </fc>"
  }

-- Notify-osd (http://pbrisbin.com/posts/using_notify_osd_for_xmonad_notifications/)
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset
        safeSpawn "notify-send" [show name, "workspace " ++ idx]



-- Workspaces
myWorkspaces = map show [1..9]
