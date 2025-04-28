import gleam/javascript/promise.{try_await}
import gleeunit/should
import webdriver.{Back, Chrome, Forward, Refresh, To} as d

pub fn browser_navigation_test() {
  let assert Ok(driver) = d.get_driver(Chrome, "--headless")
  // Convenient
  use _ <- try_await(driver |> d.get("https://www.selenium.dev"))

  // Longer way
  use _ <- try_await(
    driver |> d.navigate(To("https://www.selenium.dev/selenium/web/index.html")),
  )
  use title <- try_await(driver |> d.get_title())
  title |> should.equal("Index of Available Pages")

  // Back
  use _ <- try_await(driver |> d.navigate(Back))
  use title <- try_await(driver |> d.get_title())
  title |> should.equal("Selenium")

  // Forward
  use _ <- try_await(driver |> d.navigate(Forward))
  use title <- try_await(driver |> d.get_title())
  title |> should.equal("Index of Available Pages")

  // Refresh
  use _ <- try_await(driver |> d.navigate(Refresh))
  use title <- try_await(driver |> d.get_title())
  title |> should.equal("Index of Available Pages")

  // Quit
  d.quit(driver)
}
