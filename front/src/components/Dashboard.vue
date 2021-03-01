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
                <p class="mt-2 text-sm">Welcome to your dashboard.</p>
                <p class="mt-2 text-sm">You can manage your ChadArea Automations here.</p>
              </div>
              <button type="button" v-on:click="openModal" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-green-600 text-base font-medium text-white hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 sm:ml-3 sm:text-sm">
                Add a new Automation!
              </button>
              <!-- ALL AREAS HERE -->
              <div class="flex flex-col">
                <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                  <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                    <div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
                      <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                          <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                              Action
                            </th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                              Reaction
                            </th>
                            <th scope="col" class="relative px-6 py-3">
                              <span class="sr-only">Edit</span>
                            </th>
                            <th scope="col" class="relative px-6 py-3">
                              <span class="sr-only">Delete</span>
                            </th>
                          </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                          <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                              <div class="ml-4">
                                <div class="text-sm font-medium text-gray-900">
                                  SERVICE
                                </div>
                                <div class="text-sm text-gray-500">
                                  PARAMLIST[0] DESCRIPTION
                                </div>
                              </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                              <div class="text-sm text-gray-900">
                                SERVICE
                              </div>
                              <div class="text-sm text-gray-500">
                                PARAMLIST[0] DESCRIPTION
                              </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                              <button v-on:click="openEdit" class="text-green-600 hover:text-green-900">Edit</button>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                              <a href="#" class="text-red-600 hover:text-red-900">Delete</a>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              <!-- MODAL HERE -->
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
                          <div class="">
                            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                              <div class="mt-2 space-y-4">
                                <template v-if="editMode">
                                  <h3 class="text-xl leading-6 font-medium text-gray-900" id="modal-headline">
                                    Edit an Automation :
                                  </h3>
                                </template>
                                <template v-else>
                                  <h3 class="text-xl leading-6 font-medium text-gray-900" id="modal-headline">
                                    Add an Automation :
                                  </h3>
                                </template>
                                <span
                                  v-if="error"
                                  class="text-sm font-semibold text-red-500"
                                  >{{ errorMsg }}</span
                                >
                                <!-- Name Input -->
                                <!-- <div class="relative text-gray-600">
                                  <input v-model="name" placeholder="Automation Name" class="bg-white h-10 px-5 pr-10 rounded-full border-2 text-sm focus:outline-none hover:border-gray-400 w-full">
                                </div> -->
                                <!-- Action Service -->
                                <h3 class="text-md leading-6 font-medium text-gray-600" id="modal-headline"> Action </h3>
                                <div class="relative text-gray-600">
                                  <svg class="w-2 h-2 absolute top-0 right-0 m-4 pointer-events-none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 232"><path d="M206 171.144L42.678 7.822c-9.763-9.763-25.592-9.763-35.355 0-9.763 9.764-9.763 25.592 0 35.355l181 181c4.88 4.882 11.279 7.323 17.677 7.323s12.796-2.441 17.678-7.322l181-181c9.763-9.764 9.763-25.592 0-35.355-9.763-9.763-25.592-9.763-35.355 0L206 171.144z" fill="#648299" fill-rule="nonzero"/></svg>
                                  <select v-model="actionServiceString" class="border-2 rounded-full text-gray-600 h-10 pl-5 pr-10 bg-white hover:border-gray-400 focus:outline-none appearance-none w-full">
                                    <option disabled selected>Choose a service</option>
                                    <template v-for="aService in availableActionServices">
                                      <option> {{ aService }} </option>
                                    </template>
                                  </select>
                                </div>
                                <!-- Action Action -->
                                <template v-if="action != undefined">
                                  <div class="relative text-gray-600">
                                    <svg class="w-2 h-2 absolute top-0 right-0 m-4 pointer-events-none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 232"><path d="M206 171.144L42.678 7.822c-9.763-9.763-25.592-9.763-35.355 0-9.763 9.764-9.763 25.592 0 35.355l181 181c4.88 4.882 11.279 7.323 17.677 7.323s12.796-2.441 17.678-7.322l181-181c9.763-9.764 9.763-25.592 0-35.355-9.763-9.763-25.592-9.763-35.355 0L206 171.144z" fill="#648299" fill-rule="nonzero"/></svg>
                                    <select v-model="actionParamsString" class="border-2 rounded-full text-gray-600 h-10 pl-5 pr-10 bg-white hover:border-gray-400 focus:outline-none appearance-none w-full">
                                      <option disabled selected>Choose an action</option>
                                      <template v-for="aParam in action.params">
                                        <option> {{ aParam.description }} </option>
                                      </template>
                                    </select>
                                  </div>
                                </template>
                                <template v-if="actionParams != undefined">
                                  <template v-for="aParam in actionParams">
                                    <template v-if="aParam.type != 'None'">
                                      <div class="relative text-gray-600">
                                        <input v-model="aParam.value" :placeholder="aParam.placeholder" class="bg-white h-10 px-5 pr-10 rounded-full border-2 text-sm focus:outline-none hover:border-gray-400 w-full">
                                      </div>
                                    </template>
                                  </template>
                                </template>
                                <!-- Reaction Service -->
                                <h3 class="text-md leading-6 font-medium text-gray-600" id="modal-headline"> Reaction </h3>
                                <div class="relative text-gray-600">
                                  <svg class="w-2 h-2 absolute top-0 right-0 m-4 pointer-events-none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 232"><path d="M206 171.144L42.678 7.822c-9.763-9.763-25.592-9.763-35.355 0-9.763 9.764-9.763 25.592 0 35.355l181 181c4.88 4.882 11.279 7.323 17.677 7.323s12.796-2.441 17.678-7.322l181-181c9.763-9.764 9.763-25.592 0-35.355-9.763-9.763-25.592-9.763-35.355 0L206 171.144z" fill="#648299" fill-rule="nonzero"/></svg>
                                  <select v-model="reactionServiceString" class="border-2 rounded-full text-gray-600 h-10 pl-5 pr-10 bg-white hover:border-gray-400 focus:outline-none appearance-none w-full">
                                    <option disabled selected>Choose a service</option>
                                    <template v-for="aService in availableReactionServices">
                                      <option> {{ aService }} </option>
                                    </template>
                                  </select>
                                </div>
                                <!-- Reaction Reaction -->
                                <template v-if="reaction != undefined">
                                  <div class="relative text-gray-600">
                                    <svg class="w-2 h-2 absolute top-0 right-0 m-4 pointer-events-none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 232"><path d="M206 171.144L42.678 7.822c-9.763-9.763-25.592-9.763-35.355 0-9.763 9.764-9.763 25.592 0 35.355l181 181c4.88 4.882 11.279 7.323 17.677 7.323s12.796-2.441 17.678-7.322l181-181c9.763-9.764 9.763-25.592 0-35.355-9.763-9.763-25.592-9.763-35.355 0L206 171.144z" fill="#648299" fill-rule="nonzero"/></svg>
                                    <select v-model="reactionParamsString" class="border-2 rounded-full text-gray-600 h-10 pl-5 pr-10 bg-white hover:border-gray-400 focus:outline-none appearance-none w-full">
                                      <option disabled selected>Choose a reaction</option>
                                      <template v-for="aParam in reaction.params">
                                        <option> {{ aParam.description }} </option>
                                      </template>
                                    </select>
                                  </div>
                                </template>
                                <template v-if="reactionParams != undefined">
                                  <template v-for="aParam in reactionParams">
                                    <template v-if="aParam.type != 'None'">
                                      <div class="relative text-gray-600">
                                        <input v-model="aParam.value" :placeholder="aParam.placeholder" class="bg-white h-10 px-5 pr-10 rounded-full border-2 text-sm focus:outline-none hover:border-gray-400 w-full">
                                      </div>
                                    </template>
                                  </template>
                                </template>

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

