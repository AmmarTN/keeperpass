# Card network logos

From Aaron Fagan's svg-credit-card-payment-icons, `logo/` folder,
commit 6dd023ae32415ed7b01bf809f15a25613a52098c (2026-04-28):
https://github.com/aaronfagan/svg-credit-card-payment-icons —
Apache License 2.0 (`LICENSE` in this folder).

Copied into the app so it never depends on that repository.

Changes made to the original files:

- The frame (`viewBox`) is trimmed to the drawn logo, plus 2 units on each
  side; the artwork itself is unchanged.
- `mir.svg`: the colours set by CSS classes are written as plain `fill`
  attributes, because the app's SVG renderer ignores `<style>`.
- `*-dark.svg` (Visa, American Express, Discover, Elo, Hipercard): the dark
  letters are white, for the dark card, as each network's own rules allow on
  dark backgrounds. Colours that are not letters stay as they were.

The logos are the trademarks of their card networks. They are shown only to
identify the network of a card the user stored.
