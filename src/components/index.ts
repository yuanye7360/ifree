import { RouteConfig } from 'vue-router';

const modules = import.meta.glob('./*/index.ts');
const capitalizeRegex = /(?:^|[\s_-]+)\w/g;
const routes: RouteConfig[] = [];

let tempName = '';

for (const [path, module] of Object.entries(modules)) {
  tempName = path.replace(/^\.\/(.*)\/index.ts$/, '$1');
  tempName = tempName.replace(capitalizeRegex, (match) => match.toUpperCase()).replace('-', '');

  routes.push({
    name: 'Ifree' + tempName,
    path: '/' + tempName,
    component: module as any,
  });
}

export default routes;
