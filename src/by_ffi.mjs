import { By } from 'selenium-webdriver';

export function className(locator) { return By.className(locator) }
export function css(locator) { return By.css(locator) }
export function id(locator) { return By.id(locator) }
export function name(locator) { return By.name(locator) }
export function linkText(locator) { return By.linkText(locator) }
export function partialLinkText(locator) { return By.partialLinkText(locator) }
export function tagName(locator) { return By.tagName(locator) }
export function xpath(locator) { return By.xpath(locator) }

