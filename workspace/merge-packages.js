const fs = require('fs');

const source = '/home/workspace/src/package.json';
const target = '/home/workspace/package.json';

if (fs.existsSync(source)) {
  const left = JSON.parse(fs.readFileSync(target, 'utf8'));
  const right = JSON.parse(fs.readFileSync(source, 'utf8'));

  left.dependencies ||= {};

  Object.assign(left.scripts, right.scripts || {});
  Object.assign(left.dependencies, right.dependencies || {});
  Object.assign(left.devDependencies, right.devDependencies || {});

  const pkg = JSON.stringify(left, null, 2);
  fs.writeFileSync(target, pkg);

  console.log('Added project dependencies');
  console.log(pkg);
}
