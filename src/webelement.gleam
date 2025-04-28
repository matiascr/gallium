import by.{type Locator}
import gleam/dynamic
import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option}

// Types ==========================================================================================

pub type WebElement {
  WebElement(dynamic.Dynamic)
}

// Values =========================================================================================

pub fn clear(webelement) {
  let WebElement(webelement) = webelement
  do_clear(webelement)
}

pub fn click(webelement) {
  let WebElement(webelement) = webelement
  do_click(webelement)
}

/// Schedule a command to find a descendant of this element. If the element
/// cannot be found, a ErrorCode.NO_SUCH_ELEMENT result will
/// be returned by the driver. Unlike other commands, this error cannot be
/// suppressed. In other words, scheduling a command to find an element doubles
/// as an assert that the element is present on the page. To test whether an
/// element is present on the page, use {@link #findElements}.
///
/// ```gleam
/// use e1 <- promise.await(element |> element.find_element(by.id("foo")))
/// ```
///
/// You may also provide a custom locator function, which takes as input
/// this WebDriver instance and returns a {@link WebElement}, or a
/// promise that will resolve to a WebElement. For example, to find the first
/// visible link on a page, you could write:
///
/// ```gleam
/// use link <- promise.await(element |> element.findElement(Function(first_visible_link)))
/// ```
///
/// using
///
///     function firstVisibleLink(element) {
///       var links = element.findElements(By.tagName('a'));
///       return promise.filter(links, function(link) {
///         return links.isDisplayed();
///       }).then(function(visibleLinks) {
///         return visibleLinks[0];
///       });
///     }
pub fn find_element(webelement, locator) {
  let WebElement(webelement) = webelement
  do_find_element(webelement, locator)
}

pub fn find_elements(webelement, locator) {
  let WebElement(webelement) = webelement
  do_find_elements(webelement, locator)
}

pub fn get_text(webelement) {
  let WebElement(webelement) = webelement
  do_get_text(webelement)
}

pub fn send_keys(webelement, keys) {
  let WebElement(webelement) = webelement
  do_send_keys(webelement, keys)
}

// FFIs ===========================================================================================

@external(javascript, "./ffi/webelement.mjs", "clear")
fn do_clear(webelement: dynamic.Dynamic) -> Promise(Nil)

@external(javascript, "./ffi/webelement.mjs", "click")
fn do_click(webelement: dynamic.Dynamic) -> Promise(Nil)

@external(javascript, "./ffi/webelement.mjs", "getText")
fn do_get_text(webelement: dynamic.Dynamic) -> Promise(String)

@external(javascript, "./ffi/webelement.mjs", "findElement")
fn do_find_element(
  webelement: dynamic.Dynamic,
  locator: Locator,
) -> Promise(Option(dynamic.Dynamic))

@external(javascript, "./ffi/webelement.mjs", "findElements")
fn do_find_elements(
  webelement: dynamic.Dynamic,
  locator: Locator,
) -> Promise(Option(List(dynamic.Dynamic)))

@external(javascript, "./ffi/webelement.mjs", "sendKeys")
fn do_send_keys(webelement: dynamic.Dynamic, keys: k) -> Promise(Nil)
