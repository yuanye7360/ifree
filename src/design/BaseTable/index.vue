<template>
  <div
    ref="tableRef"
    :class="prefixCls"
    :style="{
      maxHeight: maxHeight,
      width: width,
      overflowX: 'auto',
      overflowY: maxHeight ? 'auto' : 'hidden',
    }"
  >
    <div :class="`${prefixCls}-head`">
      <div
        :class="`${prefixCls}-tr`"
        :style="{
          width: scrollWidth > offsetWidth ? `${offsetWidth}px` : '',
        }"
      >
        <div
          v-for="(column, index) in columns"
          :key="`columns${index}`"
          :class="[
            `${prefixCls}-td`,
            index == leftIndex && `${prefixCls}-left-subline`,
            index == rightIndex && `${prefixCls}-right-subline`,
            index == leftIndex && isShowLeftLine && `${prefixCls}-left-subline-show`,
            index == leftIndex && isShowRightLine && `${prefixCls}-right-subline-show`,
          ]"
          :style="{
            ...columnStyle,
            ...setSticky(column),
            width: column.width !== 'auto' ? column.width : niceWidth || '100px',
          }"
          :x="column.x || 'start'"
          :y="column.y"
        >
          {{ column.title }}
        </div>
      </div>
    </div>
    <div ref="tableBodyRef" :class="`${prefixCls}-body`">
      <div
        v-for="(row, i) in data"
        :key="`data${i}`"
        :class="`${prefixCls}-tr`"
        :style="{
          width: scrollWidth > offsetWidth ? `${offsetWidth}px` : '',
        }"
      >
        <div
          v-for="(column, j) in columns"
          :key="`col${j}`"
          :class="[
            `${prefixCls}-td`,
            j == leftIndex && `${prefixCls}-left-subline`,
            j == rightIndex && `${prefixCls}-right-subline`,
            j == leftIndex && isShowLeftLine && `${prefixCls}-left-subline-show`,
            j == leftIndex && isShowRightLine && `${prefixCls}-right-subline-show`,
          ]"
          :style="{
            ...columnStyle,
            ...rowStyle,
            ...setSticky(column),
            width: column.width !== 'auto' ? column.width : niceWidth || '100px',
          }"
          :x="column.x || 'start'"
          :y="column.y"
        >
          <!-- 模板 -->
          <slot :name="column.field" :row="row" :column="column"></slot>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { getPrefixCls } from '@/utils';

  export default {
    name: 'BaseTable',
    props: {
      columns: {
        type: Array,
        default: () => {
          return [];
        },
      },
      width: {
        type: String,
        default: () => {
          return '';
        },
      },
      maxHeight: {
        type: String,
        default: () => {
          return '';
        },
      },

      data: {
        type: Array,
        default: () => {
          return [];
        },
      },
    },
    data() {
      return {
        niceWidth: '',
        leftIndex: -1,
        rightIndex: -1,
        isShowLeftLine: false,
        isShowRightLine: false,
      };
    },
    computed: {
      prefixCls() {
        return getPrefixCls('table');
      },
      scrollWidth() {
        return this.$refs.tableRef?.scrollWidth;
      },
      offsetWidth() {
        return this.$refs.tableRef?.offsetWidth;
      },
      columnStyle() {
        return this.column?.columnStyle || {};
      },
      rowStyle() {
        return this.row?.rowStyle || {};
      },
    },
    mounted() {
      this.setWidth();
      // 设置固定单元格的阴影
      this.setSubLine();
    },
    methods: {
      setWidth() {
        const sw = this.$refs.tableRef.scrollWidth;
        const w = this.$refs.tableRef.offsetWidth;

        if (w >= sw) {
          const autoLen = this.columns.filter((e) => e.width === 'auto').length;
          let wTotal = 0;

          this.columns
            .filter((e) => e.width !== 'auto')
            .map((e) => {
              wTotal += parseFloat(e.width);
            });
          this.niceWidth = `${(w - wTotal) / autoLen - 3}px`;
        }
      },
      setSubLine() {
        this.columns.map((e, i) => {
          if (e.sticky === 'left') {
            this.leftIndex = i;
          } else if (e.sticky === 'right' && this.rightIndex === -1) {
            this.rightIndex = i;
            if (this.$refs.tableRef.scrollWidth !== this.$refs.tableRef.offsetWidth) {
              this.isShowRightLine = true;
            }
          }
        });
      },
      setShowLine(e) {
        if (e.target.scrollWidth !== e.target.offsetWidth) {
          this.isShowLeftLine = e.target.scrollLeft >= 5;
          this.isShowRightLine =
            e.target.scrollLeft <= e.target.scrollWidth - e.target.offsetWidth - 5;
        }
      },
      setSticky(column) {
        if (column.sticky === 'left') {
          return {
            position: 'sticky',
            left: column.offsetX || '0px',
            zIndex: 1,
          };
        }

        if (column.sticky === 'right') {
          return {
            position: 'sticky',
            right: column.offsetX || '0px',
            zIndex: 1,
          };
        }

        return {};
      },
    },
  };
