import error.{type Error}
import gleam/dict.{type Dict}
import gleam/dynamic/decode.{type Dynamic}
import gleam/javascript/promise.{type Promise}
import locator.{type Locator}
import webdriver/timeout
import webelement.{type WebElement}

// Types ==========================================================================================

/// Represents the `WebDriver` type.
pub type WebDriver

/// The browsers supported by the selenium driver
pub type Browser {
  Chrome
  Edge
  Firefox
  InternetExplorer
  Safari
}

/// Navigation options in the browser.
pub type Navigation {
  /// Moves backwards in the browser history.
  Back
  /// Moves forwards in the browser history.
  Forward
  /// Refresh the current page.
  Refresh
  /// Navigate to a new URL.
  To(String)
}

// Values =========================================================================================

pub fn get_driver(browser: Browser, arguments: String) {
  get_driver_for_browser_with_args(browser, arguments)
}

pub fn get_driver_for_browser(browser: Browser) {
  get_driver_for_browser_with_args(browser, "")
}

fn get_driver_for_browser_with_args(browser: Browser, args: String) {
  case browser {
    Chrome -> "chrome"
    Edge -> "MicrosoftEdge"
    Firefox -> "firefox"
    InternetExplorer -> "internet explorer"
    Safari -> "safari"
  }
  |> do_get_driver(args)
}

/// Navigates to the given URL.
pub fn get(driver: WebDriver, url: String) {
  do_get(driver, url)
}

/// Retrieves the URL for the current page.
pub fn get_current_url(driver) {
  do_get_current_url(driver)
}

/// Retrieves the current page's source. The returned source is a representation
/// of the underlying DOM: do not expect it to be formatted or escaped in the   
/// same way as the raw response sent from the web server.                      
pub fn get_page_source(driver) {
  do_get_page_source(driver)
}

/// Locates an element on the page. If the element cannot be found, a
/// [`NoSuchElementError`](error.gleam#NoSuchElementError) will be returned by
/// the driver.
///
/// This function should not be used to test whether an element is present on
/// the page. Rather, you should use [`find_elements`](#find_elements):
///
/// ```gleam
/// use found <- promise.try_await(driver.findElements(By.id('foo')))
/// io.puts("Element found? " <> int.to_string(list.length(found)))
/// ```
pub fn find_element(driver, locator) {
  do_find_element(driver, locator)
}

/// Search for multiple elements on the page. Refer to the documentation on
/// [`find_element`](#find_element) for information on element locator strategies.
pub fn find_elements(driver, locator) {
  do_find_elements(driver, locator)
}

/// Fetches the timeouts currently configured for the current session.
/// See [`set_timeouts`](#set_timeouts).
pub fn get_timeouts(driver) {
  do_get_timeouts(driver)
}

/// Retrieves the current page title.
pub fn get_title(driver) {
  do_get_title(driver)
}

/// Navigates using the given `Navigation` option.
pub fn navigate(driver, location) {
  case location {
    Back -> "back"
    Forward -> "forward"
    Refresh -> "refresh"
    To(string) -> string
  }
  |> do_navigate(driver, _)
}

/// Quits the webdriver.
pub fn quit(driver: WebDriver) {
  do_quit(driver)
}

/// Sets the timeout durations associated with the current session.
pub fn set_timeouts(driver, timeouts) {
  do_set_timeouts(driver, timeout.from(timeouts))
}

/// Makes the driver sleep for the given amount of time.
pub fn sleep(driver, miliseconds) {
  do_sleep(driver, miliseconds)
}

// FFIs ===========================================================================================

@external(javascript, "./ffi/webdriver.mjs", "findElement")
fn do_find_element(
  driver: WebDriver,
  locator: Locator,
) -> Promise(Result(WebElement, Error))

@external(javascript, "./ffi/webdriver.mjs", "findElements")
fn do_find_elements(
  webelement: WebDriver,
  locator: Locator,
) -> Promise(List(WebElement))

@external(javascript, "./ffi/webdriver.mjs", "get")
fn do_get(driver: WebDriver, url: String) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webdriver.mjs", "getCurrentUrl")
fn do_get_current_url(driver: WebDriver) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webdriver.mjs", "getDriver")
fn do_get_driver(broswer: String, arguments: String) -> Result(WebDriver, Error)

@external(javascript, "./ffi/webdriver.mjs", "getPageSource")
fn do_get_page_source(driver: WebDriver) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webdriver.mjs", "getTimeouts")
fn do_get_timeouts(driver: WebDriver) -> Promise(Result(Dynamic, Error))

@external(javascript, "./ffi/webdriver.mjs", "getTitle")
fn do_get_title(driver: WebDriver) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webdriver.mjs", "navigate")
fn do_navigate(
  driver: WebDriver,
  location: String,
) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webdriver.mjs", "quit")
fn do_quit(driver: WebDriver) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webdriver.mjs", "setTimeouts")
fn do_set_timeouts(
  driver: WebDriver,
  timeouts: Dict(String, Int),
) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webdriver.mjs", "sleep")
fn do_sleep(driver: WebDriver, ms: Int) -> Promise(Result(Nil, Error))
