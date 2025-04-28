import { By, WebElement } from "selenium-webdriver";
import { Ok, Error } from "../gleam.mjs";

const Nil = undefined;

export async function clear(element) {
  return await element.clear().then(okNil).catch(err);
}

export async function click(element) {
  return await element.click().then(okNil).catch(err);
}

export async function findElement(element, locator) {
  return await element.findElement(locator).then(okRet).catch(err);
}

export async function findElements(element, locator) {
  return await element.findElements(locator).then(okRet).catch(err);
}

export async function getCssValue(element, cssStyleProperty) {
  return await element.getCssValue(cssStyleProperty).then(okRet).catch(err);
}

export function getDriver(element) {
  try {
    return new Ok(element.getDriver());
  } catch (e) {
    return new Error(e);
  }
}

export async function getId(element) {
  return await element.getId().then(okRet).catch(err);
}

export async function getSize(element) {
  return await element.getSize().then(okRet).catch(err);
}

export async function getAttribute(element, attributeName) {
  return await element.getAttribute(attributeName).then(okRet).catch(err);
}

export async function getLocation(element) {
  return await element.getLocation().then(okRet).catch(err);
}

export async function getRect(element) {
  return await element.getRect().then(okRet).catch(err);
}

export async function getShadowRoot(element) {
  return await element.getShadowRoot().then(okRet).catch(err);
}

export async function getTagName(element) {
  return await element.getTagName().then(okRet).catch(err);
}

export async function getText(element) {
  return await element.getText().then(okRet).catch(err);
}

export async function isDisplayed(element) {
  return await element.isDisplayed().then(okRet).catch(err);
}

export async function isEnabled(element) {
  return await element.isEnabled().then(okRet).catch(err);
}

export async function isSelected(element) {
  return await element.isSelected().then(okRet).catch(err);
}

export async function sendKeys(element, keys) {
  return await element.sendKeys(keys).then(okNil).catch(err);
}

export async function submit(element) {
  return await element.submit().then(okNil).catch(err);
}

export async function takeScreenshot(element, scroll) {
  return await element.takeScreenshot(scroll).then(okNil).catch(err);
}

const err = (e) => {
  return new Error(e);
};

const okRet = (ret) => {
  return new Ok(ret);
};

const okNil = () => {
  return new Ok(Nil);
};
