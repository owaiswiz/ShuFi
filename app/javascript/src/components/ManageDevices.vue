<template>
  <div>
    <div class="font-heading text-2xl text-indigo-light py-4 mb-4">Manage Devices</div>
    <div v-for="device in devices" v-bind:key="device.id" class="my-8">
      <div v-if="device.loading" class="flex justify-center px-4 py-2">
        <div class="loader h-5 w-5"></div>
      </div>

      <div v-else class="flex-grow flex items-center justify-between">
        <div v-if="!device.editing" class="text-md  py-2 mx-4">{{ device.name }}</div>
        <input v-else v-model="device.mac" class="flex-grow px-4 py-2 mx-4 w-full rounded-full text-grey-darker text-sm border-2 border-indigo focus:outline-none"
          type="text" placeholder="Mac Address">

        <div class="flex items-baseline cursor-pointer text-sm select-none">
          <a v-show="!device.editing" class="text-green-light hover:text-green-lighter mr-4" @click.prevent="allow(device)">Allow</a>
          <a v-show="!device.editing" class="text-red-light hover:text-red-lighter mr-4" @click.prevent="deny(device)">Deny</a>
          <a v-if="device.editing" class="text-blue-light hover:text-blue-lighter mr-4" @click.prevent="device.editing = false">Done</a>
          <a v-else class="text-blue-light hover:text-blue-lighter mr-4" @click.prevent="device.editing = true">Edit</a>
        </div>
      </div>
    </div>
  </div> 
</template>

<script>
export default {
  props: ['devices'],

  methods: {
    allow(device) {
      console.log(device)
      device.loading = true
      setTimeout(() => device.loading = false, 1000)
    },
    deny(device) {
      device.loading = true
      setTimeout(() => device.loading = false, 2000)
    },
    edit(device) {
      device.editing = !device.editing
    },
  },
}
</script>