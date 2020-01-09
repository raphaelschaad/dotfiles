# Installed Node modules

To install Node, install the Node Version Manager [nvm](https://github.com/nvm-sh/nvm#installing-and-updating) first (don't brew nvm nor node). Then, use `nvm` to install node (npm is bundled with node). Install/update with `> nvm install node -g`/`npm install -g npm@latest`. http://stackoverflow.com/a/28025834/251440 (don't add `source $(brew --prefix nvm)/nvm.sh` to `.profile` as it slows down shell startup)

Tools installed with `npm install -g` – for reference when I setup a new machine. Listing only top level packages (like `> npm -g list --depth=0`), not including all dependencies.

- `shapefile`: Shapefile parser, e.g. to convert to GeoJSON (comes with command-line interface shp2json, by @mbostock)
- `d3-geo-projection`: geoproject, geo2svg
- `eslint`: JavaScript linter (common editors have integration package)
- `@starptech/prettyhtml`: Opinionated HTML formatter for Angular/Vue/Svelte/pure HTML5 templates (although prettier supports HTML now)
- `typescript`: Statically typed strict syntactical superset to JS
- `create-react-app`: Good way to start building a new React single page application with no build configuration.
- `@vue/cli`: Standard Tooling for Vue.js Development (newest version 3.x).
- `netlify-cli`: Deploy and manage Netlify sites from the CLI.
