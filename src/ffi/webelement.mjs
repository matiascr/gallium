// import { Error, Ok, Result } from "../gleam.mjs";
// import { Some, None } from "../gleam/option.mjs";

/**
 * @return `Promise<void>` A promise that will be resolved
 *     when the element has been cleared.
 */
export async function clear(element) {
  return await element.clear();
}

/**
 * @return `Promise<void>` A promise that will be resolved
 *     when the click command has completed.
 */
export async function click(element) {
  return await element.click();
}

/**
 * @param `by.By | Function` locator The locator strategy to use when
 *     searching for the element.
 * @return `Promise<WebElement>` A WebElement that can be used to issue
 *     commands against the located element. If the element is not found, the
 *     element will be invalidated and all scheduled commands aborted.
 */
export async function findElement(element, locator) {
  return await element.findElement(locator);
}

/**
 * @param `(by.By|Function)` locator The locator strategy to use when
 *     searching for the element.
 * @return `Promise<Array<WebElement>>` A
 *     promise that will resolve to an array of WebElements.
 */
export async function findElements(element, locator) {
  return await element.findElements(locator);
}

/**
 * @param `string` cssStyleProperty The name of the CSS style property to look
 *     up.
 * @return `Promise<string>` A promise that will be
 *     resolved with the requested CSS value.
 */
export async function getCssValue(element, cssStyleProperty) {
  return await element.getCssValue(cssStyleProperty);
}

/**
 * @return `WebDriver` The parent driver for this instance.
 */
export function getDriver(element) {
  return element.getDriver();
}

/**
 * @return `Promise<string>` A promise that resolves to
 *     the server-assigned opaque ID assigned to this element.
 */
export async function getId(element) {
  return await element.getId();
}

/**
 * @return `Promise<ISize>` A promise that will be resolved with the
 *     window's size in the form of a {width:number, height:number} object
 *     literal.
 */
export async function getSize(element) {
  return await element.getSize();
}

/**
 * @param `string` attributeName The name of the attribute to query.
 * @return `Promise<?string>` A promise that will be
 *     resolved with the attribute's value. The returned value will always be
 *     either a string or null.
 */
export async function getAttribute(element) {
  return await element.getAttribute();
}

/**
 * DEPRECATED 3.0
 * @return `Promise<{x: number, y: number}>` A promise that
 *     will be resolved to the element's location as a
 *     `{x:number, y:number}` object.
 */
export async function getLocation(element) {
  return await element.getLocation();
}

/**
 * @return `Promise<IRectangle>` A promise that will be
 *     resolved with the size and position of the element.
 */
export async function getRect(element) {
  return await element.getRect();
}

/**
 * @returns `Promise<ShadowRoot>` A promise that will be
 *      resolved with the elements shadow root or rejected
 *      with `NoSuchShadowRootError`
 */
export async function getShadowRoot(element) {
  return await element.getShadowRoot();
}

/**
 * @return `Promise<string>` A promise that will be
 *     resolved with the element's tag name.
 */
export async function getTagName(element) {
  return await element.getTagName();
}

/**
 * @return `Promise<string>` A promise that will be
 *     resolved with the element's visible text.
 */
export async function getText(element) {
  return await element.getText();
}

/**
 * @return `Promise<boolean>` A promise that will be
 *     resolved with whether this element is currently visible on the page.
 */
export async function isDisplayed(element) {
  return await element.isDisplayed();
}

/**
 * @return `Promise<boolean>` A promise that will be
 *     resolved with whether this element is currently enabled.
 */
export async function isEnabled(element) {
  return await element.isEnabled();
}

/**
 * @return `Promise<boolean>` A promise that will be
 *     resolved with whether this element is currently selected.
 */
export async function isSelected(element) {
  return await element.isSelected();
}

/**
 * @param `Array<string | number | Promise<string | number>>` var_args The sequence
 *     of keys to type. All arguments will be joined into a single sequence.
 * @return `Promise<void>` A promise that will be resolved
 *     when all keys have been typed.
 */
export async function sendKeys(element, keys) {
  return await element.sendKeys(keys);
}

export async function serialize(element) {
  return await element.serialize();
}

/**
 * @return `Promise<void>` A promise that will be resolved
 *     when the form has been submitted.
 */
export async function submit(element) {
  return await element.submit();
}

/**
 * @param `boolean` opt_scroll Optional argument that indicates whether the
 *     element should be scrolled into view before taking a screenshot.
 *     Defaults to false.
 * @return `Promise<string>` A promise that will be
 *     resolved to the screenshot as a base-64 encoded PNG.
 */
export async function takeScreenshot(element) {
  return await element.takeScreenshot();
}
