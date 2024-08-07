-- Base
import XMonad
import System.Directory
import System.IO (hClose, hPutStr, hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

-- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.WorkspaceHistory

-- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

-- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Hacks (windowedFullscreenFixEventHook, javaHack, trayerAboveXmobarEventHook, trayAbovePanelEventHook, trayerPaddingXmobarEventHook, trayPaddingXmobarEventHook, trayPaddingEventHook)
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

-- ColorScheme module (SET ONLY ONE!)
import Colors.EmacsStandard
-- import Colors.DoomOne

myFontTab :: String
myFontTab = "xft:Sans Regular:regular:size=6:antialias=true:hinting=true"

myFontGrid :: String
myFontGrid = "xft:Sans Regular:regular:size=18:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser"   -- Sets defautl browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "  -- Makes emacs keybindings easier to type

myEditor :: String
myEditor = "emacsclient -c -a 'emacs' "  -- Sets emacs as editor
-- myEditor = myTerminal ++ " -e vim "    -- Sets vim as editor

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String       -- Border color of normal windows
myNormColor   = colorBack   -- This variable is imported from Colors.THEME

myFocusColor :: String      -- Border color of focused windows
myFocusColor  = color15     -- This variable is imported from Colors.THEME

mySoundPlayer :: String
mySoundPlayer = "ffplay -nodisp -autoexit " -- The program that will play system sounds

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
  -- spawnOnce (mySoundPlayer ++ startupSound)
  spawnOnce "lxsession"
  spawnOnce "lxappeareance"
  -- spawnOnce "xscreensaver -no-splash"
  spawn "killall conky"   -- kill current conky on each restart
  spawn "killall trayer"   -- kill current trayer on each restart
  spawnOnce "picom"
  spawnOnce "nm-applet"
  -- spawnOnce "volumeicon"
  spawnOnce "fcitx5"
  spawnOnce "/etc/scripts/notify-log $HOME/.log/notify.log"
  spawn "/usr/bin/emacs --daemon" -- emacs daemon for the emacsclient
  spawn ("sleep 2 && trayer --iconspacing 6 --edge top --align right --widthtype request --padding 0 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 40")

  -- Select only =ONE= of the following four ways to set the wallpaper.
  -- spawnOnce "xargs xwallpaper --stretch < ~/.cache/wall"
  -- spawnOnce "~/.fehbg &"  -- set last saved feh wallpaper
  spawnOnce "feh --randomize --bg-center /etc/backgrounds/*"  -- feh set random wallpaper
  -- spawnOnce "nitrogen --restore &"   -- if you prefer nitrogen to feh
  setWMName "LG3D"

myNavigation :: TwoD a (Maybe a)
myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
 where navKeyMap = M.fromList [
          ((0,xK_Escape), cancel)
         ,((0,xK_Return), select)
         ,((0,xK_slash) , substringSearch myNavigation)
         ,((0,xK_Left)  , move (-1,0)  >> myNavigation)
         ,((0,xK_h)     , move (-1,0)  >> myNavigation)
         ,((0,xK_Right) , move (1,0)   >> myNavigation)
         ,((0,xK_l)     , move (1,0)   >> myNavigation)
         ,((0,xK_Down)  , move (0,1)   >> myNavigation)
         ,((0,xK_j)     , move (0,1)   >> myNavigation)
         ,((0,xK_Up)    , move (0,-1)  >> myNavigation)
         ,((0,xK_k)     , move (0,-1)  >> myNavigation)
         ,((0,xK_y)     , move (-1,-1) >> myNavigation)
         ,((0,xK_i)     , move (1,-1)  >> myNavigation)
         ,((0,xK_n)     , move (-1,1)  >> myNavigation)
         ,((0,xK_m)     , move (1,-1)  >> myNavigation)
         ,((0,xK_space) , setPos (0,0) >> myNavigation)
         ]
       navDefaultHandler = const myNavigation

-- TODO: change to using emacs standard colorizer
myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                (0x28,0x2c,0x34) -- lowest inactive bg
                (0x28,0x2c,0x34) -- highest inactive bg
                (0xc7,0x92,0xea) -- active bg
                (0xc0,0xa7,0x9a) -- inactive fg
                (0x28,0x2c,0x34) -- active fg

-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 80
    , gs_cellwidth    = 260
    , gs_cellpadding  = 6
    , gs_navigate     = myNavigation
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFontGrid
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 80
                   , gs_cellwidth    = 260
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFontGrid
                   }

