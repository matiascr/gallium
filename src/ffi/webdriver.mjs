import { Builder, Browser } from "selenium-webdriver";
import { Ok, Error } from "../gleam.mjs";

// These lines make "require" available
import { createRequire } from "module";
const require = createRequire(import.meta.url);

const chrome = require("selenium-webdriver/chrome");
const edge = require("selenium-webdriver/edge");
const firefox = require("selenium-webdriver/firefox");
const safari = require("selenium-webdriver/safari");

const Nil = undefined;

export function getDriver(browser, args) {
  try {
    let builder = new Builder();
    let webdriver;
    if (args && browser == Browser.CHROME) {
      let options = new chrome.Options();
      webdriver = builder
        .forBrowser(browser)
        .setChromeOptions(options.addArguments(args))
        .build();
    } else if (args && browser == Browser.EDGE) {
      let options = new edge.Options();
      webdriver = builder
        .forBrowser(Browser.EDGE)
        .setEdgeOptions(options.addArguments(args))
        .build();
    } else if (args && browser == Browser.FIREFOX) {
      let options = new firefox.Options();
      webdriver = builder
        .forBrowser(Browser.FIREFOX)
        .setFirefoxOptions(options.addArguments(args))
        .build();
    } else if (args && browser == Browser.SAFARI) {
      let options = new safari.Options();
      webdriver = builder
        .forBrowser(Browser.SAFARI)
        .setSafariOptions(options.addArguments(args))
        .build();
    } else if (browser == Browser.INTERNET_EXPLORER) {
      webdriver = builder.forBrowser(Browser.INTERNET_EXPLORER).build();
    } else {
      webdriver = builder.forBrowser(Browser.CHROME).build();
    }

    return new Ok(webdriver);
  } catch (e) {
    return new Error(e);
  }
}

export async function findElement(webdriver, locator) {
  return await webdriver.findElement(locator).then(okRet).catch(err);
}

export async function findElements(webdriver, locator) {
  return await webdriver.findElements(locator).then(okRet).catch(err);
}

export async function get(webdriver, url) {
  return await webdriver.get(url).then(okNil).catch(err);
}

export async function getCurrentUrl(webdriver) {
  return await webdriver.getCurrentUrl().then(okRet).catch(err);
}

export async function getPageSource(webdriver) {
  return await webdriver.getPageSource().then(okRet).catch(err);
}

export async function getTimeouts(webdriver) {
  return await webdriver.manage().getTimeouts().then(okRet).catch(err);
}

export async function getTitle(webdriver) {
  return await webdriver.getTitle().then(okRet).catch(err);
}
export async function navigate(webdriver, location) {
  switch (location) {
    case "back":
      return await webdriver.navigate().back().then(okNil).catch(err);
    case "forward":
      return await webdriver.navigate().forward().then(okNil).catch(err);
    case "refresh":
      return await webdriver.navigate().refresh().then(okNil).catch(err);
    default:
      return await webdriver.navigate().to(location).then(okNil).catch(err);
  }
}

export async function quit(webdriver) {
  return await webdriver.quit().then(okNil).catch(err);
}

export async function setTimeouts(webdriver, timeouts) {
  return await webdriver.manage().setTimeouts(timeouts).then(okNil).catch(err);
}

export async function sleep(webdriver, ms) {
  return await webdriver.sleep(ms).then(okNil).catch(err);
}

const err = (e) => {
  return new Error(e);
};

const okRet = (ret) => {
  if (ret == null || ret == undefined) {
    return new Ok(Nil);
  } else {
    return new Ok(ret);
  }
};

const okNil = () => {
  return new Ok(Nil);
};
