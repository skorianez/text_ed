package curses

import "core:c"
import "core:c/libc" // FILE e wchart_t

when ODIN_OS == .Linux {
    foreign import libcurses "system:curses"
}

chtype :: c.uint
attr_t :: chtype
cchar_t:: struct {}
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

// KEYS
KEY_F :: proc(n : chtype) -> chtype {
    return KEY_F0 + n
}

KEY_DOWN      :: 0o402
KEY_UP        :: 0o403
KEY_LEFT      :: 0o404
KEY_RIGHT     :: 0o405
KEY_HOME      :: 0o406
KEY_BACKSPACE :: 0o407
KEY_F0        :: 0o410
KEY_DL        :: 0o510        /* delete-line key */
KEY_IL        :: 0o511        /* insert-line key */
KEY_DC        :: 0o512        /* delete-character key */
KEY_IC        :: 0o513        /* insert-character key */
KEY_EIC       :: 0o514        /* sent by rmir or smir in insert mode */
KEY_CLEAR     :: 0o515        /* clear-screen or erase key */
KEY_EOS       :: 0o516        /* clear-to-end-of-screen key */
KEY_EOL       :: 0o517        /* clear-to-end-of-line key */
KEY_SF        :: 0o520        /* scroll-forward key */
KEY_SR        :: 0o521        /* scroll-backward key */
KEY_NPAGE     :: 0o522        /* next-page key */
KEY_PPAGE     :: 0o523        /* previous-page key */
KEY_STAB      :: 0o524        /* set-tab key */
KEY_CTAB      :: 0o525        /* clear-tab key */
KEY_CATAB     :: 0o526        /* clear-all-tabs key */
KEY_ENTER     :: 0o527        /* enter/send key */
KEY_PRINT     :: 0o532        /* print key */
KEY_LL        :: 0o533        /* lower-left key (home down) */
KEY_A1        :: 0o534        /* upper left of keypad */
KEY_A3        :: 0o535        /* upper right of keypad */
KEY_B2        :: 0o536        /* center of keypad */
KEY_C1        :: 0o537        /* lower left of keypad */
KEY_C3        :: 0o540        /* lower right of keypad */
KEY_BTAB      :: 0o541        /* back-tab key */
KEY_BEG       :: 0o542        /* begin key */
KEY_CANCEL    :: 0o543        /* cancel key */
KEY_CLOSE     :: 0o544        /* close key */
KEY_COMMAND   :: 0o545        /* command key */
KEY_COPY      :: 0o546        /* copy key */
KEY_CREATE    :: 0o547        /* create key */
KEY_END       :: 0o550        /* end key */
KEY_EXIT      :: 0o551        /* exit key */
KEY_FIND      :: 0o552        /* find key */
KEY_HELP      :: 0o553        /* help key */
KEY_MARK      :: 0o554        /* mark key */
KEY_MESSAGE   :: 0o555        /* message key */
KEY_MOVE      :: 0o556        /* move key */
KEY_NEXT      :: 0o557        /* next key */
KEY_OPEN      :: 0o560        /* open key */
KEY_OPTIONS   :: 0o561        /* options key */
KEY_PREVIOUS  :: 0o562        /* previous key */
KEY_REDO      :: 0o563        /* redo key */
KEY_REFERENCE :: 0o564        /* reference key */
KEY_REFRESH   :: 0o565        /* refresh key */
KEY_REPLACE   :: 0o566        /* replace key */
KEY_RESTART   :: 0o567        /* restart key */
KEY_RESUME    :: 0o570        /* resume key */
KEY_SAVE      :: 0o571        /* save key */
KEY_SBEG      :: 0o572        /* shifted begin key */
KEY_SCANCEL   :: 0o573        /* shifted cancel key */
KEY_SCOMMAND  :: 0o574        /* shifted command key */
KEY_SCOPY     :: 0o575        /* shifted copy key */
KEY_SCREATE   :: 0o576        /* shifted create key */
KEY_SDC       :: 0o577        /* shifted delete-character key */
KEY_SDL       :: 0o600        /* shifted delete-line key */
KEY_SELECT    :: 0o601        /* select key */
KEY_SEND      :: 0o602        /* shifted end key */
KEY_SEOL      :: 0o603        /* shifted clear-to-end-of-line key */
KEY_SEXIT     :: 0o604        /* shifted exit key */
KEY_SFIND     :: 0o605        /* shifted find key */
KEY_SHELP     :: 0o606        /* shifted help key */
KEY_SHOME     :: 0o607        /* shifted home key */
KEY_SIC       :: 0o610        /* shifted insert-character key */
KEY_SLEFT     :: 0o611        /* shifted left-arrow key */
KEY_SMESSAGE  :: 0o612        /* shifted message key */
KEY_SMOVE     :: 0o613        /* shifted move key */
KEY_SNEXT     :: 0o614        /* shifted next key */
KEY_SOPTIONS  :: 0o615        /* shifted options key */
KEY_SPREVIOUS :: 0o616        /* shifted previous key */
KEY_SPRINT    :: 0o617        /* shifted print key */
KEY_SREDO     :: 0o620        /* shifted redo key */
KEY_SREPLACE  :: 0o621        /* shifted replace key */
KEY_SRIGHT    :: 0o622        /* shifted right-arrow key */
KEY_SRSUME    :: 0o623        /* shifted resume key */
KEY_SSAVE     :: 0o624        /* shifted save key */
KEY_SSUSPEND  :: 0o625        /* shifted suspend key */
KEY_SUNDO     :: 0o626        /* shifted undo key */
KEY_SUSPEND   :: 0o627        /* suspend key */
KEY_UNDO      :: 0o630        /* undo key */
KEY_MOUSE     :: 0o631        /* Mouse event has occurred */


