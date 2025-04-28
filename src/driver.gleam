import by.{type Locator}
import driver/timeout
import gleam/dict.{type Dict}
import gleam/dynamic
import gleam/dynamic/decode.{type Dynamic}
import gleam/javascript/promise.{type Promise}
import webelement.{type WebElement, WebElement}

pub type WebDriver

pub type FinderError {
  FinderError
  NoSuchElementError
}

/// The browsers supported by the selenium driver
pub type Browser {
  Chrome
  Edge
  Firefox
  InternetExplorer
  Safari
}

/// `await new Builder().forBrowser(Browser.CHROME).build()`
pub fn get_driver(arguments) -> Promise(WebDriver) {
  do_get_driver(arguments)
}

/// `await new Builder().forBrowser(Browser.CHROME).build()`
pub fn get_default_driver() -> Promise(WebDriver) {
  do_get_default_driver()
}

/// Equivalent to JS:
/// ```
/// await new Builder().forBrowser(browser).build()
/// ```
pub fn get_driver_for_browser(browser: Browser) -> Promise(WebDriver) {
  case browser {
    Chrome -> "chrome"
    Edge -> "MicrosoftEdge"
    Firefox -> "firefox"
    InternetExplorer -> "internet explorer"
    Safari -> "safari"
  }
  |> do_get_driver_for_browser()
}

/// `await driver.get(url)`
pub fn get(driver, url) {
  do_get(driver, url)
}

/// `await driver.quit()`
pub fn quit(driver) {
  do_quit(driver)
}

/// `await driver.findElement(locator)`
pub fn find_element(driver, locator) -> Promise(Result(WebElement, FinderError)) {
  do_find_element(driver, locator)
  |> promise.rescue(fn(elem) { elem })
  |> promise.map(fn(elem) {
    let error_decoder = {
      use name <- decode.field("name", decode.string)
      decode.success(name)
    }

    case dynamic.from(elem) |> decode.run(error_decoder) {
      Ok("NoSuchElementError") -> Error(NoSuchElementError)
      Ok(_) -> Error(FinderError)
      _ -> Ok(WebElement(elem))
    }
  })
}

/// `await driver.findElements(locator)`
pub fn find_elements(driver, locator) {
  do_find_elements(driver, locator)
}

/// `await driver.getTitle()`
pub fn get_title(driver) {
  do_get_title(driver)
}

/// `await driver.setTimeouts(timeouts)`
pub fn set_timeouts(driver, timeouts) {
  driver
  |> do_set_timeouts(timeout.from(timeouts))
}

pub fn get_timeouts(driver) {
  do_get_timeouts(driver)
}

@external(javascript, "./ffi/driver.mjs", "getDriver")
fn do_get_driver(arguments: String) -> Promise(WebDriver)

@external(javascript, "./ffi/driver.mjs", "getDefaultDriver")
fn do_get_default_driver() -> Promise(WebDriver)

@external(javascript, "./ffi/driver.mjs", "getDriverForBrowser")
fn do_get_driver_for_browser(browser: String) -> Promise(WebDriver)

@external(javascript, "./ffi/driver.mjs", "get")
fn do_get(driver: WebDriver, url: String) -> Promise(WebDriver)

@external(javascript, "./ffi/driver.mjs", "quit")
fn do_quit(driver: WebDriver) -> Promise(Nil)

@external(javascript, "./ffi/driver.mjs", "findElement")
fn do_find_element(
  driver: WebDriver,
  locator: Locator,
) -> Promise(dynamic.Dynamic)

@external(javascript, "./ffi/webelement.mjs", "findElements")
fn do_find_elements(
  webelement: WebDriver,
  locator: Locator,
) -> Promise(List(WebElement))

@external(javascript, "./ffi/driver.mjs", "getTitle")
fn do_get_title(driver: WebDriver) -> Promise(String)

@external(javascript, "./ffi/driver.mjs", "setTimeouts")
fn do_set_timeouts(
  driver: WebDriver,
  timeouts: Dict(String, Int),
) -> Promise(Nil)

@external(javascript, "./ffi/driver.mjs", "getTimeouts")
fn do_get_timeouts(driver: WebDriver) -> Promise(Dynamic)
