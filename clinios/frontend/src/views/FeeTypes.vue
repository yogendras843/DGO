<template>
  <v-layout class="flex-column">
    <v-custom-header/>
    <v-content>
    </v-content>
    <v-custom-footer/>
  </v-layout>
</template>

<script>
import VCustomHeader from '../components/Header'
import VCustomFooter from '../components/Footer'
export default {
  components: {
    VCustomHeader,
    VCustomFooter
  }
}
</script>
