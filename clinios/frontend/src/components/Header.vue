<template>
    <v-app-bar app color="primary" dark>
        <v-btn text transparent height="64" tile :to="{name: 'home'}" active-class="no-active">
            <v-toolbar-title class="headline text-uppercase">
                <span>CLINIOS</span>
            </v-toolbar-title>
        </v-btn>
        <v-btn text height="64" tile :to="{name: 'home'}" exact>
            <span>Home</span>
        </v-btn>
        <v-btn text height="64" tile :to="{name: 'workflow'}" exact>
            <span>Workflow</span>
        </v-btn>
        <v-btn text height="64" tile :to="{name: 'patients'}" exact>
            <span>Patients</span>
        </v-btn>
        <v-btn text height="64" tile :to="{name: 'users'}" exact>
            <span>Users</span>
        </v-btn>
        <v-btn text height="64" tile :to="{name: 'reports'}" exact>
            <span>Reports</span>
        </v-btn>
        <v-btn text height="64" tile :to="{name: 'myself'}" exact>
            <span>Myself</span>
        </v-btn>
        <v-btn text height="64" tile :to="{name: 'fee-types'}" exact>
            <span>Setup</span>
        </v-btn>
        <v-btn text height="64" tile @click="logoutHandle">
            <span>Logout</span>
        </v-btn>
        <v-spacer></v-spacer>

        <v-tooltip left>
            <template v-slot:activator="{ Xon }">
                <v-btn v-if="patient" text height="64" tile class="body-2 text-capitalize" :to="{name: 'patient', params: {id: patient.id}}" v-on="on">{{patient.firstname + " " + patient.lastname}}</v-btn>
            </template>
            <span>The last patient that was viewed, click to go to this patient.</span>
        </v-tooltip>

        <p class="ma-4 body-2">{{curdate}}</p>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <div>
            <v-text-field v-model.trim="search" class="pt-0 subtitle-1" append-icon="search" label="Search" single-line hide-details>
            </v-text-field>
            <v-card style="position: absolute; width: 100%" class="mx-auto" max-width="300" tile light v-if="patients.length">
                <v-list shaped>
                <v-list-item-group v-model="item" color="primary">
                    <v-list-item
                    v-for="(item, i) in patients"
                    :key="i"
                    @click="linkToPatient(item.id)"
                    >
                    <v-list-item-content>
                        <v-list-item-title v-text="item.firstname + ' ' + item.lastname"></v-list-item-title>
                    </v-list-item-content>
                    </v-list-item>
                </v-list-item-group>
                </v-list>
            </v-card>
        </div>
    </v-app-bar>
</template>

<script>
import moment from 'moment'
export default {
    data() {
        return {
            search: "",
            item: 0,
            patients: [],
            //curdate: moment().format('llll').split(" ").splice(0, 4).join("").split(",").join(" ")
            //curdate: moment().format('ddd') + " " + moment().format('ll')
            curdate: moment().format('ddd MMM D')
        }
    },
    methods: {
        logoutHandle() {
            this.$store.commit('LOGOUT');
            //this.$router.push({name: 'index'});
            this.$router.push({name: 'login'});
        },
        filterPatients(val) {
            if (val.length >= 3) {
                this.$http.post('/patients/filter', {search: val, client_id: this.user.client_id}).then(res => {
                    this.patients = res.data.patients
                }, err => {
                    console.error(err)
                });
            } else {
                this.patients = [];
            }
        },
        linkToPatient(id) {
            if (this.$route.params.id !== undefined && this.$route.params.id == id) {
                this.search = "";
            } else {
                this.$router.push({name: 'patient', params: {id: id}});
                this.search = "";
            }
        }
    },
    watch: {
        search(val) {
            this.filterPatients(val);
        }
    },
    computed: {
        user() {
            return this.$store.state.user;
        },
        patient() {
            return this.$store.state.lastSeenPatient
        }
    }
}
</script>

<style>
  .theme--dark.no-active::before {
    opacity: 1;
    background-color: #1976d2;
  }
</style>
