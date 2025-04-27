import gleam/dict.{type Dict}
import gleam/list

pub type Timeouts =
  Dict(String, Int)

pub type Timeout {
  Script(Int)
  PageLoad(Int)
  Implicit(Int)
}

pub fn timeouts(timeouts) -> timeouts {
  timeouts
  |> list.map(fn(t) {
    case t {
      Implicit(v) -> #("implicit", v)
      PageLoad(v) -> #("pageLoad", v)
      Script(v) -> #("script", v)
    }
  })
  |> dict.from_list()
  |> do_timeouts()
}

@external(javascript, "./ffi/timeout.mjs", "timeouts")
fn do_timeouts(timeouts: Dict(String, Int)) -> timeouts
