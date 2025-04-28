//// Functions for working with [`WebElements`](#WebElement).

import error.{type Error}
import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option}
import input/key.{type Keys}
import locator.{type Locator}

// Types ==========================================================================================

/// Represents a DOM element. WebElements can be found by searching from the
/// document root using a [`WebDriver`](./webdriver.html#WebDriver) instance, or by searching
/// under another [`WebElement`](#WebElement):
///
/// ```gleam
/// import gleam/javascript/promise.{try_await}
/// ...
///   use _ <- try_await(webdriver |> webdriver.get("http://www.google.com"))
///   use search_form <- try_await(
///     webdriver |> webdriver.find_element(by.tag_name("form"))
///   )
///   use search_box <- try_await(search_form |> find_element(by.name("q")))
///   use _ <- try_await(searchBox |> send_keys("webdriver"))
/// ...
/// ```
///
/// The WebElement is implemented as a promise for compatibility with the promise
/// API. It will always resolve itself when its internal state has been fully
/// resolved and commands may be issued against the element. This can be used to
/// catch errors when an element cannot be located on the page:
///
/// ```gleam
/// import gleam/javascript/promise.{try_await}
/// ...
///   use result <- try_await(driver |> webdriver.find_element(by.id("not-there")))
///   case result {
///     Ok(element) -> io.puts("Found an element that was not expected to be there!")
///     Error(_) -> io.puts("The element was not found, as expected")
///   }
/// ```
pub type WebElement

/// An element's bounding box, in pixels.
pub type Size {
  Size(width: Int, height: Int)
}

/// Describes an element location, in pixels relative to
/// the document element, and the element's size in pixels.
pub type Rect {
  Rect(x: Int, y: Int, width: Int, height: Int)
}

/// Relative to the top left corner of the screen.
pub type Location {
  Location(x: Int, y: Int)
}

// Values =========================================================================================

/// Schedules a command to clear the `value` of this element. This command has
/// no effect if the underlying DOM element is neither a text INPUT element
/// nor a TEXTAREA element.
pub fn clear(element) {
  do_clear(element)
}

/// Schedules a command to click on this element.
pub fn click(element) {
  do_click(element)
}

/// Schedule a command to find a descendant of this element. If the element
/// cannot be found, a {@link bot.ErrorCode.NO_SUCH_ELEMENT} result will
/// be returned by the webdriver. Unlike other commands, this error cannot be
/// suppressed. In other words, scheduling a command to find an element doubles
/// as an assert that the element is present on the page. To test whether an
/// element is present on the page, use [find_elements](#find_elements).
///
/// The search criteria for an element may be defined using one of the
/// locators in the [Locator](./by.html#Locator) namespace:
/// ```gleam
/// use e1 <- promise.await(element |> webelement.find_element(by.id("foo")))
/// e1 |> should.be_ok()
/// ```
pub fn find_element(element, locator) {
  do_find_element(element, locator)
}

/// Schedules a command to find all of the descendants of this element that
/// match the given search criteria.
pub fn find_elements(element, locator) {
  do_find_elements(element, locator)
}

/// Schedules a command to query for the computed style of the element
/// represented by this instance. If the element inherits the named style from
/// its parent, the parent will be queried for its value.  Where possible,
/// color values will be converted to their hex representation (e.g. #00ff00
/// instead of rgb(0, 255, 0)).
///
/// _Warning:_ the value returned will be as the browser interprets it, so
/// it may be tricky to form a proper assertion.
pub fn get_css_value(element, css_style_property) {
  do_get_css_value(element, css_style_property)
}

/// Retrieves the parent driver for this instance.
pub fn get_driver(element) {
  do_get_driver(element)
}

/// Schedules a command to retrieve the server-assigned opaque ID assigned to
/// this element.
pub fn get_id(element) {
  do_get_id(element)
}

/// Schedules a command to compute the size of this element's bounding box, in
/// pixels.
@deprecated("Deprecated from Selenium >=3.0")
pub fn get_size(element) {
  do_get_size(element)
}

