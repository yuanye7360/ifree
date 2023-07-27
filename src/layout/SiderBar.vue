<template>
  <div :class="`${prefixCls}-wrapper btf-scrollbar`">
    <div v-for="(list, i) in group" :key="`group${i}`" :class="prefixCls">
      <div v-if="list.title" :class="`${prefixCls}--title`">
        <span> {{ list.title }}</span>
      </div>
      <div
        v-for="(item, j) in list.items"
        :key="`siderbar${j}`"
        :class="[`${prefixCls}--item`, currentpath === item.path && `${prefixCls}--item__active`]"
        @click="toPath(item)"
      >
        <span v-if="item.name" :class="`${prefixCls}--ename`"> {{ item.name }} </span>
        <span :class="`${prefixCls}--cname`"> {{ item.cname }}</span>

        <span
          v-if="item.label"
          :class="[`${prefixCls}--label`, item.type && `${prefixCls}--label__${item.type}`]"
        >
          {{ item.label }}
        </span>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
  import { getPrefixCls } from '@/utils';

  export default {
    name: 'SiderBar',
    props: {
      group: {
        type: Array,
        default: () => [],
      },
    },
    computed: {
      prefixCls() {
        return getPrefixCls('siderbar');
      },
      currentpath() {
        return this.$route.path;
      },
    },
    methods: {
      toPath(item) {
        if (this.currentpath !== item.path) {
          this.$router.push(item.path);
        }
      },
    },
  };
</script>

<style lang="scss" scoped>
  $prefix-cls: #{$namespace}-siderbar;

  .#{$prefix-cls}-wrapper {
    width: 260px;
    height: 100%;
    min-height: 100vh;
    overflow-y: scroll;
    border-right: $base-border-1;
    user-select: none;
  }

  .#{$prefix-cls} {
    margin-top: 20px;
    padding: 5px 0 5px 20px;
    white-space: nowrap;

    &--title {
      height: 20px;
      margin: 20px 0 15px;
      padding: 0 20px;
      overflow: hidden;
      color: $base-text-color-9;
      font-size: 14px;
      font-weight: 400;

      span {
        display: inline-block;
      }
    }

    &--item {
      display: flex;
      position: relative;
      box-sizing: border-box;
      align-items: center;
      width: calc(100% - 20px);
      height: 36px;
      padding-left: 20px;
      border-radius: 4px;
      color: $base-text-color-6;
      font-size: 14px;
      line-height: 36px;
      list-style: none;
      cursor: pointer;

      &:hover {
        background: $base-bgcolor-2;
        color: $base-text-color-0;
      }

      &__active {
        background: $base-primary-color;
        color: $base-white-text-color;

        &:hover {
          background: $base-primary-color;
          color: $base-white-text-color;
        }
      }
    }

    &--label {
      margin-left: 10px;
      padding: 0 6px;
      border-radius: 4px;
      background-color: $base-info-color-light;
      color: $base-info-color-dark;
      font-size: 12px;
      line-height: 20px;

      &__success {
        background-color: $base-success-color-light;
        color: $base-success-color-dark;
      }

      &__info {
        background-color: $base-info-color-light;
        color: $base-info-color-dark;
      }

      &__warning {
        background-color: $base-warning-color-light;
        color: $base-warning-color-dark;
      }

      &__error {
        background-color: $base-error-color-light;
        color: $base-error-color-dark;
      }
    }

    &:last-child {
      padding-bottom: 150px;
    }
  }
</style>
