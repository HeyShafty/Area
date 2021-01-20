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
          <!-- CARD HEADER -->
          <h3 class="my-4 text-2xl font-semibold text-gray-700">Sign-In to your account</h3>
          <form action="#" class="flex flex-col space-y-5">
            <!-- EMAIL INPUT -->
            <div class="flex flex-col space-y-1">
              <div class="flex items-center justify-between">
                <label for="password" class="text-md font-semibold text-gray-500">Email</label>
              </div>
              <input
                type="text"
                v-model="email"
                autofocus
                class="px-4 py-2 transition duration-300 border border-gray-300 rounded focus:border-transparent focus:outline-none focus:ring-4 focus:ring-blue-200"
              />
              <span v-if="errorMessages.email" class="text-sm font-semibold text-red-500">{{errorMessages.email}}</span>
            </div>
            <!-- PASSWORD INPUT -->
            <div class="flex flex-col space-y-1">
              <div class="flex items-center justify-between">
                <label for="password" class="text-md font-semibold text-gray-500">Password</label>
              </div>
              <input
                type="password"
                v-model="password"
                class="px-4 py-2 transition duration-300 border border-gray-300 rounded focus:border-transparent focus:outline-none focus:ring-4 focus:ring-blue-200"
              />
              <span v-if="errorMessages.password" class="text-sm font-semibold text-red-500">{{errorMessages.password}}</span>
            </div>
            <!-- SIGNIN BUTTON -->
            <div>
              <button
                type="button"
                v-on:click="signIn"
                v-bind:disabled="checkInputs() == false"
                class="disabled:opacity-40 w-full px-4 py-2 text-lg font-semibold text-white transition-colors duration-300 bg-blue-500 rounded-md shadow hover:bg-blue-600 focus:outline-none focus:ring-blue-200 focus:ring-4"
              >
                Sign-In
              </button>
            </div>
            <!-- "OR LOGIN WITH" DIVIDER -->
            <div class="flex flex-col space-y-5">
              <span class="flex items-center justify-center space-x-2">
                <span class="h-px bg-gray-400 w-14"></span>
                <span class="font-normal text-gray-500">or sign-in with</span>
                <span class="h-px bg-gray-400 w-14"></span>
              </span>
              <!-- OFFICE LOGIN BUTTON -->
              <div class="flex flex-col space-y-4">
                <a
                  v-on:click="officeSignIn"
                  class="flex items-center cursor-pointer justify-center py-2 space-x-2 transition-colors duration-300 border border-blue-500 rounded-md group hover:bg-blue-500 focus:outline-none"
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
                  <span class="text-sm mt-1 font-medium text-blue-500 group-hover:text-white">Office</span>
                </a>
                <!-- REGISTER REDIRECT -->
                <span class="h-px"></span>
                <div class="container mx-auto space-y-0.5">
                  <h5 class="font-semibold text-gray-700">First time here?</h5>
                  <h5 v-on:click="goToSignUp" class="font-semibold text-blue-500 cursor-pointer">Create an account</h5>
                </div>
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
  },
   data() {
    return {
      email: '',
      password: '',
      errorMessages: [],
    }
  },
  watch: {
    email(value){
      this.validateEmail();
    },
    password(value){
      this.validatePassword();
    },
  },
  methods: {
    // CHECK IF EMAIL IS WELL FORMATTED
    validateEmail() {
      let regexEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if (!regexEmail.test(this.email))
        this.errorMessages['email'] = 'Invalid Email Address';
      else
        this.errorMessages['email'] = '';
    },

    // CHECK IF PASSWORD IS LONG ENOUGH
    validatePassword() {
      if (this.password.length < 6 )
        this.errorMessages['password'] = 'Too short password';
      else
        this.errorMessages['password'] = '';
    },

    // CHECK IF INPUTS ARE FILLED
    checkInputs() {
      if (!this.email || !this.password)
        return false
      if (this.errorMessages['email'] || this.errorMessages['password'])
        return false
      return true
    },

    // CALL SERVER FOR SIGN-IN
    signIn() {
      console.log(this.email + ' wants to sign-in')
      // TODO: call server for sign in and manage errors
    },

    // MANAGE SIGN-IN WITH OFFICE
    officeSignIn() {
      alert("TODO")
    },

    // NAVIGATE TO SIGN UP PAGE
    goToSignUp() {
      alert("GHASSANE ALED")
    }
  }
})
</script>

<style scoped>
a {
  color: #42b983;
}
</style>