/// Schedules a command to query for the value of the given attribute of the
/// element. Will return the current value, even if it has been modified after
/// the page has been loaded. More exactly, this method will return the value
/// of the given attribute, unless that attribute is not present, in which case
/// the value of the property with the same name is returned. If neither value
/// is set, `Nil` is returned (for example, the 'value' property of a textarea
/// element). The 'style' attribute is converted as best can be to a
/// text representation with a trailing semi-colon. The following are deemed to
/// be `Bool` attributes and will return either `True` or `Nil`:
///
/// 'async', 'autofocus', 'autoplay', 'checked', 'compact', 'complete', 'controls', 'declare',
/// 'defaultchecked', 'defaultselected', 'defer', 'disabled', 'draggable', 'ended',
/// 'formnovalidate', 'hidden', 'indeterminate', 'iscontenteditable', 'ismap', 'itemscope',
/// 'loop', 'multiple', 'muted', 'nohref', 'noresize', 'noshade', 'novalidate', 'nowrap', 'open',
/// 'paused', 'pubdate', 'readonly', 'required', 'reversed', 'scoped', 'seamless', 'seeking',
/// 'selected', 'spellcheck', 'truespeed', 'willvalidate'
///
/// Finally, the following commonly mis-capitalized attribute/property names
/// are evaluated as expected:
/// - `class`
/// - `readonly`
pub fn get_attribute(element, attribute_name) {
  do_get_attribute(element, attribute_name)
}

/// Schedules a command to compute the location of this element in page space.
@deprecated("Deprecated from Selenium >=3.0")
pub fn get_location(element) {
  do_get_location(element)
}

/// Returns an object describing an element's location, in pixels relative to
/// the document element, and the element's size in pixels.
pub fn get_rect(element) {
  do_get_rect(element)
}

/// Get the shadow root of the current web element.
pub fn get_shadow_root(element) {
  do_get_shadow_root(element)
}

/// Schedules a command to query for the tag/node name of this element.
pub fn get_tag_name(element) {
  do_get_tag_name(element)
}

/// Get the visible (i.e. not hidden by CSS) innerText of this element,
pub fn get_text(element) {
  do_get_text(element)
}

/// Schedules a command to test whether this element is currently displayed.
pub fn is_displayed(element) {
  do_is_displayed(element)
}

/// Schedules a command to query whether the DOM element represented by this
/// instance is enabled, as dicted by the `disabled` attribute.
pub fn is_enabled(element) {
  do_is_enabled(element)
}

/// Schedules a command to query whether this element is selected.
pub fn is_selected(element) {
  do_is_selected(element)
}

/// Schedules a command to type a sequence on the DOM element represented by
/// this promsieinstance.
///
/// Modifier keys (SHIFT, CONTROL, ALT, META) are stateful; once a modifier is
/// processed in the keysequence, that key state is toggled until one of the
/// following occurs:
///
/// - The modifier key is encountered again in the sequence. At this point the
///   state of the key is toggled (along with the appropriate keyup/down
/// events).
/// - The [`key.NULL`](./input/key.html#NULL) key is encountered in the
///   sequence. When this key is encountered, all modifier keys current in the
///   down state are released (with accompanying keyup events). The NULL key
///   can be used to simulate common keyboard shortcuts:
/// ```gleam
///  use _ <- promise.try_await(
///    element
///    |> webelement.send_keys([
///      Text("text was"),
///      Key(CONTROL),
///      Text("a"),
///      Key(NULL),
///      Text("now text is"),
///    ]),
///  )
/// // Alternatively:
///  use _ <- promise.try_await(
///    element
///    |> webelement.send_keys([
///      Text("text was"),
///      Chord([Key(CONTROL), Text("a")]),
///      Text("now text is"),
///    ]),
///  )
/// ```
/// - The end of the keysequence is encountered. When there are no more keys
///   to type, all depressed modifier keys are released (with accompanying
/// keyup events).
///
/// If this element is a file input (`<input type='file'>`), the
/// specified key sequence should specify the path to the file to attach to
/// the element. This is analgous to the user clicking 'Browse...' and entering
/// the path into the file select dialog.
/// ```gleam
/// import gleam/javascript/promise.{try_await}
/// ...
///   use form <- try_await(webdriver |> webdriver.find_element(by.css("form")))
///   use element <- try_await(form |> find_element(by.css("input[type=file]")))
///   use _ <- try_await(element |> send_keys("/path/to/file.txt"))
///   use _ <- try_await(form |> submit())
/// ```
/// For uploads to function correctly, the entered path must reference a file
/// on the _browser's_ machine, not the local machine running this script. When
/// running against a remote Selenium server, a {@link FileDetector}
/// may be used to transparently copy files to the remote machine before
/// attempting to upload them in the browser.
///
/// __Note:__ On browsers where native keyboard events are not supported
/// (e.g. Firefox on OS X), key events will be synthesized. Special
/// punctionation keys will be synthesized according to a standard QWERTY en-us
/// keyboard layout.
pub fn send_keys(element, keys: Keys) {
  do_send_keys(element, key.parse_keys(keys))
}

