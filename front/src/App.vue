<template>
  <!-- Faut qu'on établisse un mioyen de définir si un utilisateur est connecté ou pas et qu'on file ça aux components -->
  <!-- Pour l'instant dans la sidebar c'est en dur -->
  <Sidebar></Sidebar>
  <router-view/>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import HelloWorld from './components/HelloWorld.vue'
import Sidebar from './components/Sidebar.vue'

export default defineComponent({
  name: 'App',
  components: {
    HelloWorld,
    Sidebar
  }
})
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>