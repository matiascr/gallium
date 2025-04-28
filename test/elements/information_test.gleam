import gleam/javascript/promise.{await, try_await}
import gleeunit/should
import locator/by
import webdriver as d
import webelement

pub fn check_if_element_is_displayed_test() {
  use driver <- test_env_1()
  use element <- try_await(driver |> d.find_element(by.name("email_input")))
  use result <- try_await(element |> webelement.is_displayed())
  result |> should.be_true

  Ok(Nil) |> promise.resolve
}

pub fn check_if_button_is_enabled_test() {
  use driver <- test_env_1()
  use element <- try_await(driver |> d.find_element(by.name("button_input")))
  use is_enabled <- try_await(element |> webelement.is_enabled())
  is_enabled |> should.be_true

  Ok(Nil) |> promise.resolve
}

pub fn check_if_checkbox_is_selected_test() {
  use driver <- test_env_1()
  use element <- try_await(driver |> d.find_element(by.name("checkbox_input")))
  use is_selected <- try_await(element |> webelement.is_selected())
  is_selected |> should.be_true

  Ok(Nil) |> promise.resolve
}

pub fn should_return_the_tagname_test() {
  use driver <- test_env_1()
  use element <- try_await(driver |> d.find_element(by.name("email_input")))
  use value <- try_await(element |> webelement.get_tag_name())
  value |> should.equal("input")

  Ok(Nil) |> promise.resolve
}

pub fn should_be_able_to_fetch_element_size_and_position_test() {
  use driver <- test_env_1()
  use element <- try_await(driver |> d.find_element(by.name("range_input")))
  use object <- await(element |> webelement.get_rect())

  object |> should.be_ok()

  Ok(Nil) |> promise.resolve
}

pub fn should_be_able_to_fetch_attributes_and_properties_test() {
  use driver <- test_env_1()
  use element <- try_await(
    driver |> d.find_element(by.xpath("//input[@name='email_input']")),
  )
  use name_attribute <- try_await(element |> webelement.get_attribute("name"))
  name_attribute |> should.equal("email_input")

  Ok(Nil) |> promise.resolve
}

pub fn should_return_the_css_specified_css_value_1_test() {
  use driver <- test_env_2()
  use _ <- try_await(
    driver |> d.get("https://www.selenium.dev/selenium/web/colorPage.html"),
  )
  use element <- try_await(driver |> d.find_element(by.id("namedColor")))
  use value <- try_await(
    element |> webelement.get_css_value("background-color"),
  )
  value |> should.equal("rgba(0, 128, 0, 1)")

  Ok(Nil) |> promise.resolve
}

pub fn should_return_the_css_specified_css_value_2_test() {
  use driver <- test_env_2()
  use _ <- try_await(
    driver |> d.get("https://www.selenium.dev/selenium/web/colorPage.html"),
  )
  use element <- try_await(driver |> d.find_element(by.id("justanotherLink")))
  use text <- try_await(element |> webelement.get_text())
  text |> should.equal("Just another link.")

  Ok(Nil) |> promise.resolve
}

// Helpers ========================================================================================

fn test_env_1(f) {
  let assert Ok(driver) = d.get_driver(d.Chrome, "--headless")
  use _ <- try_await(
    driver |> d.get("https://www.selenium.dev/selenium/web/web-form.html"),
  )
  f(driver)
  d.quit(driver)
}

fn test_env_2(f) {
  let assert Ok(driver) = d.get_driver(d.Chrome, "--headless")
  f(driver)
  d.quit(driver)
}
