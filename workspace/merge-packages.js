const fs = require("fs");

if (fs.existsSync("./app/package.json")) {
  const left = JSON.parse(fs.readFileSync("/home/workspace/package.json", "utf8"));
  const right = JSON.parse(fs.readFileSync("/home/app/package.json", "utf8"));

  Object.assign(left.scripts, right.scripts || {});
  Object.assign(left.dependencies, right.dependencies || {});
  Object.assign(left.devDependencies, right.devDependencies || {});
  const pkg = JSON.stringify(left, null, 2);
  fs.writeFileSync("/home/workspace/package.json", pkg);
  console.log(pkg);
}
