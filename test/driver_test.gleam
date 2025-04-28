import gleam/javascript/promise.{await}
import gleeunit/should
import locator/by
import webdriver.{Chrome}
import webelement

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

pub fn navigation_test() {
  let assert Ok(driver) = webdriver.get_driver(Chrome, "--headless")
  use _ <- await(driver |> webdriver.get(selenium_url))
  use url <- await(driver |> webdriver.get_current_url())
  url |> should.equal(Ok(selenium_url))

  use submit_element <- promise.await(
    driver |> webdriver.find_element(by.xpath("//button[text()='Submit']")),
  )
  submit_element |> should.be_ok()
  let assert Ok(submit_element) = submit_element
  use _ <- await(submit_element |> webelement.click())

  use url <- await(driver |> webdriver.get_current_url())
  url |> should.not_equal(Ok(selenium_url))

  driver |> webdriver.navigate(webdriver.Back)

  use url <- await(driver |> webdriver.get_current_url())
  url |> should.equal(Ok(selenium_url))

  use _ <- await(driver |> webdriver.navigate(webdriver.Forward))

  use url <- await(driver |> webdriver.get_current_url())
  url |> should.not_equal(Ok(selenium_url))

  use _ <- await(driver |> webdriver.navigate(webdriver.Back))

  use url <- await(driver |> webdriver.get_current_url())
  url |> should.equal(Ok(selenium_url))

  await(driver |> webdriver.quit(), promise.resolve)
}
