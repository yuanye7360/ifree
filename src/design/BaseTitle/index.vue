<template>
  <div :class="prefixCls" :style="`font-weight:${bold};font-size:${size}`">
    <slot></slot>
  </div>
</template>

<script>
  import { getPrefixCls } from '@/utils';

  export default {
    name: 'BaseTitle',
    props: {
      bold: {
        type: Number,
        default: 800,
      },
      size: {
        type: String,
        default: '24px',
      },
    },
    computed: {
      prefixCls() {
        return getPrefixCls('title');
      },
    },
  };
</script>

<style lang="scss" scoped>
  $prefix-cls: #{$namespace}-title;

  .#{$prefix-cls} {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    overflow: hidden;
    color: $base-text-color-3;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
</style>