NCURSES_ATTR_SHIFT :: 8
NCURSES_BITS :: proc(mask : chtype, shift :chtype) -> chtype {
    return mask << ( shift + NCURSES_ATTR_SHIFT)
}

A_NORMAL     :: 0
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
    start_color            :: proc() -> c.int ---
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

    // Low-level curses routines
    def_prog_mode    :: proc() -> c.int ---
    def_shell_mode   :: proc() -> c.int ---
    reset_prog_mode  :: proc() -> c.int ---
    reset_shell_mode :: proc() -> c.int ---
    resetty          :: proc() -> c.int ---
    savetty          :: proc() -> c.int ---
    getsyx           :: proc(row, col : c.int) ---
    setsyx           :: proc(row, col : c.int) ---
    // ripoffline
    curs_set         :: proc(visibility: c.int) -> c.int ---
    napms            :: proc(ms : c.int) -> c.int ---

    // Miscellaneous curses utility routines
    unctrl       :: proc(ch: chtype) -> cstring ---
    wunctrl      :: proc(wch: ^cchar_t) -> ^libc.wchar_t ---
    keyname      :: proc(c: c.int) -> cstring ---
    key_name     :: proc(wc: libc.wchar_t) -> string ---
    filter       :: proc() ---
    use_env      :: proc(f : bool) ---
    putwin       :: proc(win: ^WINDOW, filep: ^libc.FILE) -> c.int ---
    getwin       :: proc(filep : ^libc.FILE) -> ^WINDOW ---
    delay_output :: proc(ms: c.int) -> c.int ---
    flushinp     :: proc() -> c.int ---
    nofilter     :: proc() ---
    use_tioctl   :: proc(f: bool) ---

    // Set curses output options
    clearok    :: proc(win: ^WINDOW, bl : bool) -> c.int ---
    idlok      :: proc(win: ^WINDOW, bl : bool) -> c.int ---
    idcok      :: proc(win: ^WINDOW, bl : bool)  ---
    immedok    :: proc(win: ^WINDOW, bl : bool) ---
    leaveok    :: proc(win: ^WINDOW, bl : bool) -> c.int ---
    scrollok   :: proc(win: ^WINDOW, bl : bool) -> c.int ---
    setscrreg  :: proc(top, bot : c.int) -> c.int ---
    wsetscrreg :: proc(win: ^WINDOW, top, bot : c.int) -> c.int ---

}