runSelectedAction' :: GSConfig (X ()) -> [(String, X ())] -> X ()
runSelectedAction' conf actions = do
    selectedActionM <- gridselect conf actions
    case selectedActionM of
        Just selectedAction -> selectedAction
        Nothing -> return ()

gsCategories =
  [ ("Favorite",   "xdotool key control+alt+1")
  , ("Search",     "xdotool key control+alt+2")
  , ("Contact",    "xdotool key control+alt+3")
  , ("Multimedia", "xdotool key control+alt+4")
  , ("Office",     "xdotool key control+alt+5")
  , ("Settings",   "xdotool key control+alt+6")
  , ("System",     "xdotool key control+alt+7")
  , ("Utilities",  "xdotool key control+alt+8")
  ]

gsFavorite =
  [ ("Emacs", "emacs")
  , ("Emacsclient", "emacsclient -c -a 'emacs'")
  , ("Alacritty", "alacritty")
  , ("Qutebrowser", "qutebrowser")
  , ("Htop", (myTerminal ++ " -e htop"))
  ]

gsSearch =
  [ ("B: Nix pkgs", (myBrowser ++ " https://search.nixos.org/packages"))
  , ("B: Nix options", (myBrowser ++ " https://search.nixos.org/options"))
  , ("B: Arch wiki", (myBrowser ++ " https://wiki.archlinux.org/"))
  ]

gsContact =
  [ ("Discord", "discord")
  , ("Mailspring", "mailspring")
  , ("Zoom", "zoom")
  ]

gsMultimedia =
  [ ("Steam", "steam")
  , ("Audacity", "audacity")
  , ("Blender", "blender")
  , ("Deadbeef", "deadbeef")
  , ("OBS Studio", "obs")
  , ("VLC", "vlc")
  ]

gsOffice =
  [ ("Document Viewer", "evince")
  , ("Gimp", "gimp")
  , ("Inkscape", "inkscape")
  , ("LibreOffice", "libreoffice")
  , ("Nextcloud", "nextcloud")
  , ("Zotero", "zotero")
  ]

gsSettings =
  [ ("ARandR", "arandr")
  , ("Customize Look and Feel", "lxappearance")
  -- , ("Customize Look and Feel", "xfce4-appearance")
  ]

gsSystem =
  [ ("Alacritty", "alacritty")
  , ("Bash", (myTerminal ++ " -e bash"))
  , ("Htop", (myTerminal ++ " -e htop"))
  ]

gsUtilities =
  [ ("Emacs", "emacs")
  , ("Emacsclient", "emacsclient -c -a 'emacs'")
  , ("Vim", (myTerminal ++ " -e vim"))
  ]

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "mocp" spawnMocp findMocp manageMocp
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnMocp  = myTerminal ++ " -t mocp -e mocp"
    findMocp   = title =? "mocp"
    manageMocp = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ limitWindows 5
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ simplestFloat
grid     = renamed [Replace "grid"]
           $ limitWindows 9
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ limitWindows 9
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ limitWindows 7
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ limitWindows 7
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme
tallAccordion  = renamed [Replace "tallAccordion"]
           $ Accordion
wideAccordion  = renamed [Replace "wideAccordion"]
           $ Mirror Accordion

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFontTab
                 , activeColor         = color15
                 , inactiveColor       = color08
                 , activeBorderColor   = color15
                 , inactiveBorderColor = color08
                 , activeTextColor     = color16
                 , inactiveTextColor   = color16
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
  { swn_font              = "xft:Sans Regular:size=60"
  , swn_fade              = 1.0
  , swn_bgcolor           = colorBack
  , swn_color             = colorFore
  }

-- The layout hook
myLayoutHook = avoidStruts
               $ mouseResize
               $ windowArrange
               $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = withBorder myBorderWidth tall
                                           ||| noBorders monocle
                                           ||| floats
                                           ||| noBorders tabs
                                           ||| grid
                                           ||| spirals
                                           ||| threeCol
                                           ||| threeRow
                                           ||| tallAccordion
                                           ||| wideAccordion

-- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
myWorkspaces = ["dev", "www", "sys", "doc", "gfx", "mtg", "mus", "bot", "free"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
  -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
  -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
  -- I'm doing it this way because otherwise I would have to write out the full
  -- name of my workspaces and the names would be very long if using clickable workspaces.
  [ className =? "confirm"         --> doFloat
  , className =? "file_progress"   --> doFloat
  , className =? "dialog"          --> doFloat
  , className =? "download"        --> doFloat
  , className =? "error"           --> doFloat
  , className =? "inkscape"        --> doFloat
  , className =? "notification"    --> doFloat
  , className =? "pinentry-gtk-2"  --> doFloat
  , className =? "splash"          --> doFloat
  , className =? "toolbar"         --> doFloat
  , className =? "Yad"             --> doCenterFloat
  , title =? "Order Chain - Market Snapshots" --> doFloat
  , title =? "emacs-run-launcher"  --> doFloat
  , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
  , title =? "Qutebrowser"         --> doShift ( myWorkspaces !! 1 )
  , className =? "inkscape"        --> doShift ( myWorkspaces !! 4 )
  , className =? "zoom"            --> doShift ( myWorkspaces !! 5 )
  , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
  , isFullscreen -->  doFullFloat
  ] <+> namedScratchpadManageHook myScratchPads

soundDir = "/opt/dtos-sounds/" -- The directory that has the sound files

startupSound  = soundDir ++ "startup-01.mp3"
shutdownSound = soundDir ++ "shutdown-01.mp3"
dmenuSound    = soundDir ++ "menu-01.mp3"

subtitle' ::  String -> ((KeyMask, KeySym), NamedAction)
subtitle' x = ((0,0), NamedAction $ map toUpper
                      $ sep ++ "\n-- " ++ x ++ " --\n" ++ sep)
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --fontname=\"Sans Regular 12\" --center --geometry=1200x800 --title \"XMonad keybindings\""
  --hPutStr h (unlines $ showKm x) -- showKM adds ">>" before subtitles
  hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
  --(subtitle "Custom Keys":) $ mkNamedKeymap c $
  let subKeys str ks = subtitle' str : mkNamedKeymap c ks in
  subKeys "Xmonad Essentials"
  [ ("M-S-r", addName "Restart XMonad"         $ spawn "xmonad --restart")
  , ("M-q", addName "Logout menu"              $ spawn "lxsession-logout")
  , ("M-S-q", addName "Quit XMonad"            $ sequence_ [spawn (mySoundPlayer ++ shutdownSound), io exitSuccess])
  , ("M-S-c", addName "Kill focused window"    $ kill1)
  , ("M-S-a", addName "Kill all windows on WS" $ killAll)
  , ("M-S-b", addName "Toggle bar show/hide"   $ sendMessage ToggleStruts)
  , ("M-o", addName "Rofi launcher"            $ spawn "rofi -modi drun,ssh,window -show drun -show-icons")
  , ("M-S-o", addName "Rofi prompt"            $ spawn "rofi -show run")
  ]

  ^++^ subKeys "Volumn and brightness control"
  [ ("<XF86AudioMute>", addName "Mute volumn"          $ spawn "/etc/scripts/volume-notify.sh toggle")
  , ("<XF86AudioLowerVolume>", addName "Lower volume"  $ spawn "/etc/scripts/volume-notify.sh decrease 5")
  , ("<XF86AudioRaiseVolume>", addName "Raise volume"  $ spawn "/etc/scripts/volume-notify.sh increase 5")
  , ("<XF86MonBrightnessDown>", addName "Lower bright" $ spawn "/etc/scripts/brightness-notify.sh decrease 5%")
  , ("<XF86MonBrightnessUp>", addName "Raise bright"   $ spawn "/etc/scripts/brightness-notify.sh increase 5%")
  ]

  ^++^ subKeys "Switch to workspace"
  [ ("M-n", addName "Switch to next WS"        $ moveTo Next nonNSP)
  , ("M-p", addName "Switch to prev WS"        $ moveTo Prev nonNSP)
  , ("M-1", addName "Switch to workspace 1"    $ (windows $ W.greedyView $ myWorkspaces !! 0))
  , ("M-2", addName "Switch to workspace 2"    $ (windows $ W.greedyView $ myWorkspaces !! 1))
  , ("M-3", addName "Switch to workspace 3"    $ (windows $ W.greedyView $ myWorkspaces !! 2))
  , ("M-4", addName "Switch to workspace 4"    $ (windows $ W.greedyView $ myWorkspaces !! 3))
  , ("M-5", addName "Switch to workspace 5"    $ (windows $ W.greedyView $ myWorkspaces !! 4))
  , ("M-6", addName "Switch to workspace 6"    $ (windows $ W.greedyView $ myWorkspaces !! 5))
  , ("M-7", addName "Switch to workspace 7"    $ (windows $ W.greedyView $ myWorkspaces !! 6))
  , ("M-8", addName "Switch to workspace 8"    $ (windows $ W.greedyView $ myWorkspaces !! 7))
  , ("M-9", addName "Switch to workspace 9"    $ (windows $ W.greedyView $ myWorkspaces !! 8))]

  ^++^ subKeys "Send window to workspace"
  [ ("M-S-n", addName "Send to next WS"        $ shiftTo Next nonNSP)
  , ("M-S-p", addName "Send to prev WS"        $ shiftTo Prev nonNSP)
  , ("M-S-1", addName "Send to workspace 1"    $ (windows $ W.shift $ myWorkspaces !! 0))
  , ("M-S-2", addName "Send to workspace 2"    $ (windows $ W.shift $ myWorkspaces !! 1))
  , ("M-S-3", addName "Send to workspace 3"    $ (windows $ W.shift $ myWorkspaces !! 2))
  , ("M-S-4", addName "Send to workspace 4"    $ (windows $ W.shift $ myWorkspaces !! 3))
  , ("M-S-5", addName "Send to workspace 5"    $ (windows $ W.shift $ myWorkspaces !! 4))
  , ("M-S-6", addName "Send to workspace 6"    $ (windows $ W.shift $ myWorkspaces !! 5))
  , ("M-S-7", addName "Send to workspace 7"    $ (windows $ W.shift $ myWorkspaces !! 6))
  , ("M-S-8", addName "Send to workspace 8"    $ (windows $ W.shift $ myWorkspaces !! 7))
  , ("M-S-9", addName "Send to workspace 9"    $ (windows $ W.shift $ myWorkspaces !! 8))]

  ^++^ subKeys "Move window to WS and go there"
  [ ("M-M1-n", addName "Move window to next WS"           $ shiftTo Next nonNSP >> moveTo Next nonNSP)
  , ("M-M1-p", addName "Move window to prev WS"           $ shiftTo Prev nonNSP >> moveTo Prev nonNSP)
  , ("M-M1-1", addName "Send to workspace 1 and go there" $ (windows $ W.shift $ myWorkspaces !! 0) >> (windows $ W.greedyView $ myWorkspaces !! 0))
  , ("M-M1-2", addName "Send to workspace 2 and go there" $ (windows $ W.shift $ myWorkspaces !! 1) >> (windows $ W.greedyView $ myWorkspaces !! 1))
  , ("M-M1-3", addName "Send to workspace 3 and go there" $ (windows $ W.shift $ myWorkspaces !! 2) >> (windows $ W.greedyView $ myWorkspaces !! 2))
  , ("M-M1-4", addName "Send to workspace 4 and go there" $ (windows $ W.shift $ myWorkspaces !! 3) >> (windows $ W.greedyView $ myWorkspaces !! 3))
  , ("M-M1-5", addName "Send to workspace 5 and go there" $ (windows $ W.shift $ myWorkspaces !! 4) >> (windows $ W.greedyView $ myWorkspaces !! 4))
  , ("M-M1-6", addName "Send to workspace 6 and go there" $ (windows $ W.shift $ myWorkspaces !! 5) >> (windows $ W.greedyView $ myWorkspaces !! 5))
  , ("M-M1-7", addName "Send to workspace 7 and go there" $ (windows $ W.shift $ myWorkspaces !! 6) >> (windows $ W.greedyView $ myWorkspaces !! 6))
  , ("M-M1-8", addName "Send to workspace 8 and go there" $ (windows $ W.shift $ myWorkspaces !! 7) >> (windows $ W.greedyView $ myWorkspaces !! 7))
  , ("M-M1-9", addName "Send to workspace 9 and go there" $ (windows $ W.shift $ myWorkspaces !! 8) >> (windows $ W.greedyView $ myWorkspaces !! 8))]

  ^++^ subKeys "Window navigation"
  [ ("M-j", addName "Move focus to next window"                $ windows W.focusDown)
  , ("M-k", addName "Move focus to prev window"                $ windows W.focusUp)
  , ("M-m", addName "Move focus to master window"              $ windows W.focusMaster)
  , ("M-S-j", addName "Swap focused window with next window"   $ windows W.swapDown)
  , ("M-S-k", addName "Swap focused window with prev window"   $ windows W.swapUp)
  , ("M-S-m", addName "Swap focused window with master window" $ windows W.swapMaster)
  , ("M-<Backspace>", addName "Move focused window to master"  $ promote)
  , ("M-S-,", addName "Rotate all windows except master"       $ rotSlavesDown)
  , ("M-S-.", addName "Rotate all windows current stack"       $ rotAllDown)]

  -- -- Dmenu scripts (dmscripts)
  -- -- In Xmonad and many tiling window managers, M-o is the default keybinding to
  -- -- launch dmenu_run, so I've decided to use M-o plus KEY for these dmenu scripts.
  -- TODO: replace to rofi
  -- ^++^ subKeys "Dmenu scripts"
  -- [ ("M-o h", addName "List all dmscripts"     $ spawn "dm-hub")
  -- , ("M-o a", addName "Choose ambient sound"   $ spawn "dm-sounds")
  -- , ("M-o b", addName "Set background"         $ spawn "dm-setbg")
  -- , ("M-o c", addName "Choose color scheme"    $ spawn "~/.local/bin/dtos-colorscheme")
  -- , ("M-o C", addName "Pick color from scheme" $ spawn "dm-colpick")
  -- , ("M-o e", addName "Edit config files"      $ spawn "dm-confedit")
  -- , ("M-o i", addName "Take a screenshot"      $ spawn "dm-maim")
  -- , ("M-o k", addName "Kill processes"         $ spawn "dm-kill")
  -- , ("M-o m", addName "View manpages"          $ spawn "dm-man")
  -- , ("M-o n", addName "Store and copy notes"   $ spawn "dm-note")
  -- , ("M-o o", addName "Browser bookmarks"      $ spawn "dm-bookman")
  -- , ("M-o p", addName "Passmenu"               $ spawn "passmenu -p \"Pass: \"")
  -- , ("M-o q", addName "Logout Menu"            $ spawn "dm-logout")
  -- , ("M-o r", addName "Listen to online radio" $ spawn "dm-radio")
  -- , ("M-o s", addName "Search various engines" $ spawn "dm-websearch")
  -- , ("M-o t", addName "Translate text"         $ spawn "dm-translate")]

  ^++^ subKeys "Favorite programs"
  [ ("M-<Return>", addName "Launch terminal"   $ spawn (myTerminal))
  , ("M-b", addName "Launch web browser"       $ spawn (myBrowser))
  , ("M-c", addName "Launch htop"              $ spawn (myTerminal ++ " -e htop"))]

  ^++^ subKeys "Monitors"
  [ ("M-.", addName "Switch focus to next monitor" $ nextScreen)
  , ("M-,", addName "Switch focus to prev monitor" $ prevScreen)]

  -- Switch layouts
  ^++^ subKeys "Switch layouts"
  [ ("M-<Tab>", addName "Switch to next layout"   $ sendMessage NextLayout)
  , ("M-<Space>", addName "Toggle noborders/full" $ sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)]

  -- Window resizing
  ^++^ subKeys "Window resizing"
  [ ("M-h", addName "Shrink window"              $ sendMessage Shrink)
  , ("M-l", addName "Expand window"              $ sendMessage Expand)
  , ("M-S-,", addName "Shrink window vertically" $ sendMessage MirrorShrink)
  , ("M-S-.", addName "Expand window vertically" $ sendMessage MirrorExpand)]

  -- Floating windows
  ^++^ subKeys "Floating windows"
  [ ("M-f", addName "Toggle float layout"        $ sendMessage (T.Toggle "floats"))
  , ("M-t", addName "Sink a floating window"     $ withFocused $ windows . W.sink)
  , ("M-S-t", addName "Sink all floated windows" $ sinkAll)]

  -- Increase/decrease spacing (gaps)
  ^++^ subKeys "Window spacing (gaps)"
  [ ("M-M1-j", addName "Decrease window spacing" $ decWindowSpacing 4)
  , ("M-M1-k", addName "Increase window spacing" $ incWindowSpacing 4)
  , ("M-M1-h", addName "Decrease screen spacing" $ decScreenSpacing 4)
  , ("M-M1-l", addName "Increase screen spacing" $ incScreenSpacing 4)]

  -- Increase/decrease windows in the master pane or the stack
  ^++^ subKeys "Increase/decrease windows in master pane or the stack"
  [ ("M-S-<Up>", addName "Increase clients in master pane"   $ sendMessage (IncMasterN 1))
  , ("M-S-<Down>", addName "Decrease clients in master pane" $ sendMessage (IncMasterN (-1)))
  , ("M-=", addName "Increase max # of windows for layout"   $ increaseLimit)
  , ("M--", addName "Decrease max # of windows for layout"   $ decreaseLimit)]

  -- Sublayouts
  -- This is used to push windows to tabbed sublayouts, or pull them out of it.
  ^++^ subKeys "Sublayouts"
  [ ("M-C-h", addName "pullGroup L"           $ sendMessage $ pullGroup L)
  , ("M-C-l", addName "pullGroup R"           $ sendMessage $ pullGroup R)
  , ("M-C-k", addName "pullGroup U"           $ sendMessage $ pullGroup U)
  , ("M-C-j", addName "pullGroup D"           $ sendMessage $ pullGroup D)
  , ("M-C-m", addName "MergeAll"              $ withFocused (sendMessage . MergeAll))
  -- , ("M-C-u", addName "UnMerge"               $ withFocused (sendMessage . UnMerge))
  , ("M-C-/", addName "UnMergeAll"            $  withFocused (sendMessage . UnMergeAll))
  , ("M-C-.", addName "Switch focus next tab" $  onGroup W.focusUp')
  , ("M-C-,", addName "Switch focus prev tab" $  onGroup W.focusDown')]

  -- Scratchpads
  -- Toggle show/hide these programs. They run on a hidden workspace.
  -- When you toggle them to show, it brings them to current workspace.
  -- Toggle them to hide and it sends them back to hidden workspace (NSP).
  ^++^ subKeys "Scratchpads"
  [ ("M-s t", addName "Toggle scratchpad terminal"   $ namedScratchpadAction myScratchPads "terminal")
  , ("M-s m", addName "Toggle scratchpad mocp"       $ namedScratchpadAction myScratchPads "mocp")]

  -- Controls for mocp music player (SUPER-u followed by a key)
  -- TODO: replace to spotify
  ^++^ subKeys "Mocp music player"
  [ ("M-u p", addName "mocp play"                $ spawn "mocp --play")
  , ("M-u l", addName "mocp next"                $ spawn "mocp --next")
  , ("M-u h", addName "mocp prev"                $ spawn "mocp --previous")
  , ("M-u <Space>", addName "mocp toggle pause"  $ spawn "mocp --toggle-pause")]

  ^++^ subKeys "GridSelect"
  -- , ("C-g g", addName "Select favorite apps"     $ runSelectedAction' defaultGSConfig gsCategories)
  [ ("C-M1-<Return>", addName "Select favorite apps" $ spawnSelected'
       $ gsFavorite ++ gsSearch ++ gsContact ++ gsMultimedia ++ gsOffice ++ gsSettings ++ gsSystem ++ gsUtilities)
  , ("C-M1-c", addName "Select favorite apps"    $ spawnSelected' gsCategories)
  , ("C-M1-t", addName "Goto selected window"    $ goToSelected $ mygridConfig myColorizer)
  , ("C-M1-b", addName "Bring selected window"   $ bringSelected $ mygridConfig myColorizer)
  , ("C-M1-1", addName "Menu of favorite apps"   $ spawnSelected' gsFavorite)
  , ("C-M1-2", addName "Menu of frequent search" $ spawnSelected' gsSearch)
  , ("C-M1-3", addName "Menu of contact apps"    $ spawnSelected' gsContact)
  , ("C-M1-4", addName "Menu of multimedia apps" $ spawnSelected' gsMultimedia)
  , ("C-M1-5", addName "Menu of office apps"     $ spawnSelected' gsOffice)
  , ("C-M1-6", addName "Menu of settings apps"   $ spawnSelected' gsSettings)
  , ("C-M1-7", addName "Menu of system apps"     $ spawnSelected' gsSystem)
  , ("C-M1-8", addName "Menu of utilities apps"  $ spawnSelected' gsUtilities)]

  -- Emacs (SUPER-e followed by a key)
  ^++^ subKeys "Emacs"
  [("M-e e", addName "Emacsclient"               $ spawn (myEmacs))
  -- ("M-e e", addName "Emacsclient Dashboard"    $ spawn (myEmacs ++ ("--eval '(dashboard-refresh-buffer)'")))
  , ("M-e b", addName "Emacsclient Ibuffer"      $ spawn (myEmacs ++ ("--eval '(ibuffer)'")))
  , ("M-e d", addName "Emacsclient Dired"        $ spawn (myEmacs ++ ("--eval '(dired nil)'")))
  , ("M-e i", addName "Emacsclient ERC (IRC)"    $ spawn (myEmacs ++ ("--eval '(erc)'")))
  , ("M-e n", addName "Emacsclient Elfeed (RSS)" $ spawn (myEmacs ++ ("--eval '(elfeed)'")))
  , ("M-e s", addName "Emacsclient Eshell"       $ spawn (myEmacs ++ ("--eval '(eshell)'")))
  , ("M-e v", addName "Emacsclient Vterm"        $ spawn (myEmacs ++ ("--eval '(+vterm/here nil)'")))]

  -- The following lines are needed for named scratchpads.
    where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
          nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

main :: IO ()
main = do
  -- Launching three instances of xmobar on their monitors.
  xmproc0 <- spawnPipe ("xmobar -x 0 /etc/xmobar/" ++ colorScheme ++ "-xmobarrc")
  xmproc1 <- spawnPipe ("xmobar -x 1 /etc/xmobar/" ++ colorScheme ++ "-xmobarrc")
  xmproc2 <- spawnPipe ("xmobar -x 2 /etc/xmobar/" ++ colorScheme ++ "-xmobarrc")
  -- the xmonad
  xmonad $ addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys $ ewmh $ docks $ def
    { manageHook         = myManageHook <+> manageDocks
    , handleEventHook    = windowedFullscreenFixEventHook <> swallowEventHook (className =? "Alacritty"  <||> className =? "st-256color" <||> className =? "XTerm") (return True) <> trayerPaddingXmobarEventHook
    , modMask            = myModMask
    , terminal           = myTerminal
    , startupHook        = myStartupHook
    , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    , logHook = dynamicLogWithPP $  filterOutWsPP [scratchpadWorkspaceTag]  $ xmobarPP
        { ppOutput = \x -> hPutStrLn xmproc0 x   -- xmobar on monitor 1
                        >> hPutStrLn xmproc1 x   -- xmobar on monitor 2
                        >> hPutStrLn xmproc2 x   -- xmobar on monitor 3
        -- , ppCurrent = xmobarColor colorFore "" . wrap
        --               ("<box type=Full width=1 mb=1 color=" ++ colorFore ++ " bgColor=" ++ color01 ++ "> ") (" </box>")
        , ppCurrent = xmobarColor color06 "" . wrap
                      ("<fc=" ++ color06 ++ ">[</fc><box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") ("</box><fc=" ++ color06 ++ ">]</fc>")
          -- Visible but not current workspace
        , ppVisible = xmobarColor color07 "" . clickable
          -- Hidden workspace
        , ppHidden = xmobarColor color05 "" . wrap
                     ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable
          -- Hidden workspaces (no windows)
        , ppHiddenNoWindows = xmobarColor color05 "" . clickable
          -- Title of active window
        , ppTitle = xmobarColor color16 "" . wrap
                    "<fn=1>" "</fn>" . shorten 10
          -- Separator character
        , ppSep =  "<fc=" ++ color09 ++ "> | </fc>"
          -- Urgent workspace
        , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
          -- Adding # of windows on current workspace to the bar
        , ppExtras  = [windowCount]
          -- order of things in xmobar
        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
        }
    }
