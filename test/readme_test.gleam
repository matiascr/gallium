import by
import driver
import driver/timeout
import gleam/javascript/promise.{await}
import gleeunit/should
import webelement

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn example_test() {
  // 1. Start the webdriver
  use driver <- await(driver.get_default_driver())

  // 2. Take action on browser
  use _ <- await(driver |> driver.get(selenium_url))

  // 3. Request browser information
  use title <- await(driver |> driver.get_title())
  title |> should.equal("Web form")

  // 4. Establish Waiting Strategy
  use _ <- await(driver |> driver.set_timeouts([timeout.Implicit(500)]))

  // 5. Find an element
  use text_box <- await(driver |> driver.find_element(by.name("my-texa")))
  let assert Ok(text_box) = text_box
  use submit_button <- await(driver |> driver.find_element(by.css("button")))
  let assert Ok(submit_button) = submit_button

  // 6. Take action on element
  use _ <- await(text_box |> webelement.send_keys("Selenium"))
  use _ <- await(submit_button |> webelement.click())

  // 7. Request element information
  use message <- await(driver |> driver.find_element(by.id("message")))
  let assert Ok(message) = message
  use value <- await(message |> webelement.get_text())
  value |> should.equal("Received!")

  // 8. End the session
  driver |> driver.quit()
}
