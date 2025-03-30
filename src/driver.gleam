import by.{type Locator}
import gleam/dict.{type Dict}
import gleam/javascript/promise.{type Promise}
import timeout.{type Timeout}
import webelement.{type WebElement}

pub type Driver

/// The browsers supported by the selenium driver
pub type Browser {
  Chrome
  Edge
  Firefox
  InternetExplorer
  Safari
}

/// `await new Builder().forBrowser(Browser.CHROME).build()`
pub fn get_driver() -> Promise(Driver) {
  do_get_driver()
}

/// `await new Builder().forBrowser(browser).build()`
pub fn get_driver_for_browser(browser: Browser) -> Promise(Driver) {
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
pub fn get(driver: Driver, url: String) -> Promise(Driver) {
  do_get(driver, url)
}

/// `await driver.quit()`
pub fn quit(driver: Driver) -> Promise(Nil) {
  do_quit(driver)
}

/// `await driver.findElement(locator)`
pub fn find_element(driver: Driver, locator: Locator) -> Promise(WebElement) {
  do_find_element(driver, locator)
}

/// `await driver.findElements(locator)`
pub fn find_elements(
  driver: Driver,
  locator: Locator,
) -> Promise(List(WebElement)) {
  do_find_elements(driver, locator)
}

/// `await driver.getTitle()`
pub fn get_title(driver: Driver) -> Promise(String) {
  do_get_title(driver)
}

/// `await driver.setTimeouts(timeouts)`
pub fn set_timeouts(driver: Driver, timeouts: List(Timeout)) -> Promise(Nil) {
  timeouts
  |> timeout.timeouts()
  |> do_set_timeouts(driver, _)
}

@external(javascript, "./driver_ffi.mjs", "getDriver")
fn do_get_driver() -> Promise(Driver)

@external(javascript, "./driver_ffi.mjs", "getDriverForBrowser")
fn do_get_driver_for_browser(browser: String) -> Promise(Driver)

@external(javascript, "./driver_ffi.mjs", "get")
fn do_get(driver: Driver, url: String) -> Promise(Driver)

@external(javascript, "./driver_ffi.mjs", "quit")
fn do_quit(driver: Driver) -> Promise(Nil)

@external(javascript, "./driver_ffi.mjs", "findElement")
fn do_find_element(driver: Driver, locator: Locator) -> Promise(WebElement)

@external(javascript, "./webelement_ffi.mjs", "findElements")
pub fn do_find_elements(
  webelement: Driver,
  locator: Locator,
) -> Promise(List(WebElement))

@external(javascript, "./driver_ffi.mjs", "getTitle")
fn do_get_title(driver: Driver) -> Promise(String)

@external(javascript, "./driver_ffi.mjs", "setTimeouts")
fn do_set_timeouts(driver: Driver, timeouts: Dict(String, Int)) -> Promise(Nil)
