<template>
  <div class=" min-h-screen p-6 bg-gray-100 lg:justify-center">
		<div class="md:-space-y-96 sm:-space-y-48">
      <!-- EDIT PROFILE CARDS -->
			<EditInfos></EditInfos>
      <EditPassword></EditPassword>
      <!-- SERVICES CARDS GRID-->
      <div class="flex flex-wrap -mx-3 overflow-shown ">
        <!-- TWITTER CARD -->
        <div class="my-3 w-full overflow-hidden -mt-16">
          <div class="mx-auto bg-white rounded-md shadow-lg md:w-1/4">
            <div class="p-5 bg-blue-500">
              <div class="flex flex-wrap -mx-3 overflow-hidden space-x-6 items-center ">
                <img src="../assets/servicesIcons/twitter.png">
                <span class="text-white font-semibold text-xl">Twitter</span>
              </div>
            </div>
          </div>
        </div>
        <!-- GITHUB CARD -->
        <div class="my-3 w-full overflow-hidden -mt-0.5">
          <div class="mx-auto bg-white rounded-md shadow-lg md:w-1/4">
            <div class="p-5 bg-gray-700">
              <div class="flex flex-wrap -mx-3 overflow-hidden space-x-6 items-center ">
                <img src="../assets/servicesIcons/github.png">
                <span class="text-white font-semibold text-xl">Github</span>
              </div>
            </div>
          </div>
        <!-- DISCORD CARD -->
        <div class="my-3 w-full overflow-hidden">
          <div class="mx-auto bg-white rounded-md shadow-lg md:w-1/4">
            <div class="p-5 bg-indigo-400">
              <div class="flex flex-wrap -mx-3 overflow-hidden space-x-6 items-center ">
                <img src="../assets/servicesIcons/discord.png">
                <span class="text-white font-semibold text-xl">Discord</span>
              </div>
            </div>
          </div>
        </div>
        <!-- YOUTUBE CARD -->
        <div class="my-3 w-full overflow-hidden">
          <div class="mx-auto bg-white rounded-md shadow-lg md:w-1/4">
            <div class="p-5 bg-red-600">
              <div class="flex flex-wrap -mx-3 overflow-hidden space-x-6 items-center ">
                <img src="../assets/servicesIcons/youtube.png">
                <span class="text-white font-semibold text-xl">Youtube</span>
              </div>
            </div>
          </div>
        </div>
        <!-- OUTLOOK CARD -->
        <div class="my-3 w-full overflow-hidden">
          <div class="mx-auto bg-white rounded-md shadow-lg md:w-1/4">
            <div class="p-5 bg-blue-700">
              <div class="flex flex-wrap -mx-3 overflow-hidden space-x-6 items-center ">
                <img src="../assets/servicesIcons/outlook.png">
                <span class="text-white font-semibold text-xl">Outlook</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      </div>
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