package curses

import "core:c"
import "core:c/libc" // FILE

when ODIN_OS == .Linux {
    foreign import libcurses "system:curses"
}

chtype :: c.uint
attr_t :: chtype
WINDOW :: struct {}
SCREEN :: struct {}

// colors
COLOR_BLACK   :: 0
COLOR_RED     :: 1
COLOR_GREEN   :: 2
COLOR_YELLOW  :: 3
COLOR_BLUE    :: 4
COLOR_MAGENTA :: 5
COLOR_CYAN    :: 6
COLOR_WHITE   :: 7

KEY_F0 :: 0o410
KEY_F :: proc(n : chtype) -> chtype {
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



COLOR_PAIR :: proc(n: chtype) -> chtype {
    return NCURSES_BITS(n, 0) & A_COLOR
}

// MACROS in C
getyx :: proc(win: ^WINDOW) -> (row, col : c.int){
    return getcury(win), getcurx(win)
}

getbegyx :: proc(win: ^WINDOW) -> (row, col : c.int) {
    return getbegy(win), getbegx(win)
}

getmaxyx :: proc(win: ^WINDOW) -> (row, col : c.int) {
    return getmaxy(win), getmaxx(win)
}

getparyx :: proc(win: ^WINDOW) -> (row, col : c.int) {
    return getpary(win), getparx(win)
}


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
    initscr  :: proc() -> ^WINDOW ---
    endwin   :: proc() -> c.int ---
    isendwin :: proc() -> c.bool ---
    newterm :: proc(type: ^c.char, outf, inf: ^libc.FILE) -> ^SCREEN ---
    set_term :: proc(new: ^SCREEN) -> ^SCREEN ---
    delscreen :: proc(sp: ^SCREEN) ---

    // Write formated output to a curses window
    printw    :: proc(fmt: cstring, #c_vararg args: ..any) -> c.int ---
    wprintw   :: proc(win :^WINDOW, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    mvprintw  :: proc(row, col : c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    mvwprintw :: proc(win :^WINDOW, row, col : c.int, fmt: cstring, #c_vararg args: ..any) -> c.int ---
    vw_printw :: proc(win :^WINDOW, fmt: cstring, varglist: c.va_list) -> c.int ---

    // Refresh curses windows or lines thereupon
    refresh      :: proc() -> c.int ---
    wrefresh     :: proc(win :^WINDOW) -> c.int ---
    wnoutrefresh :: proc(win :^WINDOW) -> c.int ---
    doupdate     :: proc() -> c.int ---
    redrawwin    :: proc(win :^WINDOW) -> c.int ---
    wredrawln    :: proc(win :^WINDOW, beg_lines, num_lines : c.int) -> c.int ---

    // Get (or push back) characters from curses terminal keyboard
    getch    :: proc() -> c.int ---
    wgetch   :: proc(win :^WINDOW) -> c.int ---
    mvgetch  :: proc(row, col : c.int) -> c.int ---
    mvwgetch :: proc(win :^WINDOW) -> c.int ---
    ungetch  :: proc(char : c.int) -> c.int ---
    has_key  :: proc(char : c.int) -> c.int ---

    // Get and set curses terminal input options
    cbreak    :: proc() -> c.int ---
    nocbreak  :: proc() -> c.int ---
    echo      :: proc() -> c.int ---
    noecho    :: proc() -> c.int ---
    intrflush :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    keypad    :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    meta      :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    nodelay   :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    notimeout :: proc(win :^WINDOW, bf : c.bool) -> c.int ---
    nl        :: proc() -> c.int ---
    nonl      :: proc() -> c.int ---
    raw       :: proc() -> c.int ---
    noraw     :: proc() -> c.int ---
    qiflush   :: proc() ---
    noqiflush :: proc() ---
    halfdelay :: proc(tenths : c.int) -> c.int ---
    timeout   :: proc(delay : c.int) ---
    wtimeout  :: proc(win :^WINDOW, delay : c.int) ---
    typeahead :: proc(fd : c.int) -> c.int ---
    is_cbreak :: proc() -> c.int ---
    is_echo   :: proc() -> c.int ---
    is_nl     :: proc() -> c.int ---
    is_raw    :: proc() -> c.int ---

    // Manipulate attributes of character cells in curses windows
    attr_get   :: proc(attrs : ^attr_t, pair : ^c.short, opts : rawptr) -> c.int ---
    wattr_get  :: proc(win :^WINDOW, attrs : ^attr_t, pair : ^c.short, opts : rawptr) -> c.int ---
    attr_set   :: proc(attrs : attr_t, pair : c.short, opts : rawptr) -> c.int ---
    wattr_set  :: proc(win :^WINDOW, attrs : attr_t, pair : c.short, opts : rawptr) -> c.int ---
    attr_off   :: proc(attrs : ^attr_t, opts : rawptr) -> c.int ---
    wattr_off  :: proc(win :^WINDOW, attrs : ^attr_t, opts : rawptr) -> c.int ---
    attr_on    :: proc(attrs : attr_t, opts : rawptr) -> c.int ---
    wattr_on   :: proc(win :^WINDOW, attrs : attr_t, opts : rawptr) -> c.int ---
    attroff    :: proc(attrs : attr_t) -> c.int ---
    wattroff   :: proc(win :^WINDOW, attrs : c.int) -> c.int ---
    attron     :: proc(attrs : attr_t) -> c.int ---
    wattron    :: proc(win :^WINDOW, attrs : c.int) -> c.int ---
    attrset    :: proc(attrs : attr_t) -> c.int ---
    wattrset   :: proc(win :^WINDOW, attrs : c.int) -> c.int ---
    chgat      :: proc(n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    wchgat     :: proc(win :^WINDOW, n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    mvchgat    :: proc(row, col : c.int, n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    mvwchgat   :: proc(win :^WINDOW, row, col : c.int, n : c.int, attr : attr_t, pair : c.short, opts :rawptr) -> c.int ---
    color_set  :: proc(pair : c.short, opts: rawptr) -> c.int ---
    wcolor_set :: proc(win :^WINDOW, pair : c.short, opts: rawptr) -> c.int ---
    standend   :: proc() -> c.int ---
    wstandend  :: proc(win :^WINDOW) -> c.int ---
    standout   :: proc() -> c.int ---
    wstandout  :: proc(win :^WINDOW) -> c.int ---

    // Add a curses character to a window and advance the cursor
    addch     :: proc(ch : chtype) -> c.int ---
    waddch    :: proc(win: ^WINDOW, ch : chtype) -> c.int ---
    mvaddch   :: proc(row, col : c.int, ch : chtype) -> c.int ---
    mvwaddch  :: proc(win: ^WINDOW, row, col : c.int, ch : chtype) -> c.int ---
    echochar  :: proc(ch : chtype) -> c.int ---
    wechochar :: proc(win: ^WINDOW, ch : chtype) -> c.int ---

    // Get curses cursor and window coordinates or attributes (legacy)
    getattrs :: proc(win :^WINDOW) -> c.int ---
    getbegx  :: proc(win :^WINDOW) -> c.int ---
    getbegy  :: proc(win :^WINDOW) -> c.int ---
    getcurx  :: proc(win :^WINDOW) -> c.int ---
    getcury  :: proc(win :^WINDOW) -> c.int ---
    getmaxx  :: proc(win :^WINDOW) -> c.int ---
    getmaxy  :: proc(win :^WINDOW) -> c.int ---
    getparx  :: proc(win :^WINDOW) -> c.int ---
    getpary  :: proc(win :^WINDOW) -> c.int ---

    // Move cursor in a curses window
    move  :: proc(row, col : c.int) -> c.int ---
    wmove :: proc(win :^WINDOW, row, col : c.int) -> c.int ---

    // Clear all or part of a curses window
    erase     :: proc() -> c.int ---
    werase    :: proc(win :^WINDOW) -> c.int ---
    clear     :: proc() -> c.int ---
    wclear    :: proc(win :^WINDOW) -> c.int ---
    clrtobot  :: proc() -> c.int ---
    wclrtobot :: proc(win :^WINDOW) -> c.int ---
    clrtoeol  :: proc() -> c.int ---
    wclrtoeol :: proc(win :^WINDOW) -> c.int ---

    // Create and manipulate curses windows
    newwin     :: proc(nlines, ncols, begin_y, begin_x : c.int) -> ^WINDOW ---
    delwin     :: proc(win : ^WINDOW) -> c.int ---
    mvwin      :: proc(win : ^WINDOW, row, col : c.int) -> c.int ---
    subwin     :: proc(orig : ^WINDOW, nlines, ncols, begin_y, begin_x : c.int) -> ^WINDOW ---
    derwin     :: proc(orig : ^WINDOW, nlines, ncols, begin_y, begin_x : c.int) -> ^WINDOW ---
    mvderwin   :: proc(orig : ^WINDOW, par_row, par_col : c.int) -> c.int ---
    dupwin     :: proc(win : ^WINDOW) -> ^WINDOW ---
    wsyncup    :: proc(win : ^WINDOW) ---
    syncok     :: proc(win : ^WINDOW, bf : bool) -> c.int ---
    wcursyncup :: proc(win : ^WINDOW) ---
    wsyncodwn  :: proc(win : ^WINDOW) ---

    // Draw borders and lines in a curses window of characters
    border   :: proc(ls, rs, ts, bs, tl, tr, bl, br : chtype) -> c.int ---
    wborder  :: proc(win : ^WINDOW, ls, rs, ts, bs, tl, tr, bl, br : chtype) -> c.int ---
    box      :: proc(win : ^WINDOW, verch, horch : chtype) -> c.int ---
    hline    :: proc(ch : chtype, n: c.int) -> c.int ---
    whline   :: proc(win : ^WINDOW, ch : chtype, n: c.int) -> c.int ---
    vline    :: proc(ch : chtype, n: c.int) -> c.int ---
    wvline   :: proc(win : ^WINDOW, ch : chtype, n: c.int) -> c.int ---
    mvhline  :: proc(row, col : c.int, ch: chtype, n : c.int) -> c.int ---
    mvwhline :: proc(win : ^WINDOW, row, col : c.int, ch: chtype, n : c.int) -> c.int ---
    mvvline  :: proc(row, col : c.int, ch: chtype, n : c.int) -> c.int ---
    mvwvline :: proc(win : ^WINDOW, row, col : c.int, ch: chtype, n : c.int) -> c.int ---

    // Manipulate terminal colors with curses
    start_colors           :: proc() -> c.int ---
    has_colors             :: proc() -> c.bool ---
    can_change_color       :: proc() -> c.bool ---
    init_pair              :: proc(pair, f, b : c.short) -> c.int ---
    init_color             :: proc(color, r, g, b : c.short) -> c.int ---
    init_extended_pair     :: proc(pair, f, b : c.int) -> c.int ---
    init_extended_color    :: proc(color, r, g, b : c.int) -> c.int ---
    color_content          :: proc(color, r, g, b : c.short) -> c.int ---
    pair_content           :: proc(pair, f, b : c.short) -> c.int ---
    extended_color_content :: proc(color, r, g, b : c.int) -> c.int ---
    extended_pair_content  :: proc(pair, f, b : c.int) -> c.int ---
    reset_color_pairs      :: proc() ---
}

