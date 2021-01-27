<template>
    <div class="overflow-hidden">
      <header class="root bg-white shadow">
        <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
          <h1 class="mytitle text-3xl leading-tight text-gray-900 font-light">
            Dashboard
          </h1>
        </div>
      </header>
      <main>
        <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8 text-left">
          <div class="px-4 py-6 sm:px-0">
            <div class="rounded-lg h-96 flax space-y-5">
              <div>
                <p class="mt-2 text-sm">Welcome to your dashboard (USERNAME).</p>
                <p class="mt-2 text-sm">You can manage your AreaChad Automations here.</p>
              </div>
              <template v-if="modalState">
                <div>
                  <div class="fixed z-10 inset-0 overflow-y-auto">
                    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
                      <div class="fixed inset-0 transition-opacity" aria-hidden="true">
                        <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
                      </div>
                      <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
                      <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" role="dialog" aria-modal="true" aria-labelledby="modal-headline">
                        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                          <div class="sm:flex sm:items-start">
                            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                              <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-headline">
                                Add an Automation :
                              </h3>
                              <div class="mt-2">
                                <p class="text-sm text-gray-500">
                                  MODAAAAAAAAAAaaAll
                                </p>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                          <button v-on:click="closeModal" type="button" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-green-600 text-base font-medium text-white hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 sm:ml-3 sm:w-auto sm:text-sm">
                            Add
                          </button>
                          <button v-on:click="closeModal"  type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                            Cancel
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </template>
            </div>
          </div>
        </div>
      </main>
    </div>
</template>

<script lang="ts">
import { ref, defineComponent } from 'vue'

export default defineComponent({
  name: 'Dashboard',
  data() {
    return {
      modalState: true,
      actions: {
        paramString: "",
        paramHour: "",
        paramMinute: "",
        services: [
          {
            serviceName: "twitter",
            actions: [
              {
                description: "New tweet from a specific User",
                paramDescription: "Username (without the @)",
                paramType: "String",
                paramCheck: "Username"
              },
              {
                description: "New Follower",
                paramDescription: "",
                paramType: "None",
                paramCheck: "None"
              },
            ]
          },
          {
            serviceName: "Outlook",
            actions: [
              {
                description: "New e-mail received",
                paramDescription: "",
                paramType: "None",
                paramCheck: "None"
              }
            ]
          },
          {
            serviceName: "Youtube",
            actions: [
              {
                description: "New video uploaded from a specific channel",
                paramDescription: "Channel Username",
                paramType: "String",
                paramCheck: "Username"
              },
              {
                description: "New video was added to a specific playlist",
                paramDescription: "Playlist URL",
                paramType: "String",
                paramCheck: "Link"
              }
            ]
          },
          {
            serviceName: "Github",
            actions: [
              {
                description: "New issue from a specific repository",
                paramDescription: "Repository Fullname (Username/RepositoryName)",
                paramType: "String",
                paramCheck: "Repository"
              },
              {
                description: "Issue closed in a specific repository",
                paramDescription: "Repository Fullname (Username/RepositoryName)",
                paramType: "String",
                paramCheck: "Repository"
              },
              {
                description: "New Pull Request from a specific repository",
                paramDescription: "Repository Fullname (Username/RepositoryName)",
                paramType: "String",
                paramCheck: "Repository"
              },
              {
                description: "New repository from a specific user",
                paramDescription: "Username",
                paramType: "String",
                paramCheck: "Username"
              }
            ]
          },
          {
            serviceName: "Timer",
            actions: [
              {
                description: "Execute a task every day at a specific time",
                paramDescription: "Time",
                paramType: "Hour/Minutes",
                paramCheck: "Hour/Minutes"
              },
              {
                description: "Execute a task every hour at a specific minute",
                paramDescription: "Minute",
                paramType: "Int",
                paramCheck: "Minute"
              }
            ]
          }
        ]
      }
    }
  },
  methods: {
    openModal() {
      this.modalState = true;
      this.paramString = "";
      this.paramHour = "";
      this.paramMinute = "";
    },
    closeModal() {
      this.modalState = false;
      this.paramString = "";
      this.paramHour = "";
      this.paramMinute = "";
    },
    getServices() {
      return ["Twitter", "Outlook", "Youtube", "Github", "Timer"];
      // Faudrait le recup du serveur.
    },
    getServiceActions(service) {
      for (var i = 0; i < this.actions.services.length; i++) {
        if (service == this.action.services[i].serviceName)
          return this.action.services[i].actions;
      }
      console.log("Ton code pue la merde...");
      return "";
    }
  }
})
</script>

<style scoped>
.root {
  margin-top : 65px;
}

.mytitle {
  text-align : left;
}

.spacetop {
  margin-top: 55px;
}
</style>