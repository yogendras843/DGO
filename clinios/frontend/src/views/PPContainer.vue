
<template>
  <v-app id="inspire">
    <v-app-bar :clipped-left="$vuetify.breakpoint.lgAndUp" app color="blue darken-3" dark>
      <v-toolbar-title style="width: 300px" class="ml-0 pl-4">
        <!--<v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>-->
        <router-link class="" :to="{name: 'patient-home'}"><span class="hidden-sm-and-down home">CLINIOS</span></router-link>
      </v-toolbar-title>
    </v-app-bar>
    <div class="p_container">
      <v-navigation-drawer
        permanent
      >
        <v-list dense>
            <v-list-item tag="li" :to="{name: 'patient-home'}" exact>
              <v-list-item-action>
                <v-icon>home</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  HOME
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item tag="li" :to="{name: 'patient-profile'}" exact>
              <v-list-item-action>
                <v-icon>person</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  PROFILE
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item tag="li" @click="logoutHandle">
              <v-list-item-action>
                <v-icon>logout</v-icon>
              </v-list-item-action>
              <v-list-item-content>
                <v-list-item-title>
                  LOGOUT
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
        </v-list>
      </v-navigation-drawer>
      <v-content>
        <v-container fluid>
          <router-view></router-view>
        </v-container>
      </v-content>
    </div>
  </v-app>
</template>

<script>
  export default {
    props: {
      source: String,
    },
    data: () => ({
      dialog: false,
      drawer: null,
    }),
    methods: {
        logoutHandle() {
            this.$store.commit('LOGOUT');
            //this.$router.push({name: 'index'});
            this.$router.push({name: 'patient-login'});
        }
    }
  }
</script>

<style>
.v-navigation-drawer {
  height: 100vh !important;
}
.p_container {
  display: flex;
}
.v-navigation-drawer {
  margin-top: 60px
}
.home {
  color: white;
}
.v-navigation-drawer a, .v-toolbar a {
  text-decoration: none !important;
}

</style>