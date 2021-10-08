import XMonad
import XMonad.Config.Desktop
import XMonad.Prompt.ConfirmPrompt
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Gaps
import XMonad.Util.EZConfig
import XMonad.Layout.Spacing
import XMonad.Layout.PerWorkspace
import XMonad.Layout.BoringWindows
import XMonad.Layout.Minimize
import XMonad.Actions.Minimize
import XMonad.Layout.TrackFloating
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Layout.SimpleFloat

import Fullscreen


main = xmonad $ ewmh  $ desktopConfig
--main = xmonad $ desktopConfig
    { terminal = myTerminal
    , modMask = mod4Mask
    , borderWidth = 0
    , focusFollowsMouse = False
    , handleEventHook = fullscreenEventHook
    , clickJustFocuses = False
    -- trackFloating - prevents windows changing focus when using floating windows in Full layout
    , layoutHook = trackFloating $ boringWindows $ minimize $ onWorkspace "1" normal spaced ||| Full
    , startupHook = do
        startupHook desktopConfig
        setFullscreenSupported
        --spawn "alttab"
    }
    `additionalKeysP`
        [ ("M-i", withFocused minimizeWindow)
        , ("M-S-i", withLastMinimized maximizeWindowAndFocus)
        , ("M-k", focusUp)
        , ("M-j", focusDown)
        , ("M-m", focusMaster)
        , ("M-<Return>", spawn myTerminal)
        --, ("A-<Tab>", windows W.focusDown)
        , ("M-<Tab>", nextWS)
        , ("M-S-<Tab>", prevWS)
        , ("M-q", kill)
        , ("M-S-R", spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
        --, ("", )
        --, ("", )
        --, ("M-u", doCenterFloat)
        ]

myTerminal = "alacritty"

spaced = spacing 10 $ gaps [(L,10), (R,10), (U,10), (D,10)] $ Tall 1 (3/100) (1/2)
normal = Tall 1 (3/100) (1/2)
