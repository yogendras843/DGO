<template>
<v-layout class="flex-column">
            <v-custom-header/>
                <v-content>
    <v-container fluid>
        <v-layout row wrap>
        <!-- confirm dialog -->
        <v-row justify="center">
            <v-dialog v-model="showdialog" persistent max-width="290">
            <v-card>
                <v-card-title class="headline">Are you sure to delete?</v-card-title>
                
                <v-card-actions>
                <div class="flex-grow-1"></div>
                <v-btn color="green darken-1" text @click="noDelete">Disagree</v-btn>
                <v-btn color="green darken-1" text @click="yesDelete">Agree</v-btn>
                </v-card-actions>
            </v-card>
            </v-dialog>
        </v-row>
        <!-- confirm dialog -->
            <v-flex xs12 sm9 lg9>
	        <full-calendar ref="calendar" :config="config" :events="events" ></full-calendar>
            </v-flex>
            <v-flex xs12 sm3 lg3 wrap style="padding-left:20px;">
            </br></br></br>
            
            <v-btn @click="togglePage" medium>Calendar</v-btn></br></br></br>
            
            <v-card
                class="mx-auto"
                max-width="200"
                tile
            >
                <v-list dense>
                <v-subheader>Select User</v-subheader>
                <v-list-item-group color="primary">
                    <v-list-item
                    v-for="(item, i) in users"
                    :key="i"
                    @click="linkToUserPage(item.id)"
                    >
                    <v-list-item-icon>
                        <v-icon v-text="item.icon">{{ icons.mdiAccount }}</v-icon>
                    </v-list-item-icon>
                    {{ item.firstname + ' ' + item.lastname }}
                    <v-list-item-content>
                        <v-list-item-title v-text="item.text"></v-list-item-title>
                    </v-list-item-content>
                    </v-list-item>
                </v-list-item-group>
                </v-list>
            </v-card>
            </br></br>
            <v-btn @click="copySchedule" medium>Copy Schedule</v-btn>
            </v-flex>
        </v-layout>
    </v-container>
                </v-content>
    <v-custom-footer/>
    </v-layout>
</template>

