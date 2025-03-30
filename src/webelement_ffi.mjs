export function findElement(element, locator) {
  return element.findElement(locator);
}

export function findElements(element, locator) {
  return element.findElements(locator);
}

export async function sendKeys(element, keys) {
  return await element.sendKeys(keys);
}

export async function click(element) {
  return await element.click();
}

export async function getText(element) {
  return await element.getText();
}

export async function clear(element) {
  return await element.clear();
}


