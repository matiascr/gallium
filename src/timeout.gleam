//// Timeouts

import gleam/dict.{type Dict}
import gleam/list

// Types =======================================================================

/// The supported timeout options
pub type Timeout {
  /// Equivalent to JS `{ implicit: value }`
  Implicit(Int)
  /// Equivalent to JS `{ pageLoad: value }`
  PageLoad(Int)
  /// Equivalent to JS `{ script: value }`
  Script(Int)
}

type Timeouts =
  Dict(String, Int)

// Values ======================================================================

/// Creates the dictionary with the timeout options in a format readable by Selenium.
/// 
/// Given a list like `[timeout.Implicit(20), timeout.PageLoad(1_000)]` is equivalent equivalent to
/// `{ implicit: 20, pageLoad: 1000 }`.
///
pub fn from(timeouts: List(Timeout)) -> Timeouts {
  list.map(timeouts, fn(t) {
    case t {
      Implicit(v) -> #("implicit", v)
      PageLoad(v) -> #("pageLoad", v)
      Script(v) -> #("script", v)
    }
  })
  |> dict.from_list()
  |> do_timeouts()
}

// FFIs ========================================================================

@external(javascript, "./ffi/timeout.mjs", "timeouts")
fn do_timeouts(timeouts: Timeouts) -> Timeouts
