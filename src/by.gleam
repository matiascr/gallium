//// Module for working with `selenium-webdriver#By` locators.
////
//// Find more information at
//// [the official Selenium documentation](https://www.selenium.dev/documentation/webdriver/elements/locators/).
//// 

import gleam/dynamic
import gleam/dynamic/decode
import pprint

// Types ==========================================================================================

/// Describes a mechanism for locating an element on the page.
pub type Locator {
  /// The `By.className(String)` locator type
  ClassName(String)
  /// The `By.css(String)` locator type
  Css(String)
  /// The `By.id(String)` locator type
  Id(String)
  /// The `By.name(String)` locator type
  Name(String)
  /// The `By.lintText(String)` locator type
  LinkText(String)
  /// The `By.partialLinkText(String)` locator type
  PartialLinkText(String)
  /// The `By.tagName(String)` locator type
  TagName(String)
  /// The `By.xpath(String)` locator type
  XPath(String)
}

// Values =========================================================================================

/// Locates elements that have a specific class name.
/// 
/// Returns the equivalent of the `By.className(String)` locator in JavaScript.
///
/// ## Example
/// ```gleam
/// let driver = driver.get_default_driver()
/// use _ <- promise.await(driver |> driver.get(url))
/// use modal <- promise.await(driver |> driver.find_element(by.class_name("modal")))
/// modal
/// // -> js(WebElement { ... })
/// ```
pub fn class_name(class_name) {
  do_class_name(class_name)
}

/// Locates link elements whose [`webelement.get_text`](./webelement.html#get_text) matches the
/// given string.
///
/// Returns the equivalent of the `By.linkText(String)` locator in JavaScript.
///
pub fn link_text(link_text) {
  do_link_text(link_text)
}

/// Locates elements using a CSS selector.
///
/// Returns the equivalent of the `By.css(String)` locator in JavaScript.
///
pub fn css(css) {
  do_css(css)
}

/// Locates elements by the ID attribute. This locator uses the CSS selector `*[id='$ID']`, _not_
/// `document.getElementById`.
///
/// Returns the equivalent of the `By.id(String)` locator in JavaScript.
///
pub fn id(id) {
  do_id(id)
}

/// Locates elements whose `name` attribute has the given value.
///
/// Returns the equivalent of the `By.name(String)` locator in JavaScript..
///
pub fn name(name) {
  do_name(name)
}

/// Locates link elements whose [`webelement.get_text`](./webelement.html#get_text) contains the
/// given substring.
///
/// Returns the equivalent of the `By.partialLinkText(String)` locator in JavaScript.
///
pub fn partial_link_text(partial_link_text) {
  do_partial_link_text(partial_link_text)
}

/// Locates elements with a given tag name.
///
/// Returns the equivalent of the `By.tagName(String)` locator in JavaScript.
///
@deprecated("Use `by.css(tag_name)` instead.")
pub fn tag_name(tag_name) {
  do_tag_name(tag_name)
}

/// Locates elements matching a [`XPath`](#Locator) selector. Care should be taken when using an
/// [`XPath`](#Locator) selector  with a [`WebElement`](./webelement.html#WebElement) as WebDriver
/// will respect the context in the specified in the selector. For example, given the selector
/// `//div`, WebDriver will search from the document root regardless of whether the locator was
/// used with a [`WebElement`](./webelement.html#WebElement).
///
/// Returns equivalent of the `By.xpath(String)` locator in JavaScript.
///
pub fn xpath(xpath) {
  do_xpath(xpath)
}

/// Decodes a locator into its most specific [`by.Locator`](#Locator) type.
///
/// ## Example
/// ```gleam
/// let assert Ok(locator) = by.id("item") |> by.decode()
/// locator
/// // -> by.Id("*[id=\"item\"]")
/// ```
///
pub fn decode(locator) {
  dynamic.from(locator)
  |> decode.run(decoder())
}

/// Decoder for the `Locator` type
///
fn decoder() {
  use using <- decode.field("using", decode.string)
  use value <- decode.field("value", decode.string)
  case using, value {
    "tag name", _ -> TagName(value)
    "xpath", _ -> XPath(value)
    "partial link text", _ -> PartialLinkText(value)
    "link text", _ -> LinkText(value)
    "css selector", "*[id=\"" <> _ -> Id(value)
    "css selector", "*[name=\"" <> _ -> Name(value)
    "css selector", "*[.=" <> _ -> ClassName(value)
    "css selector", "." <> _ -> ClassName(value)
    "css selector", _ -> Css(value)
    _, _ -> {
      panic as {
        "Failed to decode values ('using', 'value'): "
        <> pprint.format(#(using, value))
      }
    }
  }
  |> decode.success()
}

// FFIs ===========================================================================================

@external(javascript, "./ffi/by.mjs", "className")
fn do_class_name(class_name class_name: String) -> Locator

@external(javascript, "./ffi/by.mjs", "css")
fn do_css(css: String) -> Locator

@external(javascript, "./ffi/by.mjs", "id")
fn do_id(id: String) -> Locator

@external(javascript, "./ffi/by.mjs", "name")
fn do_name(name: String) -> Locator

@external(javascript, "./ffi/by.mjs", "linkText")
fn do_link_text(link_text: String) -> Locator

@external(javascript, "./ffi/by.mjs", "partialLinkText")
fn do_partial_link_text(partial_link_text: String) -> Locator

@external(javascript, "./ffi/by.mjs", "tagName")
fn do_tag_name(tag_name: String) -> Locator

@external(javascript, "./ffi/by.mjs", "xpath")
fn do_xpath(xpath: String) -> Locator
