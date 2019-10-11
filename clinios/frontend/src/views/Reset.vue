<template>
    <v-layout class="login-layout" :style="{backgroundImage: 'url(' + background + ')'}">
      <v-content>
      <v-container class="fill-height" fluid>
        <v-row align="center" justify="center">
          <v-col cols="12" sm="8" md="4" lg="3">
            <v-card class="elevation-1 login-form">
              <v-card-text>
                <v-form ref="verifyForm">
                  <v-text-field
                    label="New Password..."
                    name="password"
                    prepend-icon="lock"
                    v-model.trim="user.password"
                    :rules="[v => !!v || 'Password is required.']"
                    type="password"
                  ></v-text-field>
                  <v-text-field
                    label="Confirm Password..."
                    name="password"
                    prepend-icon="check"
                    v-model.trim="user.confirm"
                    :rules="[v => !!v || 'Confirm Password is required.', v => v == user.password || 'Confirm password should be the password field.']"
                    type="password"
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions class="pr-3 pb-3">
                <div class="flex-grow-1"></div>
                <v-btn color="primary" @click="resetHandle">Reset</v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-content>
  </v-layout>
</template>

<script>
export default {
    data() {
        return {
            user: {
                password: "",
                confirm: "",
                verify_token: ""
            },
            //background: require('../assets/images/background.jpg')
        }
    },
    methods: {
        resetHandle() {
            this.user.verify_token = this.$route.params.id;
            this.$http.post('/users/reset', this.user).then(res => {
                if (res.data.error) {
                    this.$toast.error({
                      title: "Warning!", 
                      message: res.data.error
                    });
                } else {
                    this.$router.push({name: 'login'});
                }
            }, err => {
                this.$toast.error({
                  title: "Warning!", 
                  message: err.toString()
                })
            });
        }
    }
}
</script>

<style scoped>
    .login-layout {
        background-position: center;
        background-size: cover; 
    }
</style>