import gleam/javascript/promise.{type Promise}
import locator/by
import webdriver

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn try(_routine: Promise(a), _callback) {
  Nil
}

pub fn try_ok(_routine: Promise(a), _callback) {
  Nil
}

pub fn require(_routine: Promise(a), _callback) {
  Nil
}

pub fn require_ok(_routine: Promise(a), _callback) {
  Nil
}

pub fn try_require_test() {
  let assert Ok(driver) = webdriver.get_driver(webdriver.Chrome, "--headless")
  require(driver |> webdriver.get(selenium_url), fn() {
    try(driver |> webdriver.find_element(by.name("nameless")), fn(element) {
      let assert Ok(_) = element
    })
  })
}
