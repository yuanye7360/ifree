<template>
  <div :class="prefixCls">
    <header-layout />
    <router-view />
  </div>
</template>

<script>
  import { getPrefixCls } from '@/utils';
  import HeaderLayout from '@/layout/HeaderLayout.vue';

  export default {
    name: 'App',
    components: {
      HeaderLayout,
    },
    computed: {
      prefixCls() {
        return getPrefixCls('app');
      },
    },
  };
</script>

<style lang="scss" scoped>
  $prefix-cls: #{$namespace}-app;

  @media (width <= 767px) {
    .#{$prefix-cls} {
      width: 100vw;
      border-right: none;
      border-left: none;
    }
  }

  .#{$prefix-cls} {
    max-width: 1440px;
    height: 100%;
    margin: 0 auto;
    border-right: $base-border-2;
    border-left: $base-border-2;
    background: $base-bgcolor-0;
  }
</style>
