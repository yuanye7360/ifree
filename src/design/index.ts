import { VueConstructor } from 'vue';

import { default as BaseTitle } from './BaseTitle/index.vue';
import { default as BaseTable } from './BaseTable/index.vue';
import { default as BaseDemoBox } from './BaseDemoBox/index.vue';
import { default as BaseDemoContext } from './BaseDemoContext/index.vue';

const components = [BaseTitle, BaseTable, BaseDemoBox, BaseDemoContext];

components.map((component) => {
  component.install = function (Vue: VueConstructor) {
    Vue.component(component.name, component);
  };
});

const install = function (Vue: VueConstructor) {
  components.map((component) => {
    Vue.use(component);
  });
};

export default {
  install,
};
