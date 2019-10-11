<template>
  <v-layout class="flex-column">
    <v-custom-header/>
    <v-content>
      <calendar />
    </v-content>
    <v-custom-footer/>
  </v-layout>
</template>

<script>
import VCustomHeader from '../components/Header'
import Calendar from '../views/Calendar'
import VCustomFooter from '../components/Footer'
export default {
  components: {
    VCustomHeader,
    Calendar,
    VCustomFooter
  }
}
</script>
