<template>
  <v-container>
    <p class="headline">Profile</p>
    <v-card class="border" max-width="600">
      <div style="padding-top: 20px; padding-right: 20px; padding-left: 20px;">
          <v-row>
            <v-col>
              <v-text-field label="Name" v-model.trim="user.firstname + ' ' + user.lastname" :disabled="true"/>
            </v-col>
            <v-col>
              <v-text-field label="Address" v-model.trim="user.address"/>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-text-field label="City" v-model.trim="user.city"/>
            </v-col>
            <v-col>
              <v-text-field label="Status" v-model.trim="user.state"/>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-text-field label="Phone Number" v-model.trim="user.phone"/>
            </v-col>
            <v-col>
              <v-text-field label="Email" v-model.trim="user.email"/>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-text-field label="Password" v-model.trim="password"/>
            </v-col>
          </v-row>
      </div>
      <v-card-actions class="pa-4">
        <div class="flex-grow-1"></div>
        <v-btn color="primary" @click="editProfile">Edit</v-btn>
      </v-card-actions>
    </v-card>
  </v-container>
</template>
<script>
import moment from 'moment';
export default {
  data() {
    return {
      password: ""
    }
  },
  computed: {
      user() {
          return this.$store.state.user;
      }
  },
  components: {
  },
  mounted() {
    let vm = this;
    window.addEventListener('keyup',this.enterHandle)
  },
  destroyed() {
    window.removeEventListener('keyup', this.enterHandle)
  },
  methods: {
    enterHandle(e) {
      if (e.code == 'Enter') {
        this.editProfile();
      }
    },
    dateFormat(date) {
      return moment(date).format('ll');
    },
    editProfile() {
      let params = {...this.user}
      params['password'] = this.password
      this.$http.post('patients/profile', params).then(res => {
        if (res.data.error) {
          this.$toast.error({
            title: "Warning",
            message: res.data.error
          })
        } else {
          localStorage.setItem('user', JSON.stringify(this.user));
          this.$toast.success({
            title: "Success",
            message: "Your information was updated."
          });
        }
      }, err => {
        this.$toast.error({
          title: "Warning",
          message: err.toString()
        })
      })
    }
  }
}
</script>

<style scoped>
    .v-text-field {
        margin-top: 0px !important;
        padding-top: 0px !important;
    }
    .v-card__text p {
        margin-bottom: 0px !important; 
    }
</style>