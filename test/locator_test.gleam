import gleam/javascript/promise.{await}
import gleeunit/should
import locator/by
import webdriver.{Chrome}

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn by_locator_test() {
  let assert Ok(driver) = webdriver.get_driver(Chrome, "--headless")
  use res <- await(driver |> webdriver.get(selenium_url))
  let assert Ok(_) = res
  use element <- await(
    driver |> webdriver.find_element(by.xpath("//*[@id='my-check-1']//..")),
  )
  element
  |> should.be_ok
  |> promise.resolve
}
