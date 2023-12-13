{
  home-manager.users.radik = {
    services.sxhkd = {
      enable = true;
      keybindings = {
        # Multimedia keys
        "XF86AudioRaiseVolume" = "amixer -q set Master 2%+ unmute";

        # dec vol
        "XF86AudioLowerVolume" = "amixer -q set Master 2%- unmute";

        # mute sound
        "XF86AudioMute" = "amixer -q set Master toggle";

        # mute mic
        "XF86AudioMicMute" = "amixer -q set Capture toggle";

        # Control Brightness
        # dec
        "XF86MonBrightnessDown" = "light -U 5";

        # inc
        "XF86MonBrightnessUp" = "light -A 5";

        # bluetooth headset media key
        "XF86AudioPlay" = "playerctl play-pause";
        "XF86AudioPause" = "playerctl play-pause";
        "XF86AudioNext" = "playerctl next";

        # take screenshot
        "Print" = "flameshot gui";

        # lockscreen
        # "ctrl + shift + x" = "";

        # terminal emulator
        "super + Return" = "kitty";

        # program launcher
        "super + @space" = "rofi -show run";

        # make sxhkd reload its configuration files:
        "super + Escape" = "pkill -USR1 -x sxhkd";

        # bspwm hotkeys
        #

        # quit/restart bspwm
        "super + alt + {q,r}" = "bspc {quit,wm -r}";

        # close and kill
        "super + {_,shift + }w" = "bspc node -{c,k}";
        #
        # alternate between the tiled and monocle layout
        "super + m" = "bspc desktop -l next";

        # send the newest marked node to the newest preselected node
        "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";

        # swap the current node and the biggest window
        "super + g" = "bspc node -s biggest.window";

        #
        # state/flags
        #

        # set the window state
        "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

        # set the node flags
        "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";

        #
        # focus/swap
        #

        # focus the node in the given direction
        "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";

        # focus the node for the given path jump
        "super + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";

        # focus the next/previous window in the current desktop
        "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";

        # focus the next/previous desktop in the current monitor
        "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";

        # focus the last node/desktop
        "super + {grave,Tab}" = "bspc {node,desktop} -f last";

        # focus the older or newer node in the focus history
        "super + {o,i}" = "bspc wm -h off; \
	bspc node {older,newer} -f; \
	bspc wm -h on";

        # focus or send to the given desktop
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

        #
        # preselect
        #

        # preselect the direction
        "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";

        # preselect the ratio
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

        # cancel the preselection for the focused node
        "super + ctrl + space" = "bspc node -p cancel";

        # cancel the preselection for the focused desktop
        "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

        #
        # move/resize
        #

        # expand a window by moving one of its side outward
        "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

        # contract a window by moving one of its side inward
        "super + alt + ctrl + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

        # move a floating window
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";

      };
    };
  };
}
