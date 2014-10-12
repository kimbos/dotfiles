import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing  
import XMonad.Layout.PerWorkspace  
import XMonad.Layout.NoBorders  
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO



myTerminal      = "xterm"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myModMask       = mod4Mask

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myBorderWidth   = 1 
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#55ccff"


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    

    , ((modm .|. shiftMask, xK_o     ), spawn "google-chrome")
    , ((modm .|. shiftMask, xK_i     ), spawn "iceweasel")


    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_f     ), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_p     ), spawn "xmonad --recompile; xmonad --restart")]
    ++

    -- Switch workspace
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:
webLayout = web ||| tiled ||| Mirror tiled ||| Full
  where
	tiled = Tall masterwindows delta (5/10)
	web = Tall masterwindows delta (6/10)
     
	masterwindows = 1
	delta   = (5/100)

myLayout = spacing 0 $ webLayout



-----------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = (composeAll . concat $
    [ [resource     =? r            --> doIgnore           |   r   <- myIgnores] 
    , [className    =? c            --> doShift  "2"   |   c   <- myWorkSpace2   ]
    , [className    =? c            --> doShift  "3"   |   c	<- myWorkSpace3   ]
	, [className    =? c            --> doShift  "4"   |   c   <- myWorkSpace4   ]
	, [className    =? c            --> doShift  "5"   |   c   <- myWorkSpace5   ] 
    , [className    =? c            --> doShift  "6"   |   c   <- myWorkSpace6   ] 
	, [className    =? c            --> doShift  "7"   |   c   <- myWorkSpace7   ] 
	, [className    =? c            --> doShift  "8"   |   c   <- myWorkSpace8   ] 
	, [className    =? c            --> doShift  "9"   |   c   <- myWorkSpace9   ] 
    ])

    where   
       -- classnames
		myWorkSpace2 = ["Chromium"]	
		myWorkSpace3 = ["weechat"]
		myWorkSpace4 = ["e4"]
		myWorkSpace5 = ["xfreerdp"]
		myWorkSpace6 = ["Gimp"]
		myWorkSpace7 = ["e7"]
		myWorkSpace8 = ["e8"]
		myWorkSpace9 = ["Firefox"]
        
	-- resources
		myIgnores = ["desktop","desktop_window","notify-osd","stalonetray","trayer"]
        
------------------------------------------------------------------------
-- Event handling

myEventHook = mempty

------------------------------------------------------------------------
-- Startup hook

myStartupHook :: X ()
myStartupHook = do
	spawn "xterm -e \"feh --bg-fill /home/kimbo/Backgrounds/bg.jpg && exit\""
	spawn "xcompmgr"
	spawnOn "3" ("xterm -e weechat") 

------------------------------------------------------------------------


main = do
	xmproc <- spawnPipe "xmobar" 
	xmonad $ defaultConfig {
        	manageHook = manageDocks <+> myManageHook,
		layoutHook = avoidStruts $ myLayout,	

		logHook = dynamicLogWithPP xmobarPP {
                ppTitle = xmobarColor "#333333" "" . shorten 80
				, ppCurrent = xmobarColor "#ffff00" ""
					. wrap "(" ")"
				, ppVisible = xmobarColor "#00ffff" ""
					. wrap "[" "]"
                },


        	terminal           = myTerminal,
        	focusFollowsMouse  = myFocusFollowsMouse,
	        --clickJustFocuses   = myClickJustFocuses,
	        borderWidth        = myBorderWidth,
	        modMask            = myModMask,
	        workspaces         = myWorkspaces,
	        normalBorderColor  = myNormalBorderColor,
        	focusedBorderColor = myFocusedBorderColor,

	        keys               = myKeys,
	        mouseBindings      = myMouseBindings,

	        handleEventHook    = myEventHook,
	        startupHook        = myStartupHook
    }
