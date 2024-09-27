package main

import cur "curses"

main :: proc(){
    cur.initscr()
    cur.printw("Hello\n")
    cur.refresh()
    cur.getch()
    cur.endwin()
}
