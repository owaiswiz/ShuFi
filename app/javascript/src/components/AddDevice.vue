<template>
  <div>
    <div class="font-heading text-2xl text-indigo-light py-4 mb-4">Add Device</div>
    <div class="flex justify-between">
      <input v-model="name" class="primary-input flex-grow px-4 py-2 my-4 mr-2 block w-full text-sm" type="text" placeholder="Device Name">
      <input v-model="mac" class="primary-input flex-grow px-4 py-2 my-4 ml-2 block w-full text-sm" type="text" placeholder="Mac Address">
    </div>
    <div class="w-full text-center">
      <button @click.prevent="add()" class="my-2 p-3 rounded text-base text-white bg-indigo-light hover:bg-indigo focus:outline-none focus:shadow-outline">
        Add Device
      </button>
    </div>
  </div> 
</template>

<script>
export default {
  data() {
    return {
      name: '',
      mac: '',
    }
  },
  methods: {
    add() {
      console.log('added', this.name)
    },
  },
}
</script>