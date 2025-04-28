//// This module lets you create timeouts usable by [WebDriver](../webdriver.html) from the supported
//// variants.
//// A [WebDriver](../webdriver.html#WebDriver) can be given configuration for the timeout.
//// ```gleam
//// use _ <- promise.await(webdriver |> webdriver.set_timeouts([timeout.Implicit(500)]))
//// ```
//// 

import gleam/dict.{type Dict}
import gleam/list

// Types =======================================================================

/// Selenium has a built-in way to automatically wait for elements called an implicit wait. An
/// implicit wait value can be set either with the timeouts capability in the browser options, or
/// with a webdriver method (as shown below).
/// 
/// This is a global setting that applies to every element location call for the entire session.
/// The default value is 0, which means that if the element is not found, it will immediately
/// return an error. If an implicit wait is set, the webdriver will wait for the duration of the
/// provided value before returning the error. Note that as soon as the element is located, the
/// webdriver will return the element reference and the code will continue executing, so a larger
/// implicit wait value won’t necessarily increase the duration of the session.
/// 
/// Warning: Do not mix implicit and explicit waits. Doing so can cause unpredictable wait times.
/// For example, setting an implicit wait of 10 seconds and an explicit wait of 15 seconds could
/// cause a timeout to occur after 20 seconds.
/// Solving our example with an implicit wait looks like this:
/// ```gleam
/// use _ <- promise.await(webdriver |> webdriver.set_timeouts([timeout.Implicit(500)]))
/// ```
pub type Timeout {
  /// This specifies the time to wait for the implicit element location strategy when locating
  /// elements. The default timeout 0 is imposed when a new session is created by WebDriver.
  Implicit(Int)
  /// This specifies the time to wait for the implicit element location strategy when locating
  /// elements. The default timeout 0 is imposed when a new session is created by WebDriver.
  PageLoad(Int)
  /// Specifies when to interrupt an executing script in a current browsing context. The default
  /// timeout 30,000 is imposed when a new session is created by WebDriver.
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

@external(javascript, "../ffi/timeout.mjs", "timeouts")
fn do_timeouts(timeouts: Timeouts) -> Timeouts
