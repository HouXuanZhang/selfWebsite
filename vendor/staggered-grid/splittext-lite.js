(function () {
  class SplitText {
    constructor(element, options = {}) {
      this.elements = typeof element === "string" ? Array.from(document.querySelectorAll(element)) : [element].filter(Boolean);
      this.type = options.type || "chars";
      this.chars = [];
      this.elements.forEach((target) => this.splitElement(target));
    }

    splitElement(target) {
      const text = target.textContent || "";
      target.textContent = "";
      Array.from(text).forEach((char) => {
        const span = document.createElement("span");
        span.textContent = char === " " ? "\u00a0" : char;
        span.style.display = "inline-block";
        target.appendChild(span);
        this.chars.push(span);
      });
    }
  }

  window.SplitText = SplitText;
})();
