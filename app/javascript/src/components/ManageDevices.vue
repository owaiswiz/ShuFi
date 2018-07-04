<template>
  <div>
    <div class="font-heading text-2xl text-indigo-light py-4 mb-4">Manage Devices</div>
    <div v-for="device in devices" v-bind:key="device.id" class="my-8">
      <div v-if="device.loading" class="flex justify-center px-4 py-2">
        <div class="loader h-5 w-5"></div> </div> 
      <div v-else class="flex-grow flex items-center justify-between">
        <div v-if="!device.editing" class="text-md  py-2 mx-4">{{ device.name }}</div>
        <input v-else v-model="device.mac" class="primary-input flex-grow px-4 py-2 mx-4 w-full text-sm" type="text" placeholder="Mac Address">

        <div class="flex items-baseline cursor-pointer text-sm select-none">
          <a v-show="!device.editing" class="text-green-light hover:text-green-lighter mr-4" @click.prevent="changeDeviceStatus(device, 'allow')">Allow</a>
          <a v-show="!device.editing" class="text-red-light hover:text-red-lighter mr-4" @click.prevent="changeDeviceStatus(device, 'deny')">Deny</a>
          <a v-show="!device.editing" class="text-blue-light hover:text-blue-lighter mr-4" @click.prevent="device.editing = true">Edit</a>
          <a v-show="device.editing" class="text-blue-light hover:text-blue-lighter mr-4" @click.prevent="editDeviceMac(device)">Done</a>
          <a v-show="!device.editing" class="text-red-dark hover:text-red mr-4" @click.prevent="deleteDevice(device)">Delete</a>
        </div>
      </div>
    </div>
  </div> 
</template>

<script>
export default {
  methods: {
    changeDeviceStatus(device, operation) {
      device.loading = true
      this.$http.post(`/devices/${operation}`, { id: device.id })
        .then(() => {
          console.log(`Device ${operation}ed`)
        })
        .finally(() => device.loading = false)
    },

    editDeviceMac(device) {
      device.editing = false
      device.loading = true
      this.$http.post('/devices/edit', { id: device.id, mac: device.mac })
        .then(() => {
          console.log('Device edited')
        })
        .finally(() => device.loading = false)
    },

    deleteDevice(device) {
      device.loading = true
      this.$http.post('/devices/delete', { id: device.id })
        .then(() => {
          console.log('Device deleted')
        })
        .finally(this.updateDevices)
    },

    updateDevices() {
      this.$http.get('/devices/show').then( resp => {
        this.devices = resp.body.devices.map(device => {
          return {...device, editing: false, loading: false}
        })
      }) 
    }
  },


  data() {
    return {
      devices: []
    }
  },

  created() {
    this.updateDevices()
    this.$root.$on('update-devices', this.updateDevices)
  }
}
</script>
