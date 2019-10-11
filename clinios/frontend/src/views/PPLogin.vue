<template>
  <v-layout class="login-layout"> <!-- :style="{backgroundImage: 'url(' + background + ')'}"> -->
      <v-content>
      <v-container class="fill-height" fluid>
        <v-row align="center" justify="center">
          <v-col cols="11" sm="9" md="7" lg="5">
            <v-card class="elevation-1 login-form">
              <v-card-title>Patient Login</v-card-title>
              <v-card-text>
                <v-form ref="loginForm">
                    <div class="text-center">
                        <v-avatar size="100">
                            <img :src="require('../assets/images/login.png')"/>
                        </v-avatar>
                    </div>
                  <v-text-field
                    label="Email..."
                    name="email"
                    prepend-icon="email"
                    v-model.trim="user.email"
                    :Xrules="[v => !!v || 'Email is required', v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{,3})+$/.test(v) || 'E-mail must be valid']"
                    type="text"
                    autofocus
                  ></v-text-field>
                  <v-text-field
                    id="password"
                    label="Password..."
                    name="password"
                    prepend-icon="lock"
                    v-model.trim="user.password"
                    :rules="[v => !!v || 'Password is required']"
                    type="password"
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions class="pr-3 pb-3">
                <v-btn text small color="grey" :to="{name: 'patient-verify'}" active-class="no-active">Forgot Password?</v-btn>
                <div class="flex-grow-1"></div>
                <v-btn color="primary" @click="loginHandle">Login</v-btn>
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
              email: "",
              password: ""
          },
          background: require('../assets/images/background.jpg')
      }
  },
  mounted() {
    window.addEventListener('keyup', this.enterHandle)
  },
  destroyed() {
    window.removeEventListener('keyup', this.enterHandle)
  },
  created() {
    this.user.email = "test@test.com";
    this.user.password = "123";
    if (this.$refs.loginForm) this.$refs.loginForm.reset();
  },
  methods: {
    enterHandle(e) {
      if (e.code == 'Enter') {
        this.loginHandle();
      }
    },
    loginHandle() {
      if (this.$refs.loginForm.validate()) {
        let vm = this;
        vm.$http.post('/patients/login', vm.user).then(res => {
            if (res.data.error) {
                vm.$toast.error({
                    title: "Warning.",
                    message: res.data.error
                })
            } else {
                res.data.user.permission = 1;
                    vm.$store.commit("SET_USERDATA", res.data);
                    setTimeout(() => {
                        vm.$router.push({name: "patient-home"})
                    }, 100);
                }
        }, err => {
            vm.$toast.error({
                title: "Warning.",
                message: 'Server is not running'
            })
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