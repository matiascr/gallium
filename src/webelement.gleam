import gleam/javascript/promise.{type Promise}

pub type WebElement

@external(javascript, "./ffi/webelement.mjs", "findElement")
pub fn find_element(webelement: WebElement, locator: l) -> WebElement

@external(javascript, "./ffi/webelement.mjs", "findElements")
pub fn find_elements(webelement: WebElement, locator: l) -> List(WebElement)

@external(javascript, "./ffi/webelement.mjs", "sendKeys")
pub fn send_keys(webelement: WebElement, keys: k) -> Promise(Nil)

@external(javascript, "./ffi/webelement.mjs", "click")
pub fn click(webelement: WebElement) -> Promise(Nil)

@external(javascript, "./ffi/webelement.mjs", "getText")
pub fn get_text(webelement: WebElement) -> Promise(String)

@external(javascript, "./ffi/webelement.mjs", "clear")
pub fn clear(webelement: WebElement) -> Promise(Nil)
