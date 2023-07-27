<template>
  <div>
    <base-title>{{ title }}</base-title>
    <p>
      {{ subTitle }}
    </p>
    <slot></slot>
    <base-title size="16px"> Props </base-title>
    <base-table :data="docsTable" :columns="columns" height="auto">
      <template #param="{ row }">
        {{ row.param }}
      </template>
      <template #description="{ row }">
        {{ row.description }}
      </template>
      <template #type="{ row }">
        {{ row.type }}
      </template>
      <template #default="{ row }">
        {{ row.default }}
      </template>
    </base-table>
  </div>
</template>

<script>
  const columns = [
    {
      title: '参数名',
      width: '200px',
      field: 'param',
    },
    {
      title: '描述',
      width: '320px',
      field: 'description',
    },
    {
      title: '类型',
      width: 'auto',
      field: 'type',
    },
    {
      title: '默认值',
      width: '200px',
      field: 'default',
    },
  ];

  export default {
    name: 'BaseDemoContext',
    props: {
      title: {
        type: String,
        default: '',
      },
      subTitle: {
        type: String,
        default: '',
      },
      docsTable: {
        type: Array,
        default: () => [],
      },
    },
    data() {
      return {
        columns,
      };
    },
  };
</script>
