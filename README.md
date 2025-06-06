# Gallium

Selenium bindings for Gleam

```sh
gleam add gallium@1
npm install selenium-webdriver
```

The following is an example of Gallium being used within Gleeunit:

```gleam
import gallium/by
import gallium/driver.{Chrome}
import gallium/driver/timeout
import gallium/webelement
import gleam/javascript/promise.{await}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn example_test() {
  // 1. Start the webdriver
  use driver <- await(driver.get_driver_for_browser(Chrome))

  // 2. Take action on browser
  use _ <- await(driver |> driver.get(selenium_url))

  // 3. Request browser information
  use title <- await(driver |> driver.get_title())
  title |> should.equal("Web form")

  // 4. Establish Waiting Strategy
  use _ <- await(driver |> driver.set_timeouts([timeout.Implicit(500)]))

  // 5. Find an element
  use text_box <- await(driver |> driver.find_element(by.name("my-text")))
  use submit_button <- await(driver |> driver.find_element(by.css("button")))

  // 6. Take action on element
  use _ <- await(text_box |> webelement.send_keys("Selenium"))
  use _ <- await(submit_button |> webelement.click())

  // 7. Request element information
  use message <- await(driver |> driver.find_element(by.id("message")))
  use value <- await(message |> webelement.get_text())
  value |> should.equal("Received!")

  // 8. End the session
  driver |> driver.quit()
}
```

## Development

```sh
gleam test  # Run the tests
```

