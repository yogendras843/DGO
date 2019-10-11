<template>
    <v-layout class="flex-column">
        <v-custom-header/>
        <v-content>
            <v-container>
                <p class="headline">Patients</p>
                    <v-card class="border">
                        <v-card-title>
                            <!-- <v-text-field v-model="search" class="pt-0" append-icon="search" label="Search" single-line hide-details autofocus/>                                 -->
                            <div class="flex-grow-1">
                                 <v-text-field label="FirstName" v-model.trim="first" autofocus/>
                            </div>
                            <div class="flex-grow-1">
                                 <v-text-field label="LastName" v-model.trim="last"/>
                            </div>
                            <div class="flex-grow-1">
                                 <v-text-field label="Email" v-model.trim="email"/>
                            </div>
                            <div class="flex-grow-1">
                                 <v-text-field label="Phone" v-model.trim="phone"/>
                            </div>
                            <div class="flex-grow-1">
                                <v-btn color="primary" @click="SearchFunc">Search</v-btn>
                            </div>
                            <!-- <div class="flex-grow-1"></div>
                            <div class="flex-grow-1"></div>
                            <div class="flex-grow-1"></div>
                            <div class="flex-grow-1"></div>
                            <div class="flex-grow-1"></div> -->
                        </v-card-title>
                        <v-card-text class="mt-2">
                            <v-data-table v-model="selected" :headers="headers" :items="datas" :items-per-page="15" :search="activeSearch">
                                <template v-slot:body="{items}">
                                    <tbody>
                                        <tr v-for="(item, index) in items" :key="index" @click="choosePatient(item)">
                                            <td>{{ item.firstname}}</td>
                                            <td>{{ item.lastname }}</td>
                                            <td>{{ item.email }}</td>
                                            <td>{{ item.phone }}</td>
                                            <td>{{ item.city }}</td>
                                            <td>{{ item.state }}</td>
                                            <td>{{ dateFormat(item.created)}}</td>
                                        </tr>
                                    </tbody>
                                </template>
                            </v-data-table>
                        </v-card-text>
                    </v-card>
            </v-container>
        </v-content>
        <v-custom-footer/>
  </v-layout>
</template>

<script>
import moment from 'moment'
import VCustomHeader from '../components/Header'
import VCustomFooter from '../components/Footer'
export default {
    data() {
        return {
            first: "",
            last: "",
            email: "",
            phone: "",
            patient: {
                firstname: "",
                lastname: "",
                phone: ""
            },
            search: "",
            activeSearch: "",
            headers: [
                {
                    text: "First Name",
                    align: "left",
                    value: "firstname"
                }, {
                    text: "Last Name",
                    value: "lastname"
                }, {
                    text: "Email",
                    value: "email"
                },{
                    text: "Phone",
                    value: "phone"
                }, {
                    text: "City",
                    value: "city"
                }, {
                    text: "State",
                    value: "state"
                }, {
                    text: "Created",
                    value: "created"
                }
            ],
            datas: [],
            selected: []

        }
    },
    created() {
        //this.initTable()
    },
    computed: {
        user() {
            return this.$store.state.user;
        }
    },
    mounted() {
        window.addEventListener('keyup', this.enterHandle)
    },
    destroyed() {
        window.removeEventListener('keyup', this.enterHandle)  
    },
    methods: {
        /*
        initTable() {
            this.$http.get('/patients').then(res => {
                this.datas = res.data.patients
            }, err => {

            })
        },
        */
        enterHandle(e) {
            if (e.code == 'Enter') {
                this.SearchFunc();
            }
        },
        SearchFunc() {
            let params = {
                client_id: this.user.client_id,
                first: this.first,
                last: this.last,
                email: this.email,
                phone: this.phone,
            }
            this.$http.post('/patients/patients-search', params)
            .then(res => {
                if (res.data.patients.length > 0)
                    this.datas = res.data.patients
                else this.datas = []
            }).catch(error => {

            })
        },
        choosePatient(patient) {
            this.$router.push({name: 'patient', params: {id: patient.id}})
        },
        dateFormat(date) {
            return moment(date).format('ll');
        }
    },
    watch: {
        search(newSearch, oldSearch) {
            if (newSearch.length >= 3) {
                this.activeSearch = newSearch
            }
            if (newSearch.length < oldSearch.length && newSearch.length < 3) {
                this.activeSearch = "";
            }
        }
    },
    components: {
        VCustomHeader,
        VCustomFooter
    }
}
</script>

<style>
.v-label {
    font-size: 12px !important;
}
.flex-grow-1 {
    margin-right: 12px;
    text-align: center;
}
</style>