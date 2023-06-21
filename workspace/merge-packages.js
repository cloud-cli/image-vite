const fs = require("fs");

if (fs.existsSync("./app/package.json")) {
  const left = JSON.parse(fs.readFileSync("./package.json", "utf8"));
  const right = JSON.parse(fs.readFileSync("./app/package.json", "utf8"));

  Object.assign(left.scripts, right.scripts || {});
  Object.assign(left.dependencies, right.dependencies || {});
  Object.assign(left.devDependencies, right.devDependencies || {});

  fs.writeFileSync("./package.json", JSON.stringify(left));
}
