# Energy per transaction: Bitcoin vs Nexa

A log–log figure of electricity per transaction as a function of throughput, for Bitcoin and
Nexa running on the same network power. Companion figure to the article
*"1 Bitcoin transaction: 580 kWh. 1 Nexa transaction with Blitz: 0.044 kWh."*

Live page: **https://jqrgen.github.io/nexa-energy-per-tx/**

## The model

Proof-of-work electricity is set by the block reward, not by usage, so the numerator is
fixed and only throughput moves the result:

```
kWh per transaction = network electricity per second ÷ TPS
                    = 4 376 ÷ TPS          (138 TWh/yr, Cambridge CBECI)
                    = 6 469 ÷ TPS          (204 TWh/yr, Digiconomist)
```

| Chain            | Throughput   | kWh per tx (138 TWh/yr) | vs Bitcoin |
|------------------|-------------:|------------------------:|-----------:|
| Bitcoin          | 7.5 TPS      | 580                     | 1×         |
| Nexa (benchmark) | 42 000 TPS   | 0.104                   | 5 600× less |
| Nexa + Blitz     | 100 000 TPS  | 0.044                   | 13 000× less |

Below Bitcoin's throughput cap (~7 TPS, 7–14 theoretical) the two chains coincide. Beyond it
Bitcoin stays flat because the protocol cannot add throughput; Nexa continues along 1/TPS.
The ratio between the chains does not depend on which electricity estimate you use.

## Files

- `index.html` – the interactive figure. Toggle between the Cambridge and Digiconomist
  estimates; hover or focus the plot and use ← → to read any throughput. Values are also in
  the table below the figure.
- `export/nexa-vs-bitcoin-energy-per-tx.png` – static light version (2400 × 1780) for articles.
- `export/nexa-vs-bitcoin-energy-per-tx-dark.png` – dark variant.
- `scripts/render-png.sh` – regenerates both PNGs from `index.html` with headless Chrome.

Query parameters on the page: `?export=1` shows only the figure and caption at 1200 px wide;
`&theme=light` or `&theme=dark` forces a theme.

## Deployment

Every push to `main` runs `.github/workflows/pages.yml`, which mirrors `main` into the
`gh-pages` branch. GitHub Pages serves that branch as a static site, so the live page always
matches the latest commit on `main`. No build step: the page is a single HTML file with inline
CSS and JavaScript, and loads its fonts (Old Standard TT, Roboto) from Google Fonts. The
`.nojekyll` file tells Pages to serve the files as they are.

## Sources

Cambridge CBECI, Digiconomist, Blockchair, 2026. Nexa's 42 000 TPS is benchmarked;
100 000 TPS with Blitz is a projection.
