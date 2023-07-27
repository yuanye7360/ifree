import Vue from 'vue';
import Router from 'vue-router';
import Components from '../views/Components.vue';
import docs from '../components/index';

Vue.use(Router);

export const constantRoutes = [
  {
    path: '/404',
    component: () => import('../views/404.vue'),
    hidden: true,
  },
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue'),
  },
  {
    path: '/Components',
    name: 'Components',
    component: Components,
    children: docs,
  },

  // 404 page must be placed at the end !!!
  { path: '*', redirect: '/404', hidden: true },
];

const createRouter = () =>
  new Router({
    scrollBehavior: () => ({ y: 0, x: 0 }),
    routes: constantRoutes,
  });

const router = createRouter();

export default router;
