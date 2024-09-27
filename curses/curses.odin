package curses

import "core:c"

when ODIN_OS == .Linux {
    foreign import libcurses "system:curses"
}

ldat :: struct {}

NCURSES_SIZE_T :: c.short

pdat :: struct {
    _pad_y,      _pad_x     : NCURSES_SIZE_T,
    _pad_top,    _pad_left  : NCURSES_SIZE_T,
    _pad_bottom, _pad_right : NCURSES_SIZE_T,
} 

// typedef chtype  attr_t;    
// typedef unsigned chtype;
// define NCURSES_CH_T cchar_t 

chtype :: c.uint
attr_t :: chtype

CCHARW_MAX :: 5
cchar_t :: struct  {
    attr  :attr_t,
    chars :   [CCHARW_MAX]c.wchar_t,
    ext_color : c.int,
}

// TODO: Verify if I realy need to declare this struct
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

KEY_F0 :: 0o410
KEY_F :: proc(n : c.int) -> c.int {
    return KEY_F0 + n
}


NCURSES_ATTR_SHIFT :: 8
NCURSES_BITS :: proc(mask : chtype, shift :chtype) -> chtype {
    return mask << ( shift + NCURSES_ATTR_SHIFT)
}
A_NORMAL :: 0
//A_ATTRIBUTES := NCURSES_BITS(~(1 - 1),0)
A_CHARTEXT   := (NCURSES_BITS(1,0) - 1)
A_COLOR      := NCURSES_BITS(((1) << 8) - 1,0)
A_STANDOUT   := NCURSES_BITS(1, 8)
A_UNDERLINE  := NCURSES_BITS(1, 9)
A_REVERSE    := NCURSES_BITS(1, 10)
A_BLINK      := NCURSES_BITS(1, 11)
A_DIM        := NCURSES_BITS(1, 12)
A_BOLD       := NCURSES_BITS(1, 13)
A_ALTCHARSET := NCURSES_BITS(1, 14)
A_INVIS      := NCURSES_BITS(1, 15)
A_PROTECT    := NCURSES_BITS(1, 16)
A_HORIZONTAL := NCURSES_BITS(1, 17)
A_LEFT       := NCURSES_BITS(1, 18)
A_LOW        := NCURSES_BITS(1, 19)
A_RIGHT      := NCURSES_BITS(1, 20)
A_TOP        := NCURSES_BITS(1, 21)
A_VERTICAL   := NCURSES_BITS(1, 22)
A_ITALIC     := NCURSES_BITS(1, 23)


@(default_calling_convention="c")
foreign libcurses {
    // Variables
    cruscr : ^WINDOW
    stdscr : ^WINDOW
    newscr : ^WINDOW
    COLORS : c.int
    COLOR_PAIRS : c.int
    COLS : c.int
    LINES : c.int
    ESCDELAY : c.int
    TABSIZE : c.int

    // Initialize, manipulate, or tear down curses terminal interface
    initscr :: proc() -> ^WINDOW ---
    endwin :: proc() -> c.int ---
    isendwin :: proc() -> c.bool ---
    // newterm :: proc(type: ^c.char, outf, inf: ^FILE) -> ^SCREEN ---
    // set_term :: proc(new: ^SCREEN) -> ^SCREEN ---
    // delscreen :: proc(sp: ^SCREEN) ---

    // Write formated output to a curses window
    printw :: proc(fmt: cstring, #c_vararg args: ..any) -> c.int ---
    wprintw :: proc(win :^WINDOW, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    mvprintw :: proc(x, y : c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    mvwprintw :: proc(win :^WINDOW, x, y : c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    vw_printw :: proc(win :^WINDOW, fmt: cstring, varglist: c.va_list) -> c.int ---

    // Refresh curses windows or lines thereupon
    refresh :: proc() -> c.int ---
    wrefresh :: proc(win :^WINDOW) -> c.int ---
    wnoutrefresh :: proc(win :^WINDOW) -> c.int ---
    doupdate :: proc() -> c.int ---
    redrawwin :: proc(win :^WINDOW) -> c.int ---
    wredrawln :: proc(win :^WINDOW, beg_lines, num_lines : c.int) -> c.int ---

    // Get (or push back) characters from curses terminal keyboard
    getch :: proc() -> c.int ---
    wgetch :: proc(win :^WINDOW) -> c.int ---
    mvgetch :: proc(x, y : c.int) -> c.int ---
    mvwgetch :: proc(win :^WINDOW) -> c.int ---
    ungetch :: proc(char : c.int) -> c.int ---
    has_key :: proc(char : c.int) -> c.int ---

    // Get and set curses terminal input options
    cbreak :: proc() -> c.int ---
    nocbreak :: proc() -> c.int ---
    echo :: proc() -> c.int ---
    noecho  :: proc() -> c.int ---
    intrflush :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    keypad :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    meta :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    nodelay :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    notimeout :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    nl :: proc() -> c.int ---
    nonl :: proc() -> c.int ---
    raw :: proc() -> c.int ---
    noraw :: proc() -> c.int ---
    qiflush :: proc() ---
    noqiflush :: proc() ---
    halfdelay:: proc(tenths : c.int) -> c.int ---
    timeout:: proc(delay : c.int) ---
    wtimeout:: proc(win :^WINDOW, delay : c.int) ---
    typeahead :: proc(fd : c.int) -> c.int ---
    is_cbreak :: proc() -> c.int ---
    is_echo :: proc() -> c.int ---
    is_nl :: proc() -> c.int ---
    is_raw :: proc() -> c.int ---

    // manipulate attributes of character cells in curses windows
    attr_get :: proc(attrs : ^attr_t, pair : ^c.short, opts : rawptr) -> c.int ---
    wattr_get :: proc(win :^WINDOW, attrs : ^attr_t, pair : ^c.short, opts : rawptr) -> c.int ---
    attr_set :: proc(attrs : attr_t, pair : c.short, opts : rawptr) -> c.int ---
    wattr_set :: proc(win :^WINDOW, attrs : attr_t, pair : c.short, opts : rawptr) -> c.int ---
    attr_off :: proc(attrs : ^attr_t, opts : rawptr) -> c.int ---
    wattr_off :: proc(win :^WINDOW, attrs : ^attr_t, opts : rawptr) -> c.int ---
    attr_on :: proc(attrs : attr_t, opts : rawptr) -> c.int ---
    wattr_on :: proc(win :^WINDOW, attrs : attr_t, opts : rawptr) -> c.int ---
    attroff :: proc(attrs : attr_t) -> c.int ---
    wattroff :: proc(win :^WINDOW, attrs : c.int) -> c.int ---
    attron :: proc(attrs : attr_t) -> c.int ---
    wattron :: proc(win :^WINDOW, attrs : c.int) -> c.int ---
    attrset :: proc(attrs : attr_t) -> c.int ---
    wattrset :: proc(win :^WINDOW, attrs : c.int) -> c.int ---
    chgat :: proc(n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    wchgat :: proc(win :^WINDOW, n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    mvchgat :: proc(y,x : c.int, n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    mvwchgat :: proc(win :^WINDOW, y,x : c.int, n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    color_set :: proc(pair : c.short, opts: rawptr) -> c.int ---
    wcolor_set :: proc(win :^WINDOW, pair : c.short, opts: rawptr) -> c.int ---
    standend :: proc() -> c.int ---
    wstandend :: proc(win :^WINDOW) -> c.int ---
    standout :: proc() -> c.int ---
    wstandout :: proc(win :^WINDOW) -> c.int ---
}

