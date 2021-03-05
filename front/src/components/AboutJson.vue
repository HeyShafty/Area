<template>
  <div>
    <!-- Hero Section -->
    <div class="relative overflow-hidden">
      <div class="root">
        <pre class="overflow-x-scroll">
          <code>
            {{ aboutString }}
          </code>
        </pre>
      </div>
      <div class="spacebottom">
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from "vue";
import { baseUri } from "../config";
import axios from "axios";

export default defineComponent({
  name: "AboutJson",
  data() {
    return {
      aboutString: "Couldn't get about.json from the server. Please try again later.",
    }
  },
  async mounted() {
    try {
        const ret = await axios.get(baseUri + "/about.json", {});
        this.aboutString = JSON.stringify(ret, null, 2);
    } catch (error) {
        console.log(error);
        if (error.response.status == 500) {
            console.log("500: Server Error");
            this.aboutString = "500: Internal Server Error";
        } else {
            this.aboutString = "Unknown error. Please refer to the logs.";
        }
    }
  }
});
</script>

<style scoped>
.spacebottom {
  margin-top: 65px;
}
.root {
  margin-top: 120px;
  text-align: left;
  border: 5px dotted #CFD1C9;
  border-radius: 27px;
  width: 75%;
  background: rgba(207,209,201,0.28);
  display: inline-block;
  padding-left: 25px;
}
</style>