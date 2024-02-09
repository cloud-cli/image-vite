const fs = require("fs");

const appPackage = "/home/app/package.json";
const workspacePackage = "/home/workspace/package.json";

if (fs.existsSync(appPackage)) {
  const left = JSON.parse(fs.readFileSync(appPackage, "utf8"));
  const right = JSON.parse(fs.readFileSync(workspacePackage, "utf8"));

  left.dependencies ||= {};
  left.devDependencies ||= {};

  Object.assign(left.dependencies, right.dependencies || {});
  Object.assign(left.devDependencies, right.devDependencies || {});

  const pkg = JSON.stringify(left, null, 2);
  fs.writeFileSync(appPackage, pkg);

  console.log("Added project dependencies");
  console.log(pkg);
}
