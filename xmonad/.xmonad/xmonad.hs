import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.ThreeColumns
import qualified DBus as D
import qualified DBus.Client as D
import qualified Data.Map as M
import qualified XMonad.StackSet as W

myBorderColor       = "#6a6b3f"  --tender dim green
myFocusedColor      = "#9faa00"  --tender green
myFocusFollowsMouse = True
myBorderWidth       = 2
myWorkspaces        = ["1","2","3","4","5","6","7","8","9","10"]
myBaseConfig        = desktopConfig
s                   = mod4Mask
ss                  = mod4Mask .|. shiftMask
sc                  = mod4Mask .|. controlMask
sac                 = mod4Mask .|. mod1Mask .|. controlMask
c                   = controlMask

myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"

-- window manipulations
myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    ]
    where
    myCFloats = ["Arandr", "Arcolinux-tweak-tool.py", "feh"]
    myTFloats = ["Downloads", "Save As..."]
    myRFloats = []
    myIgnores = ["desktop_window"]

myLayout = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True $ avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) 
    $ Tall nmaster delta tiled_ratio
    ||| Mirror (Tall nmaster delta tiled_ratio) 
    ||| spiral (6/7)  
    ||| ThreeColMid nmaster delta tiled_ratio 
    ||| Full
    where
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $ 
  [
    ((s,    xK_space),      spawn $ "rofi -show drun" )
  , ((sc,   xK_space),      spawn $ "rofi -show run" )
  , ((sac,  xK_space),      spawn $ "rofi -show window" )
  , ((c,    xK_space),      spawn $ "rofi-theme-selector" )

  , ((s,    xK_Return),     spawn $ "alacritty" )
  , ((sc,   xK_Return),     spawn $ "firefox" )
  , ((sac,  xK_Return),     spawn $ "thunar" )

  , ((s,    xK_Escape),     spawn $ "xkill" )
  , ((s,    xK_q),          kill )
  
  , ((ss,   xK_r),          spawn $ "xmonad --recompile && xmonad --restart")

  , ((sc,   xK_v),          spawn $ "pavucontrol" )
  , ((sc,   xK_y),          spawn $ "polybar-msg cmd toggle" )
  , ((s,    xK_x),          spawn $ "arcolinux-logout" )

  -- screen shot
 -- , ((0, xK_Print), spawn $ "scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")
 -- , ((controlMask, xK_Print), spawn $ "xfce4-screenshooter" )
 -- , ((controlMask .|. shiftMask , xK_Print ), spawn $ "gnome-screenshot -i")

 -- -- Mute volume
 -- , ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle")

 -- -- Decrease volume
 -- , ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 5%-")

 -- -- Increase volume
 -- , ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 5%+")

 -- -- Increase brightness
 -- , ((0, xF86XK_MonBrightnessUp),  spawn $ "xbacklight -inc 5")

 -- -- Decrease brightness
 -- , ((0, xF86XK_MonBrightnessDown), spawn $ "xbacklight -dec 5")
 -- , ((0, xF86XK_AudioPlay), spawn $ "playerctl play-pause")
 -- , ((0, xF86XK_AudioNext), spawn $ "playerctl next")
 -- , ((0, xF86XK_AudioPrev), spawn $ "playerctl previous")
 -- , ((0, xF86XK_AudioStop), spawn $ "playerctl stop")

 -- -- Cycle through the available layout algorithms.
 -- , ((s, xK_space), sendMessage NextLayout)

  -- toggle full screen
  , ((s,    xK_f),          sendMessage $ Toggle NBFULL)

  --Focus selected desktop
  , ((mod1Mask, xK_Tab), nextWS)

  --Focus selected desktop
  , ((s, xK_Tab), nextWS)

  --Focus selected desktop
  , ((controlMask .|. mod1Mask , xK_Left ), prevWS)

  --Focus selected desktop
  , ((controlMask .|. mod1Mask , xK_Right ), nextWS)

  --  Reset the layouts on the current workspace to default.
  , ((ss, xK_space), setLayout $ XMonad.layoutHook conf)

  -- Move focus to the next window.
  , ((s, xK_j), windows W.focusDown)

  -- Move focus to the previous window.
  , ((s, xK_k), windows W.focusUp  )

  -- Move focus to the master window.
  , ((ss, xK_m), windows W.focusMaster  )

  -- Swap the focused window with the next window.
  , ((ss, xK_j), windows W.swapDown  )

  -- Swap the focused window with the next window.
  , ((controlMask .|. s, xK_Down), windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((ss, xK_k), windows W.swapUp    )

  -- Swap the focused window with the previous window.
  , ((controlMask .|. s, xK_Up), windows W.swapUp  )

  -- Shrink the master area.
  , ((controlMask .|. shiftMask , xK_h), sendMessage Shrink)

  -- Expand the master area.
  , ((controlMask .|. shiftMask , xK_l), sendMessage Expand)

  -- Push window back into tiling.
  , ((controlMask .|. shiftMask , xK_t), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((controlMask .|. s, xK_Left), sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((controlMask .|. s, xK_Right), sendMessage (IncMasterN (-1)))

  ]
  ++
  [
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    ((m .|. s, k), windows $ f i) 
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)
      , (\i -> W.greedyView i . W.shift i, shiftMask)]
  ]
  ++
  [
    -- ctrl-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- ctrl-shift-{w,e,r}, Move client to screen 1, 2, or 3
    ((m .|. controlMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ]

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ 
    -- mod-button1, Set the window to floating mode and move by dragging
    -- ((s, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    --, ((s, 2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    --, ((s, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]


main :: IO ()
main = do

    dbus <- D.connectSession
    -- Request access to the DBus name
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad . ewmh $ myBaseConfig {
                      startupHook = myStartupHook
                    , layoutHook = gaps [(U,35), (D,5), (R,5), (L,5)] $ myLayout ||| layoutHook myBaseConfig
                    , manageHook = manageSpawn <+> myManageHook <+> manageHook myBaseConfig
                    , modMask = s
                    , borderWidth = myBorderWidth
                    , handleEventHook    = handleEventHook myBaseConfig <+> fullscreenEventHook
                    , focusFollowsMouse = myFocusFollowsMouse
                    , workspaces = myWorkspaces
                    , focusedBorderColor = myFocusedColor
                    , normalBorderColor = myBorderColor
                    , keys = myKeys
                    --, mouseBindings = myMouseBindings
                  }
