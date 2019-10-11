<template>
  <v-layout class="login-layout"> <!-- :style="{backgroundImage: 'url(' + background + ')'}"> -->
      <v-content>
      <v-container class="fill-height" fluid>
        <v-row align="center" justify="center">
          <v-col cols="11" sm="9" md="7" lg="4">
            <v-card class="elevation-1 login-form">
              <v-card-title>Patient Reset Password</v-card-title>
              <v-card-text>
                <v-form ref="verifyForm">
                    <div class="text-center">
                        <v-avatar size="100">
                            <img :src="require('../assets/images/login.png')"/>
                        </v-avatar>
                    </div>
                  <v-text-field
                    label="Email..."
                    name="email"
                    prepend-icon="email"
                    v-model.trim="email"
                    :rules="emailRules"
                    type="text"
                    autofocus
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions class="pr-3 pb-3">
                <v-btn text small color="grey" :to="{name: 'patient-login'}" active-class="no-active">Back</v-btn>
                <div class="flex-grow-1"></div>
                <v-btn color="primary" @click="verifyHandle">Send</v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-content>
    <v-dialog v-model="dialog" persistent max-width="400">
      <v-card>
        <v-card-title class="headline">Successfully</v-card-title>
        <v-card-text>An email was just sent. Please check your email inbox.</v-card-text>
        <v-card-actions>
          <div class="flex-grow-1"></div>
          <!--<v-btn color="error" text @click="dialog = false">Disagree</v-btn>-->
          <v-btn color="green" text @click="dialog = false">Ok</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
    data() {
        return {
            dialog: false,
            email: "",
            emailRules: [
                v => !!v || 'E-mail is required',
                //v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
            ],
            //background: require('../assets/images/background.jpg')
        }
    },
    methods: {
        verifyHandle() {
            if(this.$refs.verifyForm.validate()) {
                this.$http.post('/patients/verify', { email: this.email}).then(res => {
                    if (res.data.error) {
                        this.$toast.error({
                          title: "Warning.", 
                          message: res.data.error
                        })
                    } else {
                        this.dialog = true
                    }
                }, err => {
                    console.log(err)
                })
            }
        }
    }
}
</script>

<style scoped>
    .login-layout {
        background-position: center;
        background-size: cover; 
    }
    .theme--light.no-active:hover::before, .theme--light.no-active::before {
        opacity: 0;
    }
</style>