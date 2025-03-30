import gleam/javascript/promise.{type Promise}

pub type WebElement

@external(javascript, "./webelement_ffi.mjs", "findElement")
pub fn find_element(webelement: WebElement, locator: l) -> WebElement

@external(javascript, "./webelement_ffi.mjs", "findElements")
pub fn find_elements(webelement: WebElement, locator: l) -> List(WebElement)

@external(javascript, "./webelement_ffi.mjs", "sendKeys")
pub fn send_keys(webelement: WebElement, keys: k) -> Promise(Nil)

@external(javascript, "./webelement_ffi.mjs", "click")
pub fn click(webelement: WebElement) -> Promise(Nil)

@external(javascript, "./webelement_ffi.mjs", "getText")
pub fn get_text(webelement: WebElement) -> Promise(String)

@external(javascript, "./webelement_ffi.mjs", "clear")
pub fn clear(webelement: WebElement) -> Promise(Nil)
