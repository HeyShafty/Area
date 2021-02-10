<template>
  <div class="flex items-center min-h-screen p-4 bg-gray-100 lg:justify-center">
    <div
      class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-3 gap-4"
    >
      <!-- NATHAN -->
      <div
        class="flex flex-col items-center justify-center bg-white p-4 shadow rounded-lg h-80 w-80"
      >
        <div
          class="inline-flex shadow-lg border border-gray-200 rounded-full overflow-hidden h-40 w-40"
        >
          <img
            src="../assets/team/watermelon.png"
            alt=""
            class="h-full w-full"
          />
        </div>
        <h2 class="mt-4 font-bold text-xl">Nathan LECORCHET</h2>
        <h6 class="mt-2 text-sm font-medium">Back Developper</h6>
      </div>
      <!-- GHASSANE -->
      <div
        class="flex flex-col items-center justify-center bg-white p-4 shadow rounded-lg h-80 w-80"
      >
        <h3 class="absolute text-2xl font-semibold text-gray-700 top-24">Our Team</h3>
        <div
          class="inline-flex shadow-lg border border-gray-200 rounded-full overflow-hidden h-40 w-40"
        >
          <img src="../assets/team/bubz.png" alt="" class="h-full w-full" />
        </div>
        <h2 class="mt-4 font-bold text-xl">Ghassane SEBAÏ</h2>
        <h6 class="mt-2 text-sm font-medium">Web developper & Designer</h6>
      </div>
      <!-- KILIO -->
      <div
        class="flex flex-col items-center justify-center bg-white p-4 shadow rounded-lg h-80 w-80"
      >
        <div
          class="inline-flex shadow-lg border border-gray-200 rounded-full overflow-hidden h-40 w-40"
        >
          <img src="../assets/team/sock.png" alt="" class="h-full w-full" />
        </div>
        <h2 class="mt-4 font-bold text-xl">Kylian BALAN</h2>
        <h6 class="mt-2 text-sm font-medium">Mobile developper</h6>
      </div>
      <!-- RODO -->
      <div
        class="flex flex-col items-center justify-center bg-white p-4 shadow rounded-lg h-80 w-80"
      >
        <div
          class="inline-flex shadow-lg border border-gray-200 rounded-full overflow-hidden h-40 w-40"
        >
          <img src="../assets/team/muscle.png" alt="" class="h-full w-full" />
        </div>
        <h2 class="mt-4 font-bold text-xl">Rodolphe DUPUIS</h2>
        <h6 class="mt-2 text-sm font-medium">Back Developper</h6>
      </div>
      <!-- ELIOTT -->
      <div
        class="flex flex-col items-center justify-center bg-white p-4 shadow rounded-lg h-80 w-80"
      >
        <div
          class="inline-flex shadow-lg border border-gray-200 rounded-full overflow-hidden h-40 w-40"
        >
          <img src="../assets/team/ouaf.png" alt="" class="h-full w-full" />
        </div>
        <h2 class="mt-4 font-bold text-xl">Eliott PALUEAU</h2>
        <h6 class="mt-2 text-sm font-medium">Web developper & Doc redactor</h6>
      </div>
      <!-- BEAR -->
      <div
        class="flex flex-col items-center justify-center bg-white p-4 shadow rounded-lg h-80 w-80"
      >
        <div
          class="inline-flex shadow-lg border border-gray-200 rounded-full overflow-hidden h-40 w-40"
        >
          <img src="../assets/team/bear.png" alt="" class="h-full w-full" />
        </div>
        <h2 class="mt-4 font-bold text-xl">CHAD BEAR</h2>
        <h6 class="mt-2 text-sm font-medium">Mascott</h6>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";

export default defineComponent({
  name: "About",
  setup: () => {
    const count = ref(0);
    return { count };
  },
});
</script>

<style scoped>
a {
  color: #42b983;
}
</style>