<template>
  <v-layout class="flex-column">
    <v-custom-header/>
    <v-content>
      <v-container>
        <p class="headline">Patient</p>
        <v-alert type="error" v-if="secure">Security Violation</v-alert>
        <v-card class="border" max-width="600" v-else>
          <div style="padding-top: 20px; padding-right: 20px; padding-left: 20px;">
              <p class="title mb-4">ID: {{patient.id}}</p>
              <v-row>
                <v-col>
                  <v-text-field v-model.trim="cur_patient.firstname" label="First Name" autofocus></v-text-field>
                </v-col>
                <v-col>
                  <v-text-field v-model.trim="cur_patient.lastname" label="Last Name"></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col>
                  <v-text-field v-model.trim="cur_patient.address" label="Address"></v-text-field>           
                </v-col>
                <v-col>
                  <v-text-field v-model.trim="cur_patient.city" label="City"></v-text-field>
                </v-col>
              </v-row>
              <v-text-field v-model.trim="cur_patient.state" label="State"></v-text-field>
              <v-text-field v-model.trim="cur_patient.country" label="Country"></v-text-field>
              <v-text-field v-model.trim="cur_patient.phone" label="Phone"></v-text-field>
          </div>
          <v-card-actions class="pa-4">
            <div class="flex-grow-1"></div>
            <v-btn color="primary" @click="editPatient">Save</v-btn>
          </v-card-actions>
        </v-card>
      </v-container>
    </v-content>
    <v-custom-footer/>
  </v-layout>
</template>

<script>
import VCustomHeader from '../components/Header'
import VCustomFooter from '../components/Footer'
export default {
  data() {
    return {
      secure: false,
      cur_patient: {}
    }
  },
  computed: {
      patient() {
        this.cur_patient = this.$store.state.lastSeenPatient
        return this.$store.state.lastSeenPatient;
      }
  },
  mounted() {
    window.addEventListener('keyup', this.enterHandle)
  },
  destroyed() {
    window.removeEventListener('keyup', this.enterHandle);
  },
  components: {
    VCustomHeader,
    VCustomFooter
  },
  created() {
    this.getPatient();
  },
  watch: {
    $route(to, from) {
      this.getPatient();
    }
  },
  methods: {
    enterHandle(e) {
      if (e.code == 'Enter') {
        this.editPatient();
      }
    },
    getPatient() {
      this.$http.get(`/patients/${this.$route.params.id}`).then(res => {
        if (res.data.error) {
          this.$toast.error({
            title: "Warning", 
            message: res.data.error
          });
        } else {
          if (res.data.patient.client_id !== this.$store.state.user.client_id) {
            this.secure = true;
          } else {
            this.secure = false;
            this.$store.commit("SET_LASTSEENPATIENT", res.data.patient);
            let params = {
              client_id: this.$store.state.user.client_id,
              user_id: this.$store.state.user.id,
              patient_id: res.data.patient.id,
              page: this.$route.name
            }
            this.$http.post('patients/user-log', params);
          }
        }
      }, err => {
        this.$toast.error({
          title: 'Warning', 
          message: err.toString()
        });
      })
    },
    editPatient() {
      this.$http.post(`/patients/${this.$route.params.id}`, this.cur_patient).then(res => {
        if (res.data.error) {
          this.$toast.error({
            title: "Warning",
            message: res.data.error
          })
        } else {
          this.$toast.success({
            title: "Success",
            message: "Your information was updated."
          });
        }
      }, err => {
        this.$toast.error({
          title: "Warning",
          message: err
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