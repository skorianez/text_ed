package junk

import "core:c"

// junk
// Not used in bindings (FOR NOW!)

// used in bindings
chtype :: c.uint
attr_t :: chtype

//////////

ldat :: struct {}

NCURSES_SIZE_T :: c.short

pdat :: struct {
    _pad_y,      _pad_x     : NCURSES_SIZE_T,
    _pad_top,    _pad_left  : NCURSES_SIZE_T,
    _pad_bottom, _pad_right : NCURSES_SIZE_T,
} 


CCHARW_MAX :: 5
cchar_t :: struct  {
    attr  :attr_t,
    chars :   [CCHARW_MAX]c.wchar_t,
    ext_color : c.int,
}

WINDOW :: struct {

    _cury, _curx : NCURSES_SIZE_T,  // current cursor position

    // window location and size 
    _maxy, _maxx: NCURSES_SIZE_T,   // maximums of x and y, NOT window size
    _begy, _begx: NCURSES_SIZE_T,   // screen coords of upper-left-hand corner

    _flags: c.short,                // window state flags

    // attribute tracking
    _attrs : attr_t,        // current attribute for non-space character
    _bkgd : chtype,         // current background char/attribute pair

    // option values set by user
    _notimeout : c.bool,    // no time out on function-key entry?
    _clear     : c.bool,    // consider all data in the window invalid?
    _leaveok   : c.bool,    // OK to not reset cursor on exit?
    _scroll    : c.bool,    // OK to scroll this window?
    _idlok     : c.bool,    // OK to use insert/delete line?
    _idcok     : c.bool,    // OK to use insert/delete char?
    _immed     : c.bool,    // window in immed mode? (not yet used)
    _sync      : c.bool,    // window in sync mode?
    _use_keypad: c.bool,    // process function keys into KEY_ symbols?
    _delay : c.int,         // 0 = nodelay, <0 = blocking, >0 = delay

    _line : ^ldat,          // the actual line data

    // global screen state
    _regtop : NCURSES_SIZE_T,       // top line of scrolling region
    _regbottom : NCURSES_SIZE_T,    // bottom line of scrolling region

    // these are used only if this is a sub-window 
    _parx : c.int,          // x coordinate of this window in parent
    _pary : c.int,          // y coordinate of this window in parent
    _parent : ^WINDOW ,      // pointer to parent if a sub-window

    // these are used only if this is a pad 
    _pad : pdat,

    _yoffset: NCURSES_SIZE_T,  // real begy is _begy + _yoffset

    _bkgrnd: cchar_t,   // current background char/attribute pair
    _color: c.int,      // current color-pair for non-space character
}