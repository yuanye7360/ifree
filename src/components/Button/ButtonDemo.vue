<template>
  <base-demo-context title="Button" sub-title="按钮简介" :docs-table="docsTable">
    <base-demo-box title="普通" :code="ButtonDemo1_code">
      <button-demo1 />
    </base-demo-box>
  </base-demo-context>
</template>

<script lang="ts">
  import { ButtonDemo1, ButtonDemo1_code } from './demo';

  const docsTable = [
    {
      param: 'theme-color',
      description: '主题色',
      type: 'string',
      default: `''`,
    },
    {
      param: 'isLink',
      description: 'link',
      type: 'Boolean',
      default: 'false',
    },
  ];

  export default {
    name: 'DemoButton',
    components: {
      ButtonDemo1,
    },
    data() {
      return {
        docsTable,
        ButtonDemo1_code,
      };
    },
  };
</script>
