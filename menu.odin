package main

import "core:c"
import cur "curses"
import "core:strings"

Menu :: struct{
    start_x : int,
    text    : string,
    trigger : c.int,
}

MenuBar :: struct {
    win           : ^cur.WINDOW,
    menus         : []Menu,
    selected_menu : int,
}

menubar_new ::proc(win: ^cur.WINDOW, menus_in: []Menu) -> MenuBar {
    current_pos : int = 2 
    for &m in menus_in {
        m.start_x = current_pos
        current_pos += len(m.text) + 2
    }
    
    return{
        selected_menu = -1, // nada selecionado
        win = win,
        menus = menus_in,
    }
}

menubar_draw :: proc(mb :^MenuBar) {
    for m, idx in mb.menus {
        if idx == mb.selected_menu {
            cur.wattron(mb.win, c.int(cur.A_STANDOUT))
        }
        cur.mvwprintw(mb.win, 0, c.int(m.start_x) , strings.clone_to_cstring(m.text))
        cur.wattroff(mb.win, c.int(cur.A_STANDOUT))
    }
}

menubar_triggers :: proc(mb :^MenuBar, trigger :c.int) {
    for m, idx in mb.menus {
        if trigger == m.trigger {
            mb.selected_menu = idx
        }
    }
}