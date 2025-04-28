import gleam/javascript/promise.{try_await}
import gleeunit/should
import input/key.{Text}
import locator/by
import webdriver.{Chrome} as d
import webdriver/timeout.{Implicit}
import webelement

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn first_script_test() {
  let assert Ok(driver) = d.get_driver(Chrome, "--headless")
  use _ <- try_await(driver |> d.get(selenium_url))

  use title <- try_await(driver |> d.get_title())
  title |> should.equal("Web form")

  use _ <- try_await(driver |> d.set_timeouts([Implicit(500)]))

  use text_box <- try_await(driver |> d.find_element(by.name("my-text")))
  use submit_button <- try_await(driver |> d.find_element(by.css("button")))

  use _ <- try_await(text_box |> webelement.send_keys(Text("Selenium")))
  use _ <- try_await(submit_button |> webelement.click())

  use message <- try_await(driver |> d.find_element(by.id("message")))
  use value <- try_await(message |> webelement.get_text())
  value |> should.equal("Received!")

  driver |> d.quit()
}
