#include<stdio.h>
#include <stdlib.h>
#include<iostream>
#include<time.h>
#include<stdlib.h>
#include<X11/Xlib.h>
#include<X11/cursorfont.h>
#include<unistd.h>
#include<string>
#include<sstream>

// original from [https://bbs.archlinux.org/viewtopic.php?id=85378 Select a screen area with mouse and return the geometry of this area? / Programming & Scripting / Arch Linux Forums]
// build with (Ubuntu 16.04):
// gcc select_screen.c -o select_screen -lX11

const std::string currentDateTime() {
    time_t     now = time(0);
    struct tm  tstruct;
    char       buf[80];
    tstruct = *localtime(&now);
    // Visit http://en.cppreference.com/w/cpp/chrono/c/strftime
    // for more information about date/time format
    strftime(buf, sizeof(buf), "%Y-%m-%d.%X", &tstruct);

    return buf;
}

void printHelper(){
    std::cout<< "select_screen [duration in second]"<< std::endl;
    std::cout<< "default duration to 10 secs"<< std::endl;
}

int main(int argc, char ** argv)
{
  int duration_record = 3;
  if(argc > 2 ){
      duration_record = atoi(argv[1]);
  }
  std::cout<< "Please select a zone to record a Gif" << std::endl;
  int rx = 0, ry = 0, rw = 0, rh = 0;
  int rect_x = 0, rect_y = 0, rect_w = 0, rect_h = 0;
  int btn_pressed = 0, done = 0;

  XEvent ev;
  Display *disp = XOpenDisplay(NULL);

  if(!disp)
    return EXIT_FAILURE;

  Screen *scr = NULL;
  scr = ScreenOfDisplay(disp, DefaultScreen(disp));

  Window root = 0;
  root = RootWindow(disp, XScreenNumberOfScreen(scr));

  Cursor cursor, cursor2;
  cursor = XCreateFontCursor(disp, XC_left_ptr);
  cursor2 = XCreateFontCursor(disp, XC_lr_angle);

  XGCValues gcval;
  gcval.foreground = XWhitePixel(disp, 0);
  gcval.function = GXxor;
  gcval.background = XBlackPixel(disp, 0);
  gcval.plane_mask = gcval.background ^ gcval.foreground;
  gcval.subwindow_mode = IncludeInferiors;

  GC gc;
  gc = XCreateGC(disp, root,
                 GCFunction | GCForeground | GCBackground | GCSubwindowMode,
                 &gcval);

  /* this XGrab* stuff makes XPending true ? */
  if ((XGrabPointer
       (disp, root, False,
        ButtonMotionMask | ButtonPressMask | ButtonReleaseMask, GrabModeAsync,
        GrabModeAsync, root, cursor, CurrentTime) != GrabSuccess))
    printf("couldn't grab pointer:");

  // see also: http://stackoverflow.com/questions/19659486/xpending-cycle-is-making-cpu-100
  while (!done) {
    if (!XPending(disp)) { usleep(1000); continue; }
    if ( (XNextEvent(disp, &ev) >= 0) ) {
      switch (ev.type) {
        case MotionNotify:
        /* this case is purely for drawing rect on screen */
          if (btn_pressed) {
            if (rect_w) {
              /* re-draw the last rect to clear it */
              XDrawRectangle(disp, root, gc, rect_x, rect_y, rect_w, rect_h);
            } else {
              /* Change the cursor to show we're selecting a region */
              XChangeActivePointerGrab(disp,
                                       ButtonMotionMask | ButtonReleaseMask,
                                       cursor2, CurrentTime);
            }
            rect_x = rx;
            rect_y = ry;
            rect_w = ev.xmotion.x - rect_x;
            rect_h = ev.xmotion.y - rect_y;

            if (rect_w < 0) {
              rect_x += rect_w;
              rect_w = 0 - rect_w;
            }
            if (rect_h < 0) {
              rect_y += rect_h;
              rect_h = 0 - rect_h;
            }
            /* draw rectangle */
            XDrawRectangle(disp, root, gc, rect_x, rect_y, rect_w, rect_h);
            XFlush(disp);
          }
          break;
        case ButtonPress:
          btn_pressed = 1;
          rx = ev.xbutton.x;
          ry = ev.xbutton.y;
          break;
        case ButtonRelease:
          done = 1;
          break;
      }
    }
  }
  /* clear the drawn rectangle */
  if (rect_w) {
    XDrawRectangle(disp, root, gc, rect_x, rect_y, rect_w, rect_h);
    XFlush(disp);
  }
  rw = ev.xbutton.x - rx;
  rh = ev.xbutton.y - ry;
  /* cursor moves backwards */
  if (rw < 0) {
    rx += rw;
    rw = 0 - rw;
  }
  if (rh < 0) {
    ry += rh;
    rh = 0 - rh;
  }

  XCloseDisplay(disp);

  const  std::string kill_notification("; sleep 3 ; killall notify-osd");

  std::stringstream ss_notification;
  ss_notification << "notify-send -u normal -t 2000 Gif_recorder \"starting the record in 3 secs\"" << kill_notification;
  std::string notification(ss_notification.str());

  std::stringstream ss_filename;
  ss_filename << "/home/beuzeboc/Pictures/gifs/gif" << currentDateTime() << ".gif";
  std::string filename(ss_filename.str());

  std::stringstream ss_cmd;
  ss_cmd << "byzanz-record -d " <<duration_record <<" --delay=3 -x " << rx << " -y " << ry << " -w " << rw << " -h " << rh << " " << filename;
  std::string cmd = ss_cmd.str();

  std::stringstream ss_notification_out;
  ss_notification_out << "notify-send -u normal -t 2000 Gif_recorder " << "\"gif_sucessfully recorded:  " << filename << "\"" << kill_notification;
  std::string notification_out = ss_notification_out.str();

  system(notification.c_str());
  system(cmd.c_str());
  system(notification_out.c_str());
  std::cout << "Gif " << filename << " sucessfully recorded!" << std::endl;

  return EXIT_SUCCESS;
}
