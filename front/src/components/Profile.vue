<template>
	<div class="flex items-center min-h-screen p-4 bg-gray-100 lg:justify-center">
		<div class="container mx-auto">
			<span>PROFILE PAGE</span>
		</div>
</div>
</template>

<script lang="ts">
import { ref, defineComponent } from 'vue'

export default defineComponent({
  name: 'Profile',
  setup: () => {
    const count = ref(0)
    return { count }
  },
  mounted() {
      console.log('WELCOME TO PROFILE')
  }
})
</script>

<style scoped>
a {
  color: #42b983;
}
</style>