class Param {
  type: string;
  check: string;
  value: any;
  placeholder: any;

  constructor(type: string, check: string, placeholder: any) {
    this.type = type;
    this.check = check;
    this.placeholder = placeholder;
  }

  validateValue(): boolean {
    // Check the values here depending on the type and check values.
    // Return false if an error was found.
    // Return true to validate the data.
    // ADD the REGEXP HERE.
    regexpYtLink = /^(https?:\/\/)?(www\.)?youtube\.com\/(channel|user)\/[\w-]+$/;
    regexpEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    regexpMinutes = /^[0-5]?[0-9]$/;
    regexpHours = /^([0-1]?[0-9]|2[0-3])$/;
    regexpUsername = /^[A-Za-z0-9_]{1,15}$/;
    switch (check) {
    case "Username":
      if (regexpUsername.test(this.value))
        return true;
      return false;
      break;
    case "YTLink":
      if (regexpYtLink.test(this.value))
        return true;
      return false;
      break;
    default:
      return true;
      break;
    }
  }
}

class ParamList {
  description: string;
  list: Array<Param>;

  constructor(description: string) {
    this.description = description;
    this.list = new Array<Param>();
  }
}

class Selectable {
  service: string;
  params: Array<ParamList>;

  constructor(service: string) {
    this.service = service;
    this.params = new Array<ParamList>();
  }
}

