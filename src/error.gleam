import gleam/dynamic.{type Dynamic}

pub type Error {
  DriverError(Dynamic)
  SessionNotCreatedError
  FinderError(Dynamic)
  NoSuchElementError
}

pub type WebElementError {
  WebElementError
}
