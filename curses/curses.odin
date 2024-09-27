package curses

when ODIN_OS == .Linux {
    foreign import lib "system:curses"
}

@(default_calling_convention="c")
foreign lib {
    initscr :: proc() ---
    printw:: proc(s: cstring) ---
    refresh:: proc() ---
    getch:: proc() ---
    endwin:: proc() ---
}