class AutomationStorage {
  actions: Array<Selectable>;
  reactions: Array<Selectable>;

  lastAction(): Selectable {
    return this.actions[this.actions.length - 1];
  }

  lastActionParam(): ParamList {
    return this.lastAction().params[this.lastAction().params.length - 1];
  }

  lastReaction(): Selectable {
    return this.reactions[this.reactions.length - 1];
  }

  lastReactionParam(): ParamList {
    return this.lastReaction().params[this.lastReaction().params.length - 1];
  }

  addNewActionService(name: string) {
    this.actions.push(new Selectable(name));
  }

  addNewAction(description: string) {
    this.lastAction().params.push(new ParamList(description));
  }

  addNewActionParam(type: string, check: string, placeholder: any) {
    this.lastActionParam().list.push(new Param(type, check, placeholder));
  }

  addNewReactionService(name: string) {
    this.reactions.push(new Selectable(name));
  }

  addNewReaction(description: string) {
    this.lastReaction().params.push(new ParamList(description));
  }

  addNewReactionParam(type: string, check: string, placeholder: any) {
    this.lastReactionParam().list.push(new Param(type, check, placeholder));
  }

  constructor() {
    this.actions = new Array<Selectable>();
    this.reactions = new Array<Selectable>();
    // ---------------------------------------------------------------------------- ACTIONS
    // Twitter
    this.addNewActionService("Twitter");
    this.addNewAction("New tweet from a specific User");
    this.addNewActionParam("String", "Username", "Username (without the @)");
    this.addNewAction("New Follower");
    this.addNewActionParam("None", "None", "");
    // Outlook
    this.addNewActionService("Outlook");
    this.addNewAction("New e-mail received");
    this.addNewActionParam("None", "None", "");
    // Youtube
    this.addNewActionService("Youtube");
    this.addNewAction("New video uploaded from a specific channel");
    this.addNewActionParam("String", "Username", "Channel Username");
    this.addNewAction("New video was added to a specific playlist");
    this.addNewActionParam("String", "Playlist", "Playlist Link");
    // Github
    this.addNewActionService("Github");
    this.addNewAction("New issue from a specific repository.");
    this.addNewActionParam("String", "Username", "Github Username");
    this.addNewActionParam("String", "Repository", "Repository name");
    this.addNewAction("Issue closed in a specific repository.");
    this.addNewActionParam("String", "Username", "Github Username");
    this.addNewActionParam("String", "Repository", "Repository name");
    this.addNewAction("New Pull Request from a specific repository.");
    this.addNewActionParam("String", "Username", "Github Username");
    this.addNewActionParam("String", "Repository", "Repository name");
    this.addNewAction("New public repository from a specific User");
    this.addNewActionParam("String", "Username", "Username");
    // Timer
    this.addNewActionService("Timer");
    this.addNewAction("Execute a task every day at a specific time");
    this.addNewActionParam("Hours", "Hours", "Time");
    this.addNewActionParam("Minutes", "Minutes", "Time");
    this.addNewAction("Execute a task every hour at a specific minute");
    this.addNewActionParam("Int", "Minutes", "Minute");
    // ---------------------------------------------------------------------------- REACTIONS
    // Outlook
    this.addNewReactionService("Outlook");
    this.addNewReaction("Send an email");
    this.addNewReactionParam("String", "Email", "Email@Email.com");
    this.addNewReactionParam("String", "Message", "Your email here");
    // Twitter
    this.addNewReactionService("Twitter");
    this.addNewReaction("Post a tweet");
    this.addNewReactionParam("String", "Message", "Hello twitter!");
    // Discord
    this.addNewReactionService("Discord");
    this.addNewReaction("Send a message in a specific channel");
    this.addNewReactionParam("String", "Link", "Webhook link");
    // Github
    this.addNewReaction("Github");
    this.addNewReaction("Create a new issue in a specific Repository");
    this.addNewReactionParam("String", "Repository", "Repository name");
    this.addNewReactionParam("String", "Message", "Issue Title");
    this.addNewReactionParam("String", "Message", "Issue Content");
  }
}

class Area {
  action: Selectable;
  reaction: Selectable;

  constructor(action: Selectable, reaction: Selectable) {
    this.action = action;
    this.reaction = reaction;
  }
}

const data: AutomationStorage = new AutomationStorage();

//const actionServices: Array<string> = ["Twitter", "Outlook", "Youtube", "Github", "Timer"];
//const reactionServices: Array<string> = ["Twitter", "Outlook", "Github", "Discord"];

