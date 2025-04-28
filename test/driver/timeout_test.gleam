import gleam/dict.{type Dict}
import gleam/dynamic/decode.{type Dynamic}
import gleam/javascript/promise
import gleeunit/should
import webdriver
import webdriver/timeout.{type Timeout}

const selenium_url = "https://www.selenium.dev/selenium/web/web-form.html"

const default_implicit_value = #("implicit", 0)

const default_page_load_value = #("pageLoad", 300_000)

const default_script_value = #("script", 30_000)

pub fn implicit_timeout_test() {
  let test_value = 44

  use timeouts <- setup_driver([timeout.Implicit(test_value)])
  decode(timeouts)
  |> should.equal(
    dict.from_list([
      #("implicit", test_value),
      default_page_load_value,
      default_script_value,
    ]),
  )
}

pub fn page_load_timeout_test() {
  let test_value = 55

  use timeouts <- setup_driver([timeout.PageLoad(test_value)])
  decode(timeouts)
  |> should.equal(
    dict.from_list([
      default_implicit_value,
      #("pageLoad", test_value),
      default_script_value,
    ]),
  )
}

pub fn script_timeout_test() {
  let test_value = 66

  use timeouts <- setup_driver([timeout.Script(test_value)])
  decode(timeouts)
  |> should.equal(
    dict.from_list([
      default_implicit_value,
      default_page_load_value,
      #("script", test_value),
    ]),
  )
}

// Helpers =====================================================================

/// Starts the webdriver for the tests
fn setup_driver(timeout: List(Timeout), test_case) {
  let driver = webdriver.get_driver(webdriver.Chrome, "--headless")
  let assert Ok(driver) = driver
  use _ <- promise.try_await(driver |> webdriver.get(selenium_url))
  use _ <- promise.try_await(driver |> webdriver.set_timeouts(timeout))
  use timeouts <- promise.try_await(driver |> webdriver.get_timeouts())
  use _ <- promise.try_await(webdriver.quit(driver))
  test_case(timeouts)
  |> Ok
  |> promise.resolve
}

fn decode(js_dict: Dynamic) -> Dict(String, Int) {
  let decoder = decode.dict(decode.string, decode.int)
  case decode.run(js_dict, decoder) {
    Ok(dict) -> dict
    _ -> {
      panic as "failed to decode js dict"
    }
  }
}
