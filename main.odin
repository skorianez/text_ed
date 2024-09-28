package main

import "core:c"
import cur "curses"

main :: proc(){
    cur.initscr()               // start curses mode
    defer cur.endwin()          // defer end curses mode

    //cur.nocbreak()            // Avoid ctrl+C
    //cur.raw()                   // Captura todas as teclas, inclusive Ctrl+C
    cur.noecho()                // Don't echo() while we getch
    
    { // simple input text
        // cur.keypad(cur.stdscr, true) // cap F1 
        // cur.attron(cur.A_BOLD)
        // cur.printw("Type: F1 to EXIT\n")
        // cur.attroff(cur.A_BOLD)
        // for {
        //     ch := cur.chtype(cur.getch())
        //     if ch == cur.KEY_F(1) {
        //         break
        //     } else {
        //         //cur.printw("%c", ch)
        //         cur.addch(ch | cur.A_UNDERLINE )
        //     }
        // }
        // cur.attron(cur.A_BOLD)
        // cur.printw("\n*** END ***")
        // cur.attroff(cur.A_BOLD)
    }

    { // Move window test
        // mesg :cstring = "Test from Leonardo!"

        // row, col := cur.getmaxyx(cur.stdscr)
        // cur.mvprintw(row/2, (col - i32(len(mesg)))/2, "%s", mesg )

        // cur.getch()

        // cur.move(10,10)
        // cur.printw("---->")
    }

    { // WINDOWS
        // win := cur.newwin(10, 20, 10, 10)
        // cur.refresh()

        // cur.box(win, 0, 0)
        // cur.mvwprintw(win,1,1, "My box! very large text maybe")
        // cur.wrefresh(win)    
    }
    
    { // COLORS
        // if !cur.has_colors(){
        //     cur.printw("Terminal dos not support color\n")
        // }

        // cur.start_color()
        // cur.init_pair(1, cur.COLOR_BLUE, cur.COLOR_MAGENTA)
        // cur.init_pair(2, cur.COLOR_RED, cur.COLOR_WHITE)

        // cur.attron( cur.COLOR_PAIR(1) )
        // cur.printw("<------->\n")
        // cur.attroff( cur.COLOR_PAIR(1) )

        // cur.attron( cur.COLOR_PAIR(2) )
        // cur.printw(">---+---<\n")
        // cur.attroff( cur.COLOR_PAIR(2) )
    }

    { // INPUT
        // y_max, x_max := cur.getmaxyx(cur.stdscr)
        // mwin := cur.newwin(6, x_max - 12, y_max - 8, 5)
        // cur.box(mwin, 0, 0)
        // cur.refresh()
        // cur.wrefresh(mwin)

        // cur.keypad(mwin, true)
        // choices := [3]cstring {"Walk", "Jog", "Run"}
        // choice, highlight : int

        // loop :for {
        //     for i in 0..<3 {
        //         if i == highlight {
        //             cur.wattron(mwin, c.int(cur.A_REVERSE))
        //         }
        //         cur.mvwprintw(mwin, c.int(i)+1, 1, choices[i])
        //         cur.wattroff(mwin, c.int(cur.A_REVERSE))
        //     }
        //     choice := cur.wgetch(mwin)

        //     switch choice {
        //         case cur.KEY_UP:
        //             highlight -= 1
        //             if highlight == -1 {
        //                 highlight = 0
        //             }
        //         case cur.KEY_DOWN:
        //             highlight += 1
        //             if highlight == 3 {
        //                 highlight = 2
        //             }
        //     }
        //     if choice == 10 {
        //         break loop
        //     }
        // }
        // cur.printw("Your choice was: %s\n", choices[highlight])
    }

    { // TOP DOWN PLAYER
        // cur.curs_set(0) // Hide cursror
        // yMax, xMax := cur.getmaxyx(cur.stdscr)
        // playwin := cur.newwin(20, 50, yMax/2 - 10, 10 )
        // cur.box(playwin, 0, 0)

        // cur.refresh()
        // cur.wrefresh(playwin)
        // p := p_new(playwin, 1, 1, '@')
        // choice : c.int
        // loop : for {
        //     p_display(&p)
        //     cur.wrefresh(playwin)

        //     choice = p_getmv(&p)
        //     if choice == 'x'{
        //         break loop
        //     }
        // }
    }

    { // INPUT MODES
        // cur.keypad(cur.stdscr, true)
        // ch : c.int
        // for {
        //     ch = cur.getch()
        //     cur.mvprintw(1,0, "Key Name: %s - 0x%02x\n", cur.keyname(ch), ch)
        //     if ch == 'x'{
        //         break
        //     }
        // }
    }

    { // MENUBAR
        cur.curs_set(0)

        yMax, xMax := cur.getmaxyx(cur.stdscr)
        win := cur.newwin(yMax/2, xMax/2, yMax/4, xMax/4)
        cur.box(win, 0, 0)

        menus := [?]Menu{
            {text="File", trigger='f'},
            {text="Edit", trigger='e'},
            {text="Options", trigger='o'},
            {text="Help", trigger='h'},
        }
        menubar := menubar_new(win, menus[:])
        menubar_draw(&menubar)

        ch: c.int
        for {
            ch = cur.wgetch(win)
            menubar_triggers(&menubar, ch)
            menubar_draw(&menubar)
        }
        
    }

    //---------------------------------------------------
    // apenas pausa
    //cur.getch()
}