interface IDashboard {
  modalState: boolean;
  editMode: boolean;
  action: Selectable;
  actionParams: ParamList;
  actionParamsString: string;
  reaction: Selectable;
  reactionParams: ParamList;
  reactionParamsString: string;
  availableActionServices: Array<string>;
  availableReactionServices: Array<string>;
  actionServiceString: string;
  reactionServiceString: string;
  data: AutomationStorage;
  error: boolean;
  errorMsg: string;
  selectedArea: Area;
  allAreas: Array<Area>;
}

export default defineComponent({
  name: 'Dashboard',
  data(): IDashboard {
    return {
      modalState: false,
      editMode: false,
      action: undefined,
      actionParams: undefined,
      actionParamsString: "Choose an action",
      reaction: undefined,
      reactionParams: undefined,
      reactionParamsString: "Choose a reaction",
      availableActionServices: ["Twitter", "Outlook", "Youtube", "Github", "Timer"],
      availableReactionServices: ["Twitter", "Outlook", "Github", "Discord"],
      actionServiceString: "Choose a service",
      reactionServiceString: "Choose a service",
      data: data,
      error: false,
      errorMsg: "",
      selectedArea: undefined,
      allAreas: undefined,
    }
  },
  watch: {
    reactionServiceString: function (val) {
      this.reactionParamsString = "Choose a reaction";
      for (var i: number = 0; i < this.data.reactions.length; i++) {
        var wasSet: boolean = false;
        if (this.data.reactions[i].service == val) {
          this.reaction = this.data.reactions[i];
          wasSet = true;
        }
      }
      if (!wasSet == false && this.data.reactions.length != 0) {
        this.error = true;
        this.errorMsg = "Invalid Service Selected.";
      }
    },
    reactionParamsString: function (val) {
      for (var i: number = 0; i < this.reaction.params.length; i++) {
        var wasSet: boolean = false;
        if (this.reaction.params[i].description == val) {
          this.reactionParams = this.reaction.params[i].list;
          wasSet = true;
        }
      }
      if (!wasSet == false && this.reaction.params.length != 0) {
        this.error = true;
        this.errorMsg = "Invalid Reaction Selected.";
      }
    },
    actionServiceString: function (val) {
      this.actionParamsString = "Choose an action";
      for (var i: number = 0; i < this.data.actions.length; i++) {
        var wasSet: boolean = false;
        if (this.data.actions[i].service == val) {
          this.action = this.data.actions[i];
          wasSet = true;
        }
      }
      if (!wasSet == false && this.data.actions.length != 0) {
        this.error = true;
        this.errorMsg = "Invalid Service Selected.";
      }
    },
    actionParamsString: function (val) {
      for (var i: number = 0; i < this.action.params.length; i++) {
        var wasSet: boolean = false;
        if (this.action.params[i].description == val) {
          this.actionParams = this.action.params[i].list;
          wasSet = true;
        }
      }
      if (!wasSet == false && this.action.params.length != 0) {
        this.error = true;
        this.errorMsg = "Invalid Action Selected.";
      }
    },
  },
  methods: {
    openEdit() {
      this.editMode = true;
      this.openModal();
    },
    openModal() {
      if (this.editMode == true) {
        if (this.selectedArea == undefined || this.selectedArea == null) {
          // Something went wrong.
          // Display banner error. (NOT DONE YET)
          //return;
        } else {
          this.action = this.selectedArea.action;
          this.actionParams = this.selectedArea.action.params[0];
          this.actionParamsString = this.actionParams.description;
          this.reaction = this.selectedArea.raaction;
          this.reactionParams = this.selectedArea.reaction.params[0];
          this.reactionParamsString = this.reactionParams.description;
          this.actionServiceString = this.selectedArea.action.service;
          this.reactionServiceString = this.selectedArea.reaction.service;
        }
      } else {
        this.action = undefined;
        this.actionParams = undefined;
        this.actionParamsString = "Choose an action";
        this.reaction = undefined;
        this.reactionParams = undefined;
        this.reactionParamsString = "Choose a reaction";
        this.actionServiceString = "Choose a service";
        this.reactionServiceString = "Choose a service";
      }
      this.modalState = true;
    },
    closeModal() {
      this.modalState = false;
      this.editMode = false;
      this.error = false;
      this.errorMsg = "";
    },
    sendData() {
      // Validate ALL params here with the regexp in the Param class.
      if (this.error == true) {
        // Something went wrong. Can't validate.
        return;
      }
      if (this.editMode == true) {
        // Send the edit to an exsisting area and wait for response.
      } else {
        // Add a new area and wait for response.
      }
      closeModal();
      // Get all the existing areas here.
    }
  },
  mounted() {
    document.addEventListener("keydown", e => {
      if (e.keyCode == 27 && this.modalState) this.modalState = false;
    });
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