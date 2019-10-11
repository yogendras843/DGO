<template>
  <v-layout class="flex-column">
    <v-custom-header/>
    <v-content>
      <v-container>
        <p class="headline">Myself</p>
        <v-card class="border" max-width="600">
          <div style="padding-top: 20px; padding-right: 20px; padding-left: 20px;">
              <v-row>
                <v-col md="4" class="pt-0 pb-0"><p class="subtitle-1">Name:</p></v-col>
                <v-col md="8" class="pt-0 pb-0"><p class="subtitle-1">{{user.firstname + " " + user.lastname}}</p></v-col>
              </v-row>
              <v-row>
                <v-col md="4" class="pt-0 pb-0"><p class="subtitle-1">Title:</p></v-col>
                <v-col md="8" class="pt-0 pb-0"><p class="subtitle-1">{{user.title}}</p></v-col>
              </v-row>
              <v-row>
                <v-col md="4" class="pt-0 pb-0"><p class="subtitle-1">Administrator:</p></v-col>
                <v-col md="8" class="pt-0 pb-0"><p class="subtitle-1">{{user.admin == 1 ? "Yes" : "No"}}</p></v-col>
              </v-row>
              <v-row>
                <v-col md="4" class="pt-0 pb-0"><p class="subtitle-1">Email:</p></v-col>
                <v-col md="8" class="pt-0 pb-0"><p class="subtitle-1">{{user.email}}</p></v-col>
              </v-row>
              <v-row>
                <v-col md="4" class="pt-0 pb-0"><p class="subtitle-1">Phone:</p></v-col>
                <v-col md="8" class="pt-0 pb-0">
                  <v-text-field v-model.trim="user.phone" autofocus>
                  </v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col md="4" class="pt-0 pb-0"><p class="subtitle-1">Password:</p></v-col>
                <v-col md="8" class="pt-0 pb-0"><v-text-field v-model.trim="password"/></v-col>
              </v-row>
              <v-row>
                <v-col md="4" class="pt-0 pb-0"><p class="subtitle-1">Created:</p></v-col>
                <v-col md="8" class="pt-0 pb-0"><p class="subtitle-1">{{dateFormat(user.created)}}</p></v-col>
              </v-row>
          </div>
          <v-card-actions class="pa-4">
            <div class="flex-grow-1"></div>
            <v-btn color="primary" @click="editSelf">Save</v-btn>
          </v-card-actions>
        </v-card>
      </v-container>
    </v-content>
    <v-custom-footer/>
  </v-layout>
</template>

<script>
import moment from 'moment';
import VCustomHeader from '../components/Header'
import VCustomFooter from '../components/Footer'
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
    VCustomHeader,
    VCustomFooter
  },
  mounted() {
    window.addEventListener('keyup', this.enterHandle)
  },
  destroyed() {
    window.removeEventListener('keyup', this.enterHandle)  
  },
  methods: {
    enterHandle(e) {
      if (e.code == 'Enter') {
        this.editSelf();
      }
    },
    dateFormat(date) {
      return moment(date).format('ll');
    },
    editSelf() {
      let params = {
        phone: this.user.phone,
        password: this.password
      }
      this.$http.post('users/self', params).then(res => {
        if (res.data.error) {
          this.$toast.error({
            title: "Warning",
            message: res.data.error
          })
        } else {
          let updatedUser = {...this.user, password: this.password}
          localStorage.setItem('user', JSON.stringify(updatedUser));
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