# Gallium

Selenium bindings for Gleam

```sh
gleam add gallium@1

# Install dependencies
npm install selenium-webdriver
# or
bun install selenium-webdriver
```

_Note: the current version of Gallium does **NOT** work on the `deno` runtime._

The following is an example of Gallium being used within Gleeunit:

```gleam
import gallium/input/key.{Text}
import gallium/locator/by
import gallium/webdriver.{Chrome}
import gallium/webdriver/timeout
import gallium/webelement
import gleam/javascript/promise.{try_await}
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn example_test() {
  // 1. Start the webdriver
  let assert Ok(driver) = webdriver.get_driver(Chrome, "--headless")

  // 2. Take action on browser
  use _ <- try_await(driver |> webdriver.get(selenium_url))

  // 3. Request browser information
  use title <- try_await(driver |> webdriver.get_title())
  title |> should.equal("Web form")

  // 4. Establish Waiting Strategy
  use _ <- try_await(driver |> webdriver.set_timeouts([timeout.Implicit(500)]))

  // 5. Find an element
  use text_box <- try_await(
    driver |> webdriver.find_element(by.name("my-text")),
  )
  use submit_button <- try_await(
    driver |> webdriver.find_element(by.css("button")),
  )

  // 6. Take action on element
  use _ <- try_await(text_box |> webelement.send_keys(Text("Selenium")))
  use _ <- try_await(submit_button |> webelement.click())

  // 7. Request element information
  use message <- try_await(driver |> webdriver.find_element(by.id("message")))
  use value <- try_await(message |> webelement.get_text())
  value |> should.equal("Received!")

  // 8. End the session
  driver |> webdriver.quit()
}
```

## Development

```sh
gleam test # Run the tests
```
_Note: Using the `nodejs` runtime to run `gleam test` can lead to memory errors, so it is recommended to use `bun`._

