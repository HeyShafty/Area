<template>
  <div class="flex items-center min-h-screen p-4 bg-gray-100 lg:justify-center">
    <div class="container mx-auto">
    <!-- AREA LOGO -->
      <img class="mx-auto h-60 w-auto mb-5 -mt-20" src="../assets/AREALOGO.png">
    <!-- CARD -->
      <div
        class="mx-auto overflow-hidden bg-white rounded-md shadow-lg max-w-md"
      >
        <div class="p-5 md:flex-1">
          <h3 class="my-4 text-2xl font-semibold text-gray-700">Sign-In to your account</h3>
          <form action="#" class="flex flex-col space-y-5">
            <div class="flex flex-col space-y-1">
              <div class="flex items-center justify-between">
                <label for="password" class="text-sm font-semibold text-gray-500">Email</label>
              </div>
              <input
                type="email"
                id="email"
                autofocus
                class="px-4 py-2 transition duration-300 border border-gray-300 rounded focus:border-transparent focus:outline-none focus:ring-4 focus:ring-blue-200"
              />
            </div>
            <div class="flex flex-col space-y-1">
              <div class="flex items-center justify-between">
                <label for="password" class="text-sm font-semibold text-gray-500">Password</label>
              </div>
              <input
                type="password"
                id="password"
                class="px-4 py-2 transition duration-300 border border-gray-300 rounded focus:border-transparent focus:outline-none focus:ring-4 focus:ring-blue-200"
              />
            </div>
            <div>
              <button
                type="submit"
                class="w-full px-4 py-2 text-lg font-semibold text-white transition-colors duration-300 bg-blue-500 rounded-md shadow hover:bg-blue-600 focus:outline-none focus:ring-blue-200 focus:ring-4"
              >
                Sign-In
              </button>
            </div>
            <div class="flex flex-col space-y-5">
              <span class="flex items-center justify-center space-x-2">
                <span class="h-px bg-gray-400 w-14"></span>
                <span class="font-normal text-gray-500">or sign-in with</span>
                <span class="h-px bg-gray-400 w-14"></span>
              </span>
              <div class="flex flex-col space-y-4">
                <a
                  href="#"
                  class="flex items-center justify-center px-4 py-2 space-x-2 transition-colors duration-300 border border-blue-500 rounded-md group hover:bg-blue-500 focus:outline-none"
                >
                  <span>
                    <!-- OFFICE ICON -->
                    <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                      viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" width="2vh" height="2vh" xml:space="preserve">
                      <path style="fill:#4CAF50;" d="M272,240h240V16c0-8.832-7.168-16-16-16H272V240z"/>
                      <path style="fill:#F44336;" d="M240,240V0H16C7.168,0,0,7.168,0,16v224H240z"/>
                      <path style="fill:#2196F3;" d="M240,272H0v224c0,8.832,7.168,16,16,16h224V272z"/>
                      <path style="fill:#FFC107;" d="M272,272v240h224c8.832,0,16-7.168,16-16V272H272z"/>
                    </svg>
                  </span>
                  <span class="text-sm font-medium text-blue-500 group-hover:text-white">Office</span>
                </a>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from 'vue'

export default defineComponent({
  name: 'SignIn',
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
</style>