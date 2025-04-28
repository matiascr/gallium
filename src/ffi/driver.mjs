import { Builder, Browser } from "selenium-webdriver";

// These lines make "require" available
import { createRequire } from "module";
const require = createRequire(import.meta.url);

const chrome = require("selenium-webdriver/chrome");

export async function getDriver(args) {
  let options = new chrome.Options();
  let driver = new Builder()
    .forBrowser(Browser.CHROME)
    .setChromeOptions(options.addArguments(args))
    .build();

  return driver;
}

export async function getDefaultDriver() {
  let options = new chrome.Options();
  let driver = new Builder()
    .forBrowser(Browser.CHROME)
    .setChromeOptions(options.addArguments("--headless"))
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

export async function getTimeouts(driver) {
  return await driver.manage().getTimeouts();
}

export async function getBrowserName(driver) {
  return await driver.getB;
}
