package main

import cur "curses"

main :: proc(){
    cur.initscr()               // start curses mode
    defer cur.endwin()          // defer end curses mode

    //cur.nocbreak()            // Avoid ctrl+C
    cur.raw()                   // Captura todas as teclas, inclusive Ctrl+C
    cur.noecho()                // Don't echo() while we getch
    
    // { // simple input text
    //     cur.keypad(cur.stdscr, true) // cap F1 
    //     cur.attron(cur.A_BOLD)
    //     cur.printw("Type: F1 to EXIT\n")
    //     cur.attroff(cur.A_BOLD)
    //     for {
    //         ch := cur.chtype(cur.getch())
    //         if ch == cur.KEY_F(1) {
    //             break
    //         } else {
    //             //cur.printw("%c", ch)
    //             cur.addch(ch | cur.A_UNDERLINE )
    //         }
    //     }
    //     cur.attron(cur.A_BOLD)
    //     cur.printw("\n*** END ***")
    //     cur.attroff(cur.A_BOLD)
    // }

    // { // Move window test
    //     mesg :cstring = "Test from Leonardo!"

    //     row, col := cur.getmaxyx(cur.stdscr)
    //     cur.mvprintw(row/2, (col - i32(len(mesg)))/2, "%s", mesg )

    //     cur.getch()

    //     cur.move(10,10)
    //     cur.printw("---->")
    // }

    // { // WINDOWS
    //     win := cur.newwin(10, 20, 10, 10)
    //     cur.refresh()

    //     cur.box(win, 0, 0)
    //     cur.mvwprintw(win,1,1, "My box! very large text maybe")
    //     cur.wrefresh(win)
        
    // }

    { // COLORS
        if !cur.has_colors(){
            cur.printw("Terminal dos not support color\n")
        }

        cur.start_color()
        cur.init_pair(1, cur.COLOR_BLUE, cur.COLOR_MAGENTA)
        cur.init_pair(2, cur.COLOR_RED, cur.COLOR_WHITE)

        cur.attron( cur.COLOR_PAIR(1) )
        cur.printw("<------->\n")
        cur.attroff( cur.COLOR_PAIR(1) )

        cur.attron( cur.COLOR_PAIR(2) )
        cur.printw(">---+---<\n")
        cur.attroff( cur.COLOR_PAIR(2) )
    }

    //---------------------------------------------------
    // apenas pausa
    cur.getch()
}
