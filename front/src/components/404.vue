<template>
  <div class="root">
    <img class="mx-auto max-w-sm w-auto object-fit:contain mb-10" src="../assets/euh.jpg"/>
    <h1 class="font-bold text-3xl">404</h1>
    <h5>You're not supposed to be there ...</h5>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from 'vue'

export default defineComponent({
  name: '404',
  setup: () => {
    const count = ref(0)
    return { count }
  }
})
</script>

<style scoped>
a {
  color: #42b983;
}

.root {
  padding-top : 120px;
}
</style>