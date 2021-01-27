<template>
  <div class=" min-h-screen p-6 bg-gray-100 lg:justify-center">
		<div class=" -space-y-96">
			<EditInfos></EditInfos>
      <EditPassword></EditPassword>
		</div>
</div>
</template>

<script lang="ts">
import { ref, defineComponent } from 'vue'
import EditInfos from './cards/EditInfos.vue'
import EditPassword from './cards/EditPassword.vue'

export default defineComponent({
  name: 'Profile',
  components: {
    EditInfos,
    EditPassword
  },
  setup: () => {
    const count = ref(0)
    return { count }
  },

})
</script>

<style scoped>
a {
  color: #42b983;
}
</style>