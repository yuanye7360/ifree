<template>
  <div :class="prefixCls">
    <div :class="`${prefixCls}-logo`" @click="$router.push('/')">
      <img src="../assets/logo.png" alt="logo" />
      组件预览
    </div>
  </div>
</template>

<script lang="ts">
  import { getPrefixCls } from '@/utils';

  export default {
    name: 'HeaderLayout',
    computed: {
      prefixCls() {
        return getPrefixCls('header');
      },
    },
  };
</script>

<style lang="scss" scoped>
  $prefix-cls: #{$namespace}-header;

  @media (width <= 767px) {
    .#{$prefix-cls} {
      padding: 0 15px;

      &-logo {
        span {
          display: none;
        }
      }
    }
  }

  .#{$prefix-cls} {
    display: flex;
    position: relative;
    z-index: 101;
    box-sizing: border-box;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    height: 60px;
    padding: 0 30px;
    border-bottom: $base-border-1;
    background: $base-bgcolor-0;
    white-space: nowrap;
    user-select: none;

    &-logo {
      display: flex;
      align-items: center;
      font-size: 22px;
      cursor: pointer;

      > img {
        width: 80px;
        margin-top: 20px;
      }
    }
  }
</style>
