package main

import cur "curses"

main :: proc(){
    cur.initscr()               // start curses mode
    defer cur.endwin()          // defer end curses mode

    cur.raw()                   // line buffering disabled
    cur.keypad(cur.stdscr, true)
    cur.noecho()                // don't echo() while we getch

    cur.refresh()
    
    // { // simple input text
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

    { // Center screen teste
        mesg :cstring = "Test from Leonardo!"
        row, col := cur.getmaxyx(cur.stdscr)
        cur.mvprintw(row/2, (col - i32(len(mesg)))/2, "%s", mesg )
    }

    //---------------------------------------------------
    cur.getch()
}