/// Schedules a command to submit the form containing this element (or this
/// element if it is a FORM element). This command is a no-op if the element is
/// not contained in a form.
pub fn submit(element) {
  do_submit(element)
}

/// Take a screenshot of the visible region encompassed by the given element's 
/// bounding rectangle.
pub fn take_screenshot(element, scroll scroll) {
  do_take_screenshot(element, scroll)
}

// FFIs ===========================================================================================

@external(javascript, "./ffi/webelement.mjs", "clear")
fn do_clear(element: WebElement) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webelement.mjs", "click")
fn do_click(element: WebElement) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webelement.mjs", "findElement")
fn do_find_element(
  element: WebElement,
  locator: Locator,
) -> Promise(Option(WebElement))

@external(javascript, "./ffi/webelement.mjs", "findElements")
fn do_find_elements(
  element: WebElement,
  locator: Locator,
) -> Promise(List(WebElement))

@external(javascript, "./ffi/webelement.mjs", "getCssValue")
fn do_get_css_value(
  element: WebElement,
  css_style_property: String,
) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webelement.mjs", "getDriver")
fn do_get_driver(element: WebElement) -> Result(webdriver, Error)

@external(javascript, "./ffi/webelement.mjs", "getId")
fn do_get_id(element: WebElement) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webelement.mjs", "getSize")
fn do_get_size(element: WebElement) -> Promise(Result(Size, Error))

@external(javascript, "./ffi/webelement.mjs", "getAttribute")
fn do_get_attribute(
  element: WebElement,
  attribute_name: String,
) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webelement.mjs", "getLocation")
fn do_get_location(element: WebElement) -> Promise(Result(Location, Error))

@external(javascript, "./ffi/webelement.mjs", "getRect")
fn do_get_rect(element: WebElement) -> Promise(Result(Rect, Error))

@external(javascript, "./ffi/webelement.mjs", "getShadowRoot")
fn do_get_shadow_root(
  element: WebElement,
) -> Promise(Result(shadow_root, Error))

@external(javascript, "./ffi/webelement.mjs", "getTagName")
fn do_get_tag_name(element: WebElement) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webelement.mjs", "getText")
fn do_get_text(element: WebElement) -> Promise(Result(String, Error))

@external(javascript, "./ffi/webelement.mjs", "isDisplayed")
fn do_is_displayed(element: WebElement) -> Promise(Result(Bool, Error))

@external(javascript, "./ffi/webelement.mjs", "isEnabled")
fn do_is_enabled(element: WebElement) -> Promise(Result(Bool, Error))

@external(javascript, "./ffi/webelement.mjs", "isSelected")
fn do_is_selected(element: WebElement) -> Promise(Result(Bool, Error))

@external(javascript, "./ffi/webelement.mjs", "sendKeys")
fn do_send_keys(
  element: WebElement,
  keys: String,
) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webelement.mjs", "submit")
fn do_submit(element: WebElement) -> Promise(Result(Nil, Error))

@external(javascript, "./ffi/webelement.mjs", "takeScreenshot")
fn do_take_screenshot(
  element: WebElement,
  scroll: Bool,
) -> Promise(Result(String, Error))
