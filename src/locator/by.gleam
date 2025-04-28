//// Module for generating with `selenium-webdriver#By` locators.
////
//// Find more information at
//// [the official Selenium documentation](https://www.selenium.dev/documentation/webdriver/elements/locators/).
//// 

import locator.{type Locator}

// Values =========================================================================================

/// Locates elements that have a specific class name.
/// 
/// Returns the equivalent of the `By.className(String)` locator in JavaScript.
///
/// ## Example
///
/// ```gleam
/// let driver = driver.get_default_driver()
/// use _ <- promise.await(driver |> driver.get(url))
/// use modal <- promise.await(driver |> driver.find_element(by.class_name("modal")))
/// modal
/// // -> js(WebElement { ... })
/// ```
///
pub fn class_name(class_name) {
  do_class_name(class_name)
}

/// Locates elements using a CSS selector.
pub fn css(css) {
  do_css(css)
}

/// Locates elements by the ID attribute. This locator uses the CSS selector `*[id='$ID']`, _not_
/// `document.getElementById`.
///
pub fn id(id) {
  do_id(id)
}

/// Locates link elements whose [`webelement.get_text`](./webelement.html#get_text) matches the
/// given string.
///
pub fn link_text(link_text) {
  do_link_text(link_text)
}

/// Locates elements whose `name` attribute has the given value.
///
pub fn name(name) {
  do_name(name)
}

/// Locates link elements whose [`webelement.get_text`](./webelement.html#get_text) contains the
/// given substring.
///
pub fn partial_link_text(partial_link_text) {
  do_partial_link_text(partial_link_text)
}

/// Locates elements with a given tag name.
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
pub fn xpath(xpath) {
  do_xpath(xpath)
}

// FFIs ===========================================================================================

@external(javascript, "../ffi/by.mjs", "className")
fn do_class_name(class_name class_name: String) -> Locator

@external(javascript, "../ffi/by.mjs", "css")
fn do_css(css: String) -> Locator

@external(javascript, "../ffi/by.mjs", "id")
fn do_id(id: String) -> Locator

@external(javascript, "../ffi/by.mjs", "name")
fn do_name(name: String) -> Locator

@external(javascript, "../ffi/by.mjs", "linkText")
fn do_link_text(link_text: String) -> Locator

@external(javascript, "../ffi/by.mjs", "partialLinkText")
fn do_partial_link_text(partial_link_text: String) -> Locator

@external(javascript, "../ffi/by.mjs", "tagName")
fn do_tag_name(tag_name: String) -> Locator

@external(javascript, "../ffi/by.mjs", "xpath")
fn do_xpath(xpath: String) -> Locator
