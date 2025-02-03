#!bin/bash

xboxdrv --evdev /dev/input/event5 --evdev-absmap ABS_RZ=Y2,ABS_Z=X2,ABS_Y=Y1,ABS_X=X1,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y --evdev-keymap BTN_C=a,BTN_EAST=b,BTN_NORTH=x,BTN_SOUTH=y,BTN_WEST=lb,BTN_Z=rb,BTN_TL=lt,BTN_TR=rt,BTN_SELECT=tl,BTN_START=tr,BTN_TL2=back,BTN_TR2=start,BTN_MODE=guide --mimic-xpad --deadzone 15% --axismap "-Y1=Y1,-Y2=Y2" 
