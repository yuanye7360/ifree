<template>
  <div :class="prefixCls">
    <div :class="`${prefixCls}--title`">
      {{ title }}
    </div>
    <div :class="`${prefixCls}--body ${prefixCls}-code`">
      <div :class="`${prefixCls}-code-demo hl-pre`">
        <slot></slot>
      </div>
      <div v-show="isShowCode" v-highlight :class="`${prefixCls}-code-pre`">
        <div class="pre-box">
          <pre><code v-text="code"></code></pre>
        </div>
      </div>
      <div :class="`${prefixCls}-code-bar`" @click="isShowCode = !isShowCode">
        <div :class="`${prefixCls}-code-icon`">
          <svg
            v-if="!isShowCode"
            t="1677241070792"
            class="icon"
            viewBox="0 0 1024 1024"
            version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            p-id="3775"
            width="200"
            height="200"
          >
            <path
              d="M438.4 849.1l222.7-646.7c0.2-0.5 0.3-1.1 0.4-1.6L438.4 849.1z"
              opacity=".224"
              p-id="3776"
            />
            <path
              d="M661.2 168.7h-67.5c-3.4 0-6.5 2.2-7.6 5.4L354.7 846c-0.3 0.8-0.4 1.7-0.4 2.6 0 4.4 3.6 8 8 8h67.8c3.4 0 6.5-2.2 7.6-5.4l0.7-2.1 223.1-648.3 7.4-21.4c0.3-0.8 0.4-1.7 0.4-2.6-0.1-4.5-3.6-8.1-8.1-8.1zM954.6 502.1c-0.8-1-1.7-1.9-2.7-2.7l-219-171.3c-3.5-2.7-8.5-2.1-11.2 1.4-1.1 1.4-1.7 3.1-1.7 4.9v81.3c0 2.5 1.1 4.8 3.1 6.3l115 90-115 90c-1.9 1.5-3.1 3.8-3.1 6.3v81.3c0 4.4 3.6 8 8 8 1.8 0 3.5-0.6 4.9-1.7l219-171.3c6.9-5.4 8.2-15.5 2.7-22.5zM291.1 328.1l-219 171.3c-1 0.8-1.9 1.7-2.7 2.7-5.4 7-4.2 17 2.7 22.5l219 171.3c1.4 1.1 3.1 1.7 4.9 1.7 4.4 0 8-3.6 8-8v-81.3c0-2.5-1.1-4.8-3.1-6.3l-115-90 115-90c1.9-1.5 3.1-3.8 3.1-6.3v-81.3c0-1.8-0.6-3.5-1.7-4.9-2.7-3.5-7.7-4.1-11.2-1.4z"
              p-id="3777"
            />
          </svg>
          <svg
            v-else
            t="1677240987181"
            viewBox="0 0 1024 1024"
            version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            p-id="2744"
            width="200"
            height="200"
          >
            <path
              d="M923.04 689.226667L515.786667 281.973333a5.333333 5.333333 0 0 0-7.573334 0l-407.253333 407.253334a5.333333 5.333333 0 0 0 0 7.573333l45.226667 45.226667a5.333333 5.333333 0 0 0 7.573333 0l354.453333-354.453334a5.333333 5.333333 0 0 1 7.573334 0l354.453333 354.453334a5.333333 5.333333 0 0 0 7.573333 0l45.226667-45.226667a5.333333 5.333333 0 0 0 0-7.573333z"
              p-id="2745"
            />
          </svg>
        </div>

        {{ isShowCode ? '关闭' : '显示源码' }}
      </div>
    </div>
  </div>
</template>

<script>
  import { getPrefixCls } from '@/utils';

  export default {
    name: 'BaseDemoBox',
    props: {
      title: {
        type: String,
        default() {
          return '';
        },
      },
      tag: {
        type: String,
        default() {
          return '';
        },
      },
      code: {
        type: String,
        default() {
          return '';
        },
      },
    },
    data() {
      return {
        isShowCode: false,
      };
    },
    computed: {
      prefixCls() {
        return getPrefixCls('box');
      },
    },
  };
</script>

<style lang="scss">
  $prefix-cls: #{$namespace}-box;

  @media (width <= 767px) {
    .#{$prefix-cls}-code-demo {
      overflow-x: auto;
    }
  }

  .#{$prefix-cls} {
    margin: 50px 0;

    &--title {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
      overflow: hidden;
      color: $base-text-color-3;
      font-size: 16px;
      font-weight: 800;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    &--body {
      margin: 10px 0;
      border: $base-border-1;
      border-radius: 6px;
      background-color: $base-bgcolor-0;
    }
  }

  .#{$prefix-cls}-code {
    &-demo {
      padding: 30px;
    }

    &-pre {
      position: relative;

      .pre-box {
        margin-top: 10px;
        border-radius: 6px;
      }
    }

    &-bar {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 100%;
      height: 30px;
      transition: all 0.25s;
      border-top: $base-border-1;
      border-radius: 0 0 6px 6px;
      background-color: $base-bgcolor-0;
      color: #999;
      font-size: 14px;
      cursor: pointer;

      &:hover {
        background-color: $base-bgcolor-3;
        color: $base-text-color-3;
      }
    }

    &-icon {
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 4px;

      > svg {
        width: 20px;
        height: 20px;
        fill: #999;
      }
    }
  }
</style>
