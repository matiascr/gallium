import driver
import driver/timeout.{type Timeout}
import gleam/dict.{type Dict}
import gleam/dynamic/decode.{type Dynamic}
import gleam/javascript/promise
import gleeunit/should

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

/// Starts the webdriver for the tests
fn setup_driver(timeout: List(Timeout), test_case) {
  use driver <- promise.await(driver.get_default_driver())
  use _ <- promise.await(driver |> driver.get(selenium_url))
  use _ <- promise.await(driver |> driver.set_timeouts(timeout))
  use timeouts <- promise.await(driver |> driver.get_timeouts())
  use _ <- promise.await(driver.quit(driver))
  test_case(timeouts)
  promise.resolve(Nil)
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
