import gleam/list
import gleam/string

/// Input options for [`send_keys`](../webelement.html#send_keys)
pub type Keys {
  /// Representation of keys that are text. Will be strictly be parsed as text. 
  Text(String)

  /// Representations of pressable keys that aren't text.  These are stored in 
  /// the Unicode PUA (Private Use Area) code points, 0xE000-0xF8FF.  Refer to 
  /// [Unicode PUA](http://www.google.com.au/search?&q=unicode+pua&btnG=Search).
  Key(Key)

  /// Simulate pressing many keys at once in a 'chord'. Takes a sequence of
  /// keys or strings, appends each of the values to a string,             
  /// and adds the chord termination key [Key.NULL](#Key) and returns            
  /// the resulting string.                                                
  Chord(List(Keys))
}

pub type Key {
  NULL
  /// ^break
  CANCEL
  HELP
  BACKSPACE
  TAB
  CLEAR
  RETURN
  ENTER
  SHIFT
  CONTROL
  ALT
  PAUSE
  ESCAPE
  SPACE
  PAGEUP
  PAGEDOWN
  END
  HOME
  ARROWLEFT
  LEFT
  ARROWUP
  UP
  ARROWRIGHT
  RIGHT
  ARROWDOWN
  DOWN
  INSERT
  DELETE
  SEMICOLON
  EQUALS

  // Number pad keys
  NUMPAD0
  NUMPAD1
  NUMPAD2
  NUMPAD3
  NUMPAD4
  NUMPAD5
  NUMPAD6
  NUMPAD7
  NUMPAD8
  NUMPAD9
  MULTIPLY
  ADD
  SEPARATOR
  SUBTRACT
  DECIMAL
  DIVIDE

  // function keys
  F1
  F2
  F3
  F4
  F5
  F6
  F7
  F8
  F9
  F10
  F11
  F12

  /// Apple command key
  COMMAND
  /// Alias for Windows key
  META
}

pub fn parse_keys(keys: Keys) -> String {
  case keys {
    Chord(chord) ->
      string.join(list.map(chord, with: fn(key) { parse_keys(key) }), "")
    Key(key) ->
      case key {
        ADD -> do_add()
        ALT -> do_alt()
        ARROWDOWN -> do_arrowdown()
        ARROWLEFT -> do_arrowleft()
        ARROWRIGHT -> do_arrowright()
        ARROWUP -> do_arrowup()
        BACKSPACE -> do_backspace()
        CANCEL -> do_cancel()
        CLEAR -> do_clear()
        COMMAND -> do_command()
        CONTROL -> do_control()
        DECIMAL -> do_decimal()
        DELETE -> do_delete()
        DIVIDE -> do_divide()
        DOWN -> do_down()
        END -> do_end()
        ENTER -> do_enter()
        EQUALS -> do_equals()
        ESCAPE -> do_escape()
        F1 -> do_f1()
        F10 -> do_f10()
        F11 -> do_f11()
        F12 -> do_f12()
        F2 -> do_f2()
        F3 -> do_f3()
        F4 -> do_f4()
        F5 -> do_f5()
        F6 -> do_f6()
        F7 -> do_f7()
        F8 -> do_f8()
        F9 -> do_f9()
        HELP -> do_help()
        HOME -> do_home()
        INSERT -> do_insert()
        LEFT -> do_left()
        META -> do_meta()
        MULTIPLY -> do_multiply()
        NULL -> do_null()
        NUMPAD0 -> do_numpad0()
        NUMPAD1 -> do_numpad1()
        NUMPAD2 -> do_numpad2()
        NUMPAD3 -> do_numpad3()
        NUMPAD4 -> do_numpad4()
        NUMPAD5 -> do_numpad5()
        NUMPAD6 -> do_numpad6()
        NUMPAD7 -> do_numpad7()
        NUMPAD8 -> do_numpad8()
        NUMPAD9 -> do_numpad9()
        PAGEDOWN -> do_pagedown()
        PAGEUP -> do_pageup()
        PAUSE -> do_pause()
        RETURN -> do_return()
        RIGHT -> do_right()
        SEMICOLON -> do_semicolon()
        SEPARATOR -> do_separator()
        SHIFT -> do_shift()
        SPACE -> do_space()
        SUBTRACT -> do_subtract()
        TAB -> do_tab()
        UP -> do_up()
      }
    Text(text) -> text
  }
}

@external(javascript, "../ffi/intput/key.mjs", "NULL")
fn do_null() -> key

@external(javascript, "../ffi/intput/key.mjs", "CANCEL")
fn do_cancel() -> key

@external(javascript, "../ffi/intput/key.mjs", "HELP")
fn do_help() -> key

@external(javascript, "../ffi/intput/key.mjs", "BACK_SPACE")
fn do_backspace() -> key

@external(javascript, "../ffi/intput/key.mjs", "TAB")
fn do_tab() -> key

@external(javascript, "../ffi/intput/key.mjs", "CLEAR")
fn do_clear() -> key

