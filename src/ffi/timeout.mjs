export function timeouts(timeouts) {
  return {
    implicit: timeouts.get("implicit"),
    script: timeouts.get("script"),
    pageLoad: timeouts.get("pageLoad"),
  };
}
