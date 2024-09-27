package main

import "core:c"
import cur "curses"

Player :: struct {
    xLoc, yLoc : c.int, 
    xMax, yMax : c.int,
    character : cur.chtype,
    curwin : ^cur.WINDOW
}

p_new :: proc(win: ^cur.WINDOW, y,x : c.int, c : cur.chtype) -> Player {
    
    ymax, xmax := cur.getmaxyx(win)
    cur.keypad(win, true)
    return {
        curwin = win,
        xLoc = x,
        yLoc = y,
        xMax = xmax,
        yMax = ymax,
        character = c,
    }
}

p_mvup ::proc (p : ^Player) {
    cur.mvwaddch( p.curwin, p.yLoc, p.xLoc, ' ')
    p.yLoc -= 1
    if p.yLoc < 1 {
        p.yLoc = 1
    }
}

p_mvdown  ::proc (p : ^Player) {
    cur.mvwaddch( p.curwin, p.yLoc, p.xLoc, ' ')
    p.yLoc += 1
    if p.yLoc > p.yMax - 2 {
        p.yLoc = p.yMax - 2
    }
}

p_mvleft  ::proc (p : ^Player) {
    cur.mvwaddch( p.curwin, p.yLoc, p.xLoc, ' ')
    p.xLoc -= 1
    if p.xLoc < 1 {
        p.xLoc = 1
    }
}

p_mvright ::proc (p : ^Player) {
    cur.mvwaddch( p.curwin, p.yLoc, p.xLoc, ' ')
    p.xLoc += 1
    if p.xLoc > p.xMax - 2 {
        p.xLoc = p.xMax - 2
    }
}

p_getmv   ::proc (p : ^Player) -> c.int {
    choice := cur.wgetch(p.curwin)
    switch choice {
        case cur.KEY_UP:
            p_mvup(p)
        case cur.KEY_DOWN:
            p_mvdown(p)
        case cur.KEY_LEFT:
            p_mvleft(p)
        case cur.KEY_RIGHT:
            p_mvright(p)
        case:
            break
    }
    return choice
}

p_display ::proc (p : ^Player) {
    cur.mvwaddch( p.curwin, p.yLoc, p.xLoc, p.character )
}
