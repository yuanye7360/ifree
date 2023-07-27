import Vue from 'vue';

import './global.scss';
import './style';

import App from './App.vue';
import router from '@/router';

// design
import DesignCompoents from './design';

Vue.use(DesignCompoents);

// 代码高亮指令
Vue.directive('highlight', {
  bind(el) {
    const blocks = el.querySelectorAll('pre code');

    blocks.forEach((block) => {
      hljs.highlightBlock(block);
    });
  },
});

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
