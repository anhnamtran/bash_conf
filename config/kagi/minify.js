#!/usr/bin/env node
// Minifies kage.css with clean-css level 2 and writes result to stdout.
// Usage: node minify.js
//        node minify.js | wc -c   (check size)
//        node minify.js | xclip -selection clipboard

const path = require('path');
const fs = require('fs');

const arg = process.argv[2];
if (!arg) {
  process.stderr.write('Usage: node minify.js <file.css>\n');
  process.exit(1);
}
const cssPath = path.resolve(arg);

// Install clean-css locally if not present
const modDir = path.join(__dirname, 'node_modules');
if (!fs.existsSync(path.join(modDir, 'clean-css'))) {
  process.stderr.write('Installing clean-css...\n');
  require('child_process').execSync('npm install clean-css --no-save', {
    cwd: __dirname,
    stdio: ['ignore', 'ignore', 'inherit']
  });
}

const CleanCSS = require(path.join(modDir, 'clean-css'));
const css = fs.readFileSync(cssPath, 'utf8');
const result = new CleanCSS({ level: 2 }).minify(css);

if (result.errors.length) {
  process.stderr.write('Errors:\n' + result.errors.join('\n') + '\n');
  process.exit(1);
}

process.stderr.write(`${result.styles.length} chars (limit: 40000)\n`);
process.stdout.write(result.styles);