<script>
    import axios from 'axios'
	import moment from 'moment'
    import VCustomHeader from '../components/Header'
    import VCustomFooter from '../components/Footer'
    import 'fullcalendar/dist/fullcalendar.css'
    import interactionPlugin from '@fullcalendar/interaction';
    import {
        mdiAccount,
        mdiPencil,
        mdiShareVariant,
        mdiDelete,
    } from '@mdi/js'
    var startdate = '';
    var enddate = '';
    var deleteID = '';

    var resizingID = '';
    var resizingStart = '';
    var resizingEnd = '';

    var droppingID = '';
    var droppingStart = '';
    var droppingEnd = '';

    var deleteids = [];
    
	export default {
        components: {
            VCustomHeader,
            VCustomFooter
        },
        computed: {
            events: function() {
                let states = this.$store.state.schedules
                let newStates = [];
                states.map(function (state) {
                    let temp = {
                        id: state.id,
                        title: 'Available',
                        start: state.start,
                        end: state.end
                    }
                    newStates.push(temp)
                })
                return newStates

            } 
        },
        data () {
            return {
                showdialog: false,
                users: [],
                icons: {
                    mdiAccount,
                    mdiPencil,
                    mdiShareVariant,
                    mdiDelete,
                },
                ofUser: this.$store.state.user.id,
                editable: false,
                selectable: false,
                droppable: true,
                config: {
                    defaultView: 'agendaWeek',
                    selectOverlap: false,
                    plugins: [ interactionPlugin ],
                    select: function(startDate, endDate,) {
                        var s_d = startDate._d;
                        // s_d.setHours(s_d.getHours() - 8);
                        var s_year = s_d.getFullYear();
                        var s_month = (Number(s_d.getMonth())+1 < 10) ? '0' + (Number(s_d.getMonth())+1).toString() : (Number(s_d.getMonth())+1).toString();
                        var s_date = (s_d.getDate() < 10) ? '0' + s_d.getDate() : s_d.getDate();
                        var s_hour = (s_d.getHours() < 10) ? '0' + s_d.getHours() : s_d.getHours();
                        var s_minute = (s_d.getMinutes() < 10) ? '0' + s_d.getMinutes() : s_d.getMinutes();
                        var s_second = (s_d.getSeconds() < 10) ? '0' + s_d.getSeconds() : s_d.getSeconds();

                        var e_d = endDate._d;
                        // e_d.setHours(e_d.getHours() - 8);
                        var e_year = e_d.getFullYear();
                        var e_month = (Number(e_d.getMonth())+1 < 10) ? '0' + (Number(e_d.getMonth())+1).toString() : (Number(e_d.getMonth())+1).toString();
                        var e_date = (e_d.getDate() < 10) ? '0' + e_d.getDate() : e_d.getDate();
                        var e_hour = (e_d.getHours() < 10) ? '0' + e_d.getHours() : e_d.getHours();
                        var e_minute = (e_d.getMinutes() < 10) ? '0' + e_d.getMinutes() : e_d.getMinutes();
                        var e_second = (e_d.getSeconds() < 10) ? '0' + e_d.getSeconds() : e_d.getSeconds();
                        startdate = s_year + '-' + s_month + '-' + s_date + ' ' + s_hour + ':' + s_minute + ':' + s_second
                        enddate = e_year + '-' + e_month + '-' + e_date + ' ' + e_hour + ':' + e_minute + ':' + e_second
                    },
                    eventRender : (event, element) => {
                        console.log('element')
                        console.log(element)
                        
                    },
                    eventClick: function(event) {
                        deleteID = event.id
                    },
                    eventResize: function(info) {
                        console.log("resizing")
                        console.log(info)
                        var s_d = info.start._d;
                        // s_d.setHours(s_d.getHours() - 8);
                        var s_year = s_d.getFullYear();
                        var s_month = (Number(s_d.getMonth())+1 < 10) ? '0' + (Number(s_d.getMonth())+1).toString() : (Number(s_d.getMonth())+1).toString();
                        var s_date = (s_d.getDate() < 10) ? '0' + s_d.getDate() : s_d.getDate();
                        var s_hour = (s_d.getHours() < 10) ? '0' + s_d.getHours() : s_d.getHours();
                        var s_minute = (s_d.getMinutes() < 10) ? '0' + s_d.getMinutes() : s_d.getMinutes();
                        var s_second = (s_d.getSeconds() < 10) ? '0' + s_d.getSeconds() : s_d.getSeconds();

                        var e_d = info.end._d;
                        // e_d.setHours(e_d.getHours() - 8);
                        var e_year = e_d.getFullYear();
                        var e_month = (Number(e_d.getMonth())+1 < 10) ? '0' + (Number(e_d.getMonth())+1).toString() : (Number(e_d.getMonth())+1).toString();
                        var e_date = (e_d.getDate() < 10) ? '0' + e_d.getDate() : e_d.getDate();
                        var e_hour = (e_d.getHours() < 10) ? '0' + e_d.getHours() : e_d.getHours();
                        var e_minute = (e_d.getMinutes() < 10) ? '0' + e_d.getMinutes() : e_d.getMinutes();
                        var e_second = (e_d.getSeconds() < 10) ? '0' + e_d.getSeconds() : e_d.getSeconds();

                        resizingID = info.id;
                        resizingStart = s_year + '-' + s_month + '-' + s_date + ' ' + s_hour + ':' + s_minute + ':' + s_second
                        resizingEnd = e_year + '-' + e_month + '-' + e_date + ' ' + e_hour + ':' + e_minute + ':' + e_second
                    },
                    eventDrop: function(eventDropInfo) {
                        console.log("dropping")
                        console.log(eventDropInfo)
                        var s_d = eventDropInfo.start._d;
                        // s_d.setHours(s_d.getHours() - 8);
                        var s_year = s_d.getFullYear();
                        var s_month = (Number(s_d.getMonth())+1 < 10) ? '0' + (Number(s_d.getMonth())+1).toString() : (Number(s_d.getMonth())+1).toString();
                        var s_date = (s_d.getDate() < 10) ? '0' + s_d.getDate() : s_d.getDate();
                        var s_hour = (s_d.getHours() < 10) ? '0' + s_d.getHours() : s_d.getHours();
                        var s_minute = (s_d.getMinutes() < 10) ? '0' + s_d.getMinutes() : s_d.getMinutes();
                        var s_second = (s_d.getSeconds() < 10) ? '0' + s_d.getSeconds() : s_d.getSeconds();

                        var e_d = eventDropInfo.end._d;
                        // e_d.setHours(e_d.getHours() - 8);
                        var e_year = e_d.getFullYear();
                        var e_month = (Number(e_d.getMonth())+1 < 10) ? '0' + (Number(e_d.getMonth())+1).toString() : (Number(e_d.getMonth())+1).toString();
                        var e_date = (e_d.getDate() < 10) ? '0' + e_d.getDate() : e_d.getDate();
                        var e_hour = (e_d.getHours() < 10) ? '0' + e_d.getHours() : e_d.getHours();
                        var e_minute = (e_d.getMinutes() < 10) ? '0' + e_d.getMinutes() : e_d.getMinutes();
                        var e_second = (e_d.getSeconds() < 10) ? '0' + e_d.getSeconds() : e_d.getSeconds();

                        droppingID = eventDropInfo.id;
                        droppingStart = s_year + '-' + s_month + '-' + s_date + ' ' + s_hour + ':' + s_minute + ':' + s_second
                        droppingEnd = e_year + '-' + e_month + '-' + e_date + ' ' + e_hour + ':' + e_minute + ':' + e_second
                    }
                    
                },
            }
        },
        
        methods: {
            getUsers() {
                this.$http.get('/users/getUsers').then(res => {
                    this.users = res.data[0];
                })
            },
            linkToUserPage(id) {
                if (this.$route.params.id !== undefined && this.$route.params.id == id) {
                    // this.search = "";
                } else {
                    this.$router.push({name: 'schedule', params: {id: id}});
                    this.ofUser = id;
                    this.getSchedules();
                }
            },
            copySchedule() {
                var user_id = {'user_id': this.ofUser}
                this.$http.post('/users/copySchedule', user_id).then(res => {
                    if (res.data.error) {
                        this.$toast.error({
                            title: "Warning.",
                            message: res.data.error
                        })
                    } else {
                        let data = {
                            id: res.data[0][0].id,
                            start: this.changeDateType(res.data[0][0].start_event),
                            end: this.changeDateType(res.data[0][0].end_event)
                        }
                        this.$store.commit("ADDSCHEDULE", data);
                    }
                })
            },
            saveSchedule() {
                var req = {'user_id': this.ofUser, 'start_event': startdate, 'end_event': enddate}
                this.$http.post('/users/createSchedule', req).then(res => {
                    if (res.data.error) {
                        this.$toast.error({
                            title: "Warning.",
                            message: res.data.error
                        })
                    } else {
                        let data = {
                            id: res.data[0][0].id,
                            start: this.changeDateType(res.data[0][0].start_event),
                            end: this.changeDateType(res.data[0][0].end_event)
                        }
                        this.$store.commit("ADDSCHEDULE", data);
                        // window.location.reload();
                    }
                })
            },
            togglePage() {
                this.$router.push({name:'home', params: {id: this.$store.state.user.id}})
            },
            getSchedules() {
                this.$http.get(`/users/getSchedule/${this.$route.params.id}`).then(res => {
                    if (res.data.error) {
                        this.$toast.error({
                            title: "Warning.",
                            message: res.data.error
                        })
                    } else {
                        const data = res.data[0].map(function(date) {
                            date.start_event = date.start_event.substring(date.start_event, date.start_event.length - 5).replace(/T/g, " ");
                            date.end_event = date.end_event.substring(date.end_event, date.end_event.length - 5).replace(/T/g, " ");
                            delete date.client_id;
                            delete date.created;
                            delete date.created_user_id;
                            delete date.patient_id;
                            delete date.updated;
                            delete date.updated_user_id;
                            delete date.user_id;
                            date.start = date.start_event;
                            date.end = date.end_event;
                            delete date.start_event;
                            delete date.end_event;
                            return date;
                        })
                        this.$store.commit("GETSCHEDULE", data);
                    }
                })
            },
            changeDateType(date) {
                return date.substring(date, date.length - 5).replace(/T/g, " ");
            },
            stopDrag() {
                if (resizingID != '' || droppingID != '') {
                    var updateID = (resizingID) ? resizingID : droppingID
                    var updateStart = (resizingID) ? resizingStart : droppingStart
                    var updateEnd = (resizingID) ? resizingEnd : droppingEnd
                    var req = {'id': updateID, 'start_event': updateStart, 'end_event': updateEnd}
                    this.$http.post('/users/updateSchedule', req).then(res => {
                        if (res.data.error) {
                            this.$toast.error({
                                title: "Warning.",
                                message: res.data.error
                            })
                        } else {
                            var updateState = {'id': updateID, 'start_event': this.minus8hours(updateStart), 'end_event': this.minus8hours(updateEnd)}
                            this.$store.commit("UPDATESCHEDULE", updateState);
                        }
                    })
                    resizingID = '';
                    resizingStart = '';
                    resizingEnd = '';

                    droppingID = '';
                    droppingStart = '';
                    droppingEnd = '';
                }
                if(startdate){
                    this.saveSchedule();
                    startdate = '';
                    enddate = '';
                }
                var isCreate = true;
            },
            minus8hours(isoDate) {
                var d = new Date(isoDate);
                d.setHours(d.getHours() - 8);
                var year = d.getFullYear();
                var month = (Number(d.getMonth())+1 < 10) ? '0' + (Number(d.getMonth())+1).toString() : (Number(d.getMonth())+1).toString();
                var date = (d.getDate() < 10) ? '0' + d.getDate() : d.getDate();
                var hour = (d.getHours() < 10) ? '0' + d.getHours() : d.getHours();
                var minute = (d.getMinutes() < 10) ? '0' + d.getMinutes() : d.getMinutes();
                var second = (d.getSeconds() < 10) ? '0' + d.getSeconds() : d.getSeconds();
                return year + '-' + month + '-' + date + ' ' + hour + ':' + minute + ':' + second
            },
            confirmDelete() {
                if (deleteID){
                    this.showdialog = true;
                }
            },   
            yesDelete() {
                this.showdialog = false;
                if(deleteID != ''){
                    var dID = {'id': deleteID}
                    this.$http.post('/users/deleteSchedule', dID).then(res => {

                    })
                }
                this.$store.commit("DELETESCHEDULE", deleteID);
                deleteID = '';
            },
            noDelete() {
                this.showdialog = false;
                deleteID = '';
            },
            deleteInDB(ids) {
                this.$http.post('/users/deleteSchedule', ids).then(res => {
                            
                })
            }
        },
        
        mounted() {
            window.addEventListener('mouseup', this.stopDrag);
            window.addEventListener('click', this.confirmDelete);
            this.getUsers();
            this.getSchedules();
            
        },
    }

</script>
<style scoped>
    .v-navigation-drawer {
        height: 40% !important;
        margin-top: 20px;
    }
    .ml-auto, .mx-auto {
        margin-left: 0px !important;
    }
    .v-application .mx-auto {
        margin-left: 0px !important;
    }
    .v-application--is-ltr .v-list-item__action:first-child, .v-application--is-ltr .v-list-item__icon:first-child {
        margin-right: 11px;
    }
    .v-subheader{
        padding-left: 22px;
    }
</style>

