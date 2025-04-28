import gleam/javascript/promise.{await, try_await}
import gleeunit/should
import input/key.{Text}
import locator/by
import webdriver.{Chrome} as d
import webdriver/timeout
import webelement

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn fail_test() {
  let assert Ok(driver) = d.get_driver(Chrome, "--headless")
  use _ <- try_await(driver |> d.get(selenium_url))
  use element <- try_await(driver |> d.find_element(by.id("adder")))
  use _ <- try_await(element |> webelement.click())
  use result <- await(driver |> d.find_element(by.id("box0")))
  result |> should.be_error
  driver |> d.quit()
}

pub fn sleep_test() {
  let assert Ok(driver) = d.get_driver(Chrome, "--headless")

  use _ <- try_await(driver |> d.get(selenium_url))
  use element <- try_await(driver |> d.find_element(by.id("adder")))
  use _ <- try_await(element |> webelement.click())
  use _ <- await(driver |> d.sleep(2000))
  use added <- try_await(driver |> d.find_element(by.id("box0")))
  use attr <- try_await(added |> webelement.get_attribute("class"))
  attr |> should.equal("redbox")

  driver |> d.quit()
}

pub fn implicit_test() {
  let assert Ok(driver) = d.get_driver(Chrome, "--headless")

  use _ <- try_await(driver |> d.set_timeouts([timeout.Implicit(2000)]))
  use _ <- try_await(driver |> d.get(selenium_url))
  use added <- try_await(driver |> d.find_element(by.id("box0")))
  use attr <- try_await(added |> webelement.get_attribute("class"))
  attr |> should.equal("redbox")

  driver |> d.quit()
}

pub fn explicit_test() {
  let assert Ok(driver) = d.get_driver(Chrome, "--headless")

  use _ <- try_await(driver |> d.get(selenium_url))
  use revealed <- try_await(driver |> d.find_element(by.id("revealed")))
  use elem <- try_await(driver |> d.find_element(by.id("reveal")))
  use _ <- try_await(elem |> webelement.click())
  use _ <- try_await(revealed |> webelement.send_keys(Text("Displayed")))
  use value <- try_await(revealed |> webelement.get_attribute("value"))
  value |> should.equal("Displayed")

  driver |> d.quit()
}
