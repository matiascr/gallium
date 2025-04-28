import gleam/javascript/promise.{await}
import gleeunit/should
import locator/by
import webdriver
import webelement

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn get_text_test() {
  let assert Ok(driver) = webdriver.get_driver(webdriver.Chrome, "--headless")
  use res <- await(driver |> webdriver.get(selenium_url))
  let assert Ok(_) = res
  use element <- await(
    driver
    |> webdriver.find_element(by.xpath("//*[@id='my-check-1']//..")),
  )
  let assert Ok(element) = element
  use text <- await(element |> webelement.get_text())
  text
  |> should.equal(Ok("Checked checkbox"))
  |> promise.resolve()
}

pub fn get_attr_test() {
  let assert Ok(driver) = webdriver.get_driver(webdriver.Chrome, "--headless")
  use res <- await(driver |> webdriver.get(selenium_url))
  res |> should.be_ok
  use element <- await(
    driver |> webdriver.find_element(by.xpath("//*[@id='my-check-1']")),
  )
  let assert Ok(element) = element
  use text <- await(element |> webelement.get_attribute("value"))
  text |> should.equal(Ok("on"))

  promise.resolve(Nil)
}

pub fn is_enabled_test() {
  let assert Ok(driver) = webdriver.get_driver(webdriver.Chrome, "--headless")
  use res <- await(driver |> webdriver.get(selenium_url))
  res |> should.be_ok

  use element <- await(driver |> webdriver.find_element(by.id("my-check-1")))
  let assert Ok(element) = element
  use text <- await(element |> webelement.is_enabled())
  text |> should.equal(Ok(True))

  use element <- await(driver |> webdriver.find_element(by.name("my-disabled")))
  let assert Ok(element) = element
  use text <- await(element |> webelement.is_enabled())
  text |> should.equal(Ok(False))

  promise.resolve(Nil)
}
