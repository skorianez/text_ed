package main

import "core:c"
import cur "curses"
import "core:strings"

Menu :: struct{
    start_x       : int,
    text          : string,
    trigger       : c.int,
    items         : []string,
    selected_item : int,
}

MenuBar :: struct {
    win           : ^cur.WINDOW,
    menuwin       : ^cur.WINDOW,
    menus         : []Menu,
    selected_menu : int,
}

menu_select_next :: proc(m : ^Menu) {
    m.selected_item += 1
    if m.selected_item >= len(m.items) {
        m.selected_item = 0 // wrap
    }
}

menu_select_prev :: proc(m : ^Menu) {
    m.selected_item -= 1
    if m.selected_item < 0 {
        m.selected_item = len(m.items) - 1 // wrap
    }    
}

menubar_new ::proc(win: ^cur.WINDOW, menus_in: []Menu) -> MenuBar {
    current_pos : int = 2 
    for &m in menus_in {
        m.start_x = current_pos
        current_pos += len(m.text) + 2
    }
    
    yMax, xMax := cur.getmaxyx(win)
    yBeg, xBeg := cur.getbegyx(win)
    menuwin_tmp := cur.newwin(yMax - 2, xMax - 2, yBeg + 1, xBeg + 1)
    cur.keypad(menuwin_tmp, true)
    cur.wrefresh(menuwin_tmp)

    return{
        selected_menu = -1, // nada selecionado
        win = win,
        menuwin = menuwin_tmp,
        menus = menus_in,
    }
}

menubar_reset :: proc(mb :^MenuBar) {
    for m, idx in mb.menus {
        cur.mvwprintw(mb.win, 0, c.int(m.start_x) , strings.clone_to_cstring(m.text))
    }
    cur.wrefresh(mb.win)
}


menubar_draw :: proc(mb :^MenuBar) {
    for &m, idx in mb.menus {
        menubar_draw_menu(mb, &m, mb.selected_menu == idx)
    }
    mb.selected_menu = - 1
}

menubar_draw_menu :: proc(mb :^MenuBar, menu: ^Menu, is_selected : bool) {
    is_selec := is_selected
    if is_selec {
        cur.wattron(mb.win, c.int(cur.A_STANDOUT))
    }
    cur.mvwprintw(mb.win, 0, c.int(menu.start_x) , strings.clone_to_cstring(menu.text))
    cur.wattroff(mb.win, c.int(cur.A_STANDOUT))
    cur.wrefresh(mb.win)

    ch : c.int
    menubar_draw_menu_items(mb, menu)
    cur.wrefresh(mb.menuwin)
    for is_selec {
        ch = cur.wgetch(mb.menuwin)
        switch ch {
            case cur.KEY_UP:
                menu_select_prev(menu)
            case cur.KEY_DOWN:
                menu_select_next(menu)
            case:
                is_selec = false
        }
        menubar_draw_menu_items(mb, menu)
    }
    cur.werase(mb.menuwin)
    cur.wrefresh(mb.menuwin)
    menubar_reset(mb)
}

menubar_draw_menu_items :: proc(mb :^MenuBar, menu: ^Menu ) {
    yMax, xMax := cur.getmaxyx(mb.menuwin)
    for i, idx in menu.items {
        cur.mvwprintw(mb.menuwin, c.int(idx), 0, strings.clone_to_cstring(i) )
        if idx == menu.selected_item {
            cur.mvwchgat(mb.menuwin, c.int(idx), 0, xMax, cur.A_NORMAL, 1, nil)
        } else {
            cur.mvwchgat(mb.menuwin, c.int(idx), 0, xMax, cur.A_STANDOUT, 0, nil)
        }
    }
}


menubar_triggers :: proc(mb :^MenuBar, trigger :c.int) {
    for m, idx in mb.menus {
        if trigger == m.trigger {
            mb.selected_menu = idx
        }
    }
}