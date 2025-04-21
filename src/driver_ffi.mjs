import { Builder, Browser } from "selenium-webdriver";

// These lines make "require" available
import { createRequire } from "module";
const require = createRequire(import.meta.url);

const chrome = require("selenium-webdriver/chrome");

export async function getDriver() {
  let driver = new Builder()
    .forBrowser(Browser.CHROME)
    .setChromeOptions(new chrome.Options().headless)
    .build();

  return driver;
}

export async function getDriverForBrowser(browser) {
  let driver = await new Builder().forBrowser(browser).build();
  return driver;
}

export async function get(driver, url) {
  await driver.get(url);
}

export async function quit(driver) {
  await driver.quit();
}

export async function findElement(driver, locator) {
  return await driver.findElement(locator);
}

export async function findElements(driver, locator) {
  return await driver.findElements(locator);
}

export async function getTitle(driver) {
  return await driver.getTitle();
}

export async function setTimeouts(driver, timeouts) {
  await driver.manage().setTimeouts(timeouts);
}
