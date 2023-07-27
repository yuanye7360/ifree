<template>
  <div :class="prefixCls">
    <div :class="`${prefixCls}--sider`">
      <sider-bar :group="group" />
    </div>
    <div ref="mainRef" :class="`${prefixCls}--main btf-scrollbar`">
      <router-view v-slot="{ Component }">
        <keep-alive>
          <component :is="Component" />
        </keep-alive>
      </router-view>
    </div>
  </div>
</template>

<script lang="ts">
  import { getPrefixCls } from '@/utils';
  import siderGroup from '@/config/group';
  import SiderBar from '@/layout/SiderBar.vue';

  export default {
    name: 'DemoButton',
    components: {
      SiderBar,
    },
    data() {
      return {
        isShowSider: false,
        group: Object.freeze(siderGroup),
      };
    },
    computed: {
      prefixCls() {
        return getPrefixCls('container');
      },
    },
  };
</script>

<style lang="scss" scoped>
  $prefix-cls: #{$namespace}-container;

  @media (width <= 767px) {
    .#{$prefix-cls}--sider {
      z-index: 99999;
      transform: translateX(-100%);
      transition: transform 0.85s cubic-bezier(0.65, 0, 0.35, 1);
    }

    .#{$prefix-cls}--main {
      width: 100%;
      margin-left: 0;
      padding: 50px 15px;
    }
  }

  .#{$prefix-cls} {
    display: flex;
    height: calc(100vh - 60px);

    &--sider {
      position: fixed;
      top: 59px;
      height: calc(100vh - 58px);
      background-color: rgb(255 255 255);
    }

    &--main {
      box-sizing: border-box;
      width: calc(100% - 260px);
      height: calc(100vh - 60px);
      margin-left: 260px;
      padding: 50px 50px 150px;
      overflow-x: hidden;
      overflow-y: scroll;
      background: rgb(250 250 250);
    }
  }
</style>
