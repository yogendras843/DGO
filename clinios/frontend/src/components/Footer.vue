<template>
 <v-footer dark padless>
    <v-card tile class="primary white--text text-center" width="100%">
      <v-card-text class="white--text">
        <small>Copyright Clinios {{ new Date().getFullYear() }} — <!--<strong>-->User {{user.firstname + " " + user.lastname}}<!--</strong>--></small>
      </v-card-text>
    </v-card>
  </v-footer>
</template>

<script>
export default {
    computed: {
      user() {
        return this.$store.state.user;
      }
    }
}
</script>

<style>

</style>