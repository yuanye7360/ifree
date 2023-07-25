<template>
  <div class="block">
    <h1>
      {{ title }}
    </h1>
    <Header />
  </div>
</template>

<script lang="ts">
  import { defineComponent, ref } from 'vue';
  import { Header } from '@/components/header';

  export default defineComponent({
    name: 'Home',
    components: {
      Header,
    },
    setup() {
      const title = ref<String>('my home');

      return {
        title,
      };
    },
  });
</script>
