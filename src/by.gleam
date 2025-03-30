import gleam/dynamic
import gleam/dynamic/decode.{type DecodeError, type Decoder}

pub type Locator {
  Locator(using: String, value: String)
}

/// Returns the `By.className(String)` locator
@external(javascript, "./by_ffi.mjs", "className")
pub fn class_name(class_name: String) -> Locator

/// Returns the `By.css(String)` locator
@external(javascript, "./by_ffi.mjs", "css")
pub fn css(css: String) -> Locator

/// Returns the `By.id(String)` locator
@external(javascript, "./by_ffi.mjs", "id")
pub fn id(id: String) -> Locator

/// Returns the `By.name(String)` locator
@external(javascript, "./by_ffi.mjs", "name")
pub fn name(name: String) -> Locator

/// Returns the `By.linkText(String)` locator
@external(javascript, "./by_ffi.mjs", "linkText")
pub fn link_text(link_text: String) -> Locator

/// Returns the `By.partialLinkText(String)` locator
@external(javascript, "./by_ffi.mjs", "partialLinkText")
pub fn partial_link_text(partial_link_text: String) -> Locator

/// Returns the `By.tagName(String)` locator
@deprecated("Use By.css(tagName) instead.")
@external(javascript, "./by_ffi.mjs", "tagName")
pub fn tag_name(tag_name: String) -> Locator

/// Returns the `By.xpath(String)` locator
@external(javascript, "./by_ffi.mjs", "xpath")
pub fn xpath(xpath: String) -> Locator

pub fn decode(locator: Locator) -> Result(Locator, List(DecodeError)) {
  locator
  |> dynamic.from()
  |> decode.run(decoder())
}

fn decoder() -> Decoder(Locator) {
  use using <- decode.field("using", decode.string)
  use value <- decode.field("value", decode.string)
  decode.success(Locator(using, value))
}
