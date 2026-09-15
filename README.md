# Energy per transaction: Bitcoin vs Nexa

A log–log figure of electricity per transaction as a function of throughput, for Bitcoin and
Nexa running on the same network power. Companion figure to the article
*"1 Bitcoin transaction: 580 kWh. 1 Nexa transaction with Blitz: 0.044 kWh."*

Live page: **https://jqrgen.github.io/nexa-energy-per-tx/**

## What Nexa is

Nexa is a proof-of-work blockchain in the Bitcoin lineage: the same UTXO accounting and the same
kind of mining, but engineered for throughput on the base layer, with native tokens and
script-template contracts instead of a second layer. Its bottlenecks are the ones every UTXO chain
hits on general-purpose CPUs, signature checks and coin lookups. Nexa benchmarks 42 000
transactions per second today; Blitz moves those two steps onto FPGAs, with a projected 100 000 TPS.

## Why this figure exists

A proof-of-work network burns whatever the block reward pays for, however many transactions it
carries, so energy per transaction is network electricity divided by throughput. The public debate
has been about the numerator; this figure fixes it at the Cambridge estimate (138 TWh a year) and
moves the denominator, the only term a protocol can change.

## The model

Proof-of-work electricity is set by the block reward, not by usage, so the numerator is
fixed and only throughput moves the result:

```
kWh per transaction = network electricity per second ÷ TPS
                    = 4 376 ÷ TPS          (138 TWh/yr, Cambridge CBECI)
```

| Chain            | Throughput   | kWh per tx (138 TWh/yr) | vs Bitcoin |
|------------------|-------------:|------------------------:|-----------:|
| Bitcoin          | 7.5 TPS      | 580                     | 1×         |
| Nexa (benchmark) | 42 000 TPS   | 0.104                   | 5 600× less |
| Nexa + Blitz     | 100 000 TPS  | 0.044                   | 13 000× less |

Below Bitcoin's throughput cap (~7 TPS, 7–14 theoretical) the two chains coincide. Beyond it
Bitcoin stays flat because the protocol cannot add throughput; Nexa continues along 1/TPS.
Both axes of the figure are logarithmic, each gridline a factor of ten, so the 13 000× gap spans only
four gridlines and looks far smaller than it is.

## Files

- `index.html` – the interactive figure. Hover or focus the plot and use ← → to read any
  throughput. Values are also in
  the table below the figure. The **Download SVG** and **Download PNG** buttons save the figure
  as shown, with the fonts embedded (PNG at 3×, 2700 × 1740).
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

## Further reading

Why Nexa's energy per transaction is lower than Bitcoin's:

- Cambridge Centre for Alternative Finance, [CBECI methodology](https://ccaf.io/cbnsi/cbeci/methodology).
  Bitcoin's power demand is estimated from hardware efficiency, mining profitability and hashrate,
  so the numerator is set by mining economics, not by transaction count.
- Nexa, [Nexa Mining](https://nexa.org/mining). Nexapow "contributes computing power to remove two
  key bottlenecks in scalability: signature signing and UTXO lookups", the steps that cap
  throughput on every UTXO chain.

Why less energy per transaction means less environmental impact (NTNU research):

- Borgelt, J., Gilad, D., May, R. and Verones, F. (NTNU Industrial Ecology Programme and NINA),
  *Renewable energy growth amplifies land pressure on Norwegian biodiversity*, Cleaner Energy
  Systems 13 (2026). [DOI](https://doi.org/10.1016/j.cles.2026.100238). Norway's renewable
  build-out to 2050 "could increase the overall impact on habitat loss by as much as 28%"; "the
  most effective way to substantially reduce biodiversity impacts is to lower electricity demand
  through energy efficiency measures"
  ([NTNU, May 2026](https://norwegianscitechnews.com/2026/05/location-matters-balancing-renewable-energy-and-biodiversity-in-norway/)).
- Hertwich, E. G., Gibon, T. et al. (NTNU), *Integrated life-cycle assessment of electricity-supply
  scenarios confirms global environmental benefit of low-carbon technologies*, PNAS 112 (20),
  6277–6282 (2015). [DOI](https://doi.org/10.1073/pnas.1312753111). Low-carbon electricity beats
  fossil generation by far but still carries land, material and emission footprints.
- HighEFF (SINTEF Energy with NTNU), [*Energy efficiency first!*](https://www.sintef.no/projectweb/higheff/outreach/higheff-at-ntnu-energy-transition-week-2024-energy-efficiency-first/),
  NTNU Energy Transition Week 2024. Norway committed at COP28 to "put the principle of energy
  efficiency as the first fuel at the core of policymaking, planning and investment decisions";
  "energy efficiency is a conflict-free measure that frees energy to be used for other purposes".
- Alzoubi, Y. I. and Mishra, A. (NTNU), *Green blockchain – a move towards sustainability*,
  Journal of Cleaner Production 430 (2023). [DOI](https://doi.org/10.1016/j.jclepro.2023.139541).
  "The main cause of concern is the generation of atmospheric carbon emissions resulting from
  excessive energy usage."

## Sources

Cambridge CBECI, Blockchair, 2026. Nexa's 42 000 TPS is benchmarked;
100 000 TPS with Blitz is a projection.
