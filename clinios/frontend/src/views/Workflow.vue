<template>
    <v-layout class="flex-column">
        <v-custom-header/>
        <v-content>
            <v-container>
                <p class="headline">Workflow</p>
                    <v-card class="border">
                        <v-card-title>
                            <div class="subtitle-2">
                                 New Messages
                            </div>
                        </v-card-title>
                        <v-card-text>
                            <v-data-table v-model="selected" :headers="headers" :items="datas" :items-per-page="15" :search="activeSearch">
                                <template v-slot:body="{items}">
                                    <tbody>
                                        <tr v-for="(item, index) in items" :key="index" @click="chooseRow(item)">
                                            <td>{{ item.name}}</td>
                                            <td>{{ item.count }}</td>
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
            search: "",
            activeSearch: "",
            headers: [
                {
                    text: "User",
                    align: "left",
                    value: "name"
                }, {
                    text: "Count",
                    value: "count"
                }, {
                    text: "Since",
                    value: "created"
                }
            ],
            datas: [],
            selected: []

        }
    },
    created() {
        this.SearchFunc()
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
            this.$http.post('/users/workflow', params)
            .then(res => {
                if (res.data.result.length > 0)
                    this.datas = res.data.result
                else this.datas = []
            }).catch(error => {

            })
        },
        chooseRow(row) {
            //this.$router.push({name: 'patient', params: {id: row.id}})
        },
        dateFormat(date) {
            return moment(date).format('ll');
        }
    },
    /*
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
    */
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