</script>

<style lang="scss">
  $prefix-cls: #{$namespace}-table;

  .#{$prefix-cls} {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: auto;
    border: 1.5px #f5f5f5 solid;
    border-radius: 4px;
    font-size: 14px;

    &-head {
      display: flex;
      position: sticky;
      z-index: 9;
      top: 0;
      align-items: center;

      .#{$prefix-cls}-td {
        background-color: $base-bgcolor-1;
        color: $base-text-color-3;
        font-weight: 600;
        white-space: nowrap;
      }

      .#{$prefix-cls}-tr:last-child {
        .#{$prefix-cls}-td {
          border-bottom: 1.5px #f5f5f5 solid;
        }
      }
    }

    &-body {
      width: 100%;
      height: auto;

      .#{$prefix-cls}-td {
        color: $base-text-color-5;
      }
    }

    &-tr {
      display: flex;
      width: 100%;

      &:last-child {
        .#{$prefix-cls}-td {
          border-bottom: 0 #f5f5f5 solid;
        }
      }

      &:hover {
        .#{$prefix-cls}-td {
          background-color: $base-bgcolor-1;
        }
      }
    }

    &-td {
      display: inline-flex;
      position: relative;
      box-sizing: border-box;
      flex-shrink: 0;
      align-items: center;
      justify-content: flex-start;
      padding: 14px 18px;
      border-bottom: 1.5px #f5f5f5 solid;
      background-color: $base-bgcolor-0;
      text-align: left;
    }

    &-left-subline::after {
      content: '';
      position: absolute;
      top: -1px;
      right: -12px;
      width: 12px;
      height: calc(100% + 2px);
      transition: all 0.25s ease;
      opacity: 0;
      background: linear-gradient(
        to right,
        rgb(0 0 0 / 8%),
        rgb(0 0 0 / 3%),
        rgb(0 0 0 / 1%),
        rgb(0 0 0 / 0%)
      );
    }

    &-right-subline::after {
      content: '';
      position: absolute;
      top: -1px;
      left: -12px;
      width: 12px;
      height: calc(100% + 2px);
      transition: all 0.25s ease;
      opacity: 0;
      background: linear-gradient(
        to left,
        rgb(0 0 0 / 8%),
        rgb(0 0 0 / 3%),
        rgb(0 0 0 / 1%),
        rgb(0 0 0 / 0%)
      );
    }

    &-left-subline-show::after,
    &-right-subline-show::after {
      opacity: 1;
    }

    &::-webkit-scrollbar {
      width: 6px;
      height: 6px;
      background-color: $base-bgcolor-3;
    }

    &::-webkit-scrollbar-thumb:hover {
      background-color: rgb(126 126 126);
    }

    &::-webkit-scrollbar-thumb {
      border-radius: 5px;
      opacity: 0;
      background-color: $base-bgcolor-5;
    }
  }
</style>
