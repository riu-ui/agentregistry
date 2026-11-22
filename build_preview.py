#!/usr/bin/env python3
"""Build a chat-preview fragment from index.html.

Reproduces the registry page with widget adaptations:
- ethers CDN removed (sample mode never touches ethers: REGISTRY_ADDRESS
  is zero, so contractReady() is false and initReadOnly() never runs)
- <form> tags converted to <div> (widget rule: no form submission)
- Connect button overridden with a "Preview only" alert
Run from the frontend/ directory. Output: preview-widget.html
"""
import re

with open("index.html", encoding="utf-8") as f:
    src = f.read()

# 1. Drop the ethers CDN tag (head).
src = src.replace(
    '<script src="https://cdn.jsdelivr.net/npm/ethers@6.13.0/dist/ethers.min.js"></script>',
    "",
)

# 2. Style block.
style = src[src.index("<style>") : src.index("</style>") + len("</style>")]

# 3. Body markup: between <body> and the main <script> block.
body_start = src.index("<body>") + len("<body>")
script_start = src.index("<script>", body_start)
markup = src[body_start:script_start]

# 4. Main script: up to the last </script> in the file.
script_end = src.rindex("</script>")
js = src[script_start + len("<script>") : script_end]

# 5. No <form> elements in widgets: convert to <div>, keep contents.
markup = re.sub(r"<form(\s[^>]*)?>", "<div>", markup)
markup = markup.replace("</form>", "</div>")

override = """
// --- preview overrides ---
document.getElementById("connectBtn").onclick = function () {
  alert("Preview only: wallet connect is disabled here. On the live site this button connects your wallet.");
};
"""

out = style + "\n" + markup + "\n<script>" + js + override + "</script>\n"
with open("preview-widget.html", "w", encoding="utf-8") as f:
    f.write(out)
with open("/tmp/preview-js-check.js", "w", encoding="utf-8") as f:
    f.write(js + override)

print("bytes:", len(out))
print("has cdn:", "jsdelivr" in out)
print("has <form:", "<form" in out)
print("has override:", "Preview only" in out)
print("has ethers ref in js:", "ethers." in js)