@external(javascript, "../ffi/intput/key.mjs", "RETURN")
fn do_return() -> key

@external(javascript, "../ffi/intput/key.mjs", "ENTER")
fn do_enter() -> key

@external(javascript, "../ffi/intput/key.mjs", "SHIFT")
fn do_shift() -> key

@external(javascript, "../ffi/intput/key.mjs", "CONTROL")
fn do_control() -> key

@external(javascript, "../ffi/intput/key.mjs", "ALT")
fn do_alt() -> key

@external(javascript, "../ffi/intput/key.mjs", "PAUSE")
fn do_pause() -> key

@external(javascript, "../ffi/intput/key.mjs", "ESCAPE")
fn do_escape() -> key

@external(javascript, "../ffi/intput/key.mjs", "SPACE")
fn do_space() -> key

@external(javascript, "../ffi/intput/key.mjs", "PAGE_UP")
fn do_pageup() -> key

@external(javascript, "../ffi/intput/key.mjs", "PAGE_DOWN")
fn do_pagedown() -> key

@external(javascript, "../ffi/intput/key.mjs", "END")
fn do_end() -> key

@external(javascript, "../ffi/intput/key.mjs", "HOME")
fn do_home() -> key

@external(javascript, "../ffi/intput/key.mjs", "ARROW_LEFT")
fn do_arrowleft() -> key

@external(javascript, "../ffi/intput/key.mjs", "LEFT")
fn do_left() -> key

@external(javascript, "../ffi/intput/key.mjs", "ARROW_UP")
fn do_arrowup() -> key

@external(javascript, "../ffi/intput/key.mjs", "UP")
fn do_up() -> key

@external(javascript, "../ffi/intput/key.mjs", "ARROW_RIGHT")
fn do_arrowright() -> key

@external(javascript, "../ffi/intput/key.mjs", "RIGHT")
fn do_right() -> key

@external(javascript, "../ffi/intput/key.mjs", "ARROW_DOWN")
fn do_arrowdown() -> key

@external(javascript, "../ffi/intput/key.mjs", "DOWN")
fn do_down() -> key

@external(javascript, "../ffi/intput/key.mjs", "INSERT")
fn do_insert() -> key

@external(javascript, "../ffi/intput/key.mjs", "DELETE")
fn do_delete() -> key

@external(javascript, "../ffi/intput/key.mjs", "SEMICOLON")
fn do_semicolon() -> key

@external(javascript, "../ffi/intput/key.mjs", "EQUALS")
fn do_equals() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD0")
fn do_numpad0() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD1")
fn do_numpad1() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD2")
fn do_numpad2() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD3")
fn do_numpad3() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD4")
fn do_numpad4() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD5")
fn do_numpad5() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD6")
fn do_numpad6() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD7")
fn do_numpad7() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD8")
fn do_numpad8() -> key

@external(javascript, "../ffi/intput/key.mjs", "NUMPAD9")
fn do_numpad9() -> key

@external(javascript, "../ffi/intput/key.mjs", "MULTIPLY")
fn do_multiply() -> key

@external(javascript, "../ffi/intput/key.mjs", "ADD")
fn do_add() -> key

@external(javascript, "../ffi/intput/key.mjs", "SEPARATOR")
fn do_separator() -> key

@external(javascript, "../ffi/intput/key.mjs", "SUBTRACT")
fn do_subtract() -> key

@external(javascript, "../ffi/intput/key.mjs", "DECIMAL")
fn do_decimal() -> key

@external(javascript, "../ffi/intput/key.mjs", "DIVIDE")
fn do_divide() -> key

@external(javascript, "../ffi/intput/key.mjs", "F1")
fn do_f1() -> key

@external(javascript, "../ffi/intput/key.mjs", "F2")
fn do_f2() -> key

@external(javascript, "../ffi/intput/key.mjs", "F3")
fn do_f3() -> key

@external(javascript, "../ffi/intput/key.mjs", "F4")
fn do_f4() -> key

@external(javascript, "../ffi/intput/key.mjs", "F5")
fn do_f5() -> key

@external(javascript, "../ffi/intput/key.mjs", "F6")
fn do_f6() -> key

@external(javascript, "../ffi/intput/key.mjs", "F7")
fn do_f7() -> key

@external(javascript, "../ffi/intput/key.mjs", "F8")
fn do_f8() -> key

@external(javascript, "../ffi/intput/key.mjs", "F9")
fn do_f9() -> key

@external(javascript, "../ffi/intput/key.mjs", "F10")
fn do_f10() -> key

@external(javascript, "../ffi/intput/key.mjs", "F11")
fn do_f11() -> key

@external(javascript, "../ffi/intput/key.mjs", "F12")
fn do_f12() -> key

@external(javascript, "../ffi/intput/key.mjs", "COMMAND")
fn do_command() -> key

@external(javascript, "../ffi/intput/key.mjs", "META")
fn do_meta() -> key
