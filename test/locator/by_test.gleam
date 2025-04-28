// import gleam/string
// import gleeunit/should
// import locator/by

// const example_string = "example"

// const success = Nil

// pub fn by_class_name_test() {
//   let assert Ok(locator) = by.class_name(example_string) |> by.decode()

//   case locator {
//     by.ClassName("." <> value) if example_string == value -> success
//     _ -> should.fail()
//   }
// }

// pub fn by_css_test() {
//   let assert Ok(locator) = by.css(example_string) |> by.decode()

//   case locator {
//     by.Css(value) if example_string == value -> success
//     _ -> should.fail()
//   }
// }

// pub fn by_id_test() {
//   let assert Ok(locator) = by.id(example_string) |> by.decode()

//   case locator {
//     by.Id(value) -> {
//       string.join(["*[id=", example_string, "]"], "\"")
//       |> should.equal(value)
//     }
//     _ -> should.fail()
//   }
// }

// pub fn by_name_test() {
//   let assert Ok(locator) = by.name(example_string) |> by.decode()

//   case locator {
//     by.Name(value) -> {
//       string.join(["*[name=", example_string, "]"], "\"")
//       |> should.equal(value)
//     }

//     _ -> should.fail()
//   }
// }

// pub fn by_link_text_test() {
//   let assert Ok(locator) = by.link_text(example_string) |> by.decode()

//   case locator {
//     by.LinkText(value) if example_string == value -> success
//     _ -> should.fail()
//   }
// }

// pub fn by_partial_link_text_test() {
//   let assert Ok(locator) = by.partial_link_text(example_string) |> by.decode()

//   case locator {
//     by.PartialLinkText(value) if example_string == value -> success
//     _ -> should.fail()
//   }
// }

// // pub fn by_tag_name_test() {
// //   let assert Ok(locator) = by.tag_name(example_string) |> by.decode()

// //   case locator {
// //     by.TagName(value) if example_string == value -> success
// //     _ -> should.fail()
// //   }
// // }

// pub fn by_xpath_test() {
//   let assert Ok(locator) = by.xpath(example_string) |> by.decode()

//   case locator {
//     by.XPath(value) if example_string == value -> success
//     _ -> should.fail()
//   }
// }
