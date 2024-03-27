import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

main = xmonad xfceConfig
        { terminal = "xfce4-terminal"
        , modMask = mod4Mask -- Use Win as MOD key
        , startupHook = ewmhDesktopsStartup >> setWMName "LG3D" -- for some reason the double greater sign is escaped here due to wiki formatting, replace this with proper greater signs!
        }
