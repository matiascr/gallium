import by.{Locator}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

const example_string = "example"

pub fn by_class_name_test() {
  let locator = by.class_name(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "css selector")
  should.equal(value, "." <> example_string)
}

pub fn by_css_test() {
  let locator = by.css(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "css selector")
  should.equal(value, example_string)
}

pub fn by_id_test() {
  let locator = by.id(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "css selector")
  should.equal(value, "*[id=\"" <> example_string <> "\"]")
}

pub fn by_name_test() {
  let locator = by.name(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "css selector")
  should.equal(value, "*[name=\"" <> example_string <> "\"]")
}

pub fn by_link_text_test() {
  let locator = by.link_text(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "link text")
  should.equal(value, example_string)
}

pub fn by_partial_link_text_test() {
  let locator = by.partial_link_text(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "partial link text")
  should.equal(value, example_string)
}

pub fn by_tag_name_test() {
  let locator = by.tag_name(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "tag name")
  should.equal(value, example_string)
}

pub fn by_xpath_test() {
  let locator = by.xpath(example_string) |> by.decode()
  should.be_ok(locator)
  let assert Ok(Locator(using, value)) = locator
  should.equal(using, "xpath")
  should.equal(value, example_string)
}
