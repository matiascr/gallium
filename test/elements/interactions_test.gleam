import gleam/javascript/promise.{try_await}
import gleeunit/should
import input/key.{Text}
import locator/by
import webdriver.{Chrome} as d
import webelement

pub fn should_clear_input_and_send_keys_into_input_field_test() {
  let assert Ok(driver) = d.get_driver(Chrome, "--headless")
  use _ <- try_await(driver |> d.get("https://www.selenium.dev"))

  use input_field <- try_await(driver |> d.find_element(by.name("no_type")))

  use _ <- try_await(input_field |> webelement.clear())
  use _ <- try_await(input_field |> webelement.send_keys(Text("Selenium")))

  use text <- try_await(input_field |> webelement.get_attribute("value"))
  text |> should.equal("Selenium")

  d.quit(driver)
}
