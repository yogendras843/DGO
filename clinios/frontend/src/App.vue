<template>
  <v-app>
   <router-view/>
  </v-app>
</template>

<script>
import Header from './components/Header'
export default {
  name: 'App',
  components: {
    VCustomHeader: Header
  },
  created() {
    document.title = `Clinios ${this.$route.name}`
  },
  watch: {
    $route(to, from) {
      document.title = `Clinios ${to.name}`
    }
  }
};
</script>
<style>
html {
  overflow: auto;
}
.toast-icon {
  top: 18px !important;
}
.v-data-table td, .v-data-table th {
  padding: 5px !important;
}
@media (min-width: 1200px){
  .container {
      max-width: 1500px !important;
  }
}
</style>