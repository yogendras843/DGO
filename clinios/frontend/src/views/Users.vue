<template>
  <v-layout class="flex-column">
    <v-custom-header/>
    <v-content>
      <v-container>
        <p class="headline">Users</p>
        <v-card class="border">
          <v-card-title>
              <v-text-field v-model="search" class="pt-0" append-icon="search" label="Search" single-line hide-details autofocus/>
              <div class="flex-grow-1"></div>
              <div class="flex-grow-1"></div>
              <div class="flex-grow-1"></div>
              <div class="flex-grow-1"></div>
              <div class="flex-grow-1"></div>
              <div class="flex-grow-1"></div>
              <v-btn color="primary" dark class="mb-2" v-if="$store.state.user.admin == 1" @click.stop="createHandle">New User</v-btn>
              <v-dialog v-model="dialog" max-width="600px">
                <v-card>
                  <v-card-title>
                    <span class="headline">{{isCreate ? "Create User" : "Edit User"}}</span>
                  </v-card-title>
                  <v-card-text>
                    <v-form class="container" ref="userForm">
                      <v-row>
                        <v-col cols="12" sm="6" md="4">
                          <v-text-field 
                            v-model.trim="user.firstname" 
                            label="First Name"
                            required
                            :rules="[v => !!v || 'First Name is required']"
                          />
                        </v-col>
                        <v-col cols="12" sm="6" md="4">
                          <v-text-field 
                            v-model.trim="user.lastname" 
                            label="Last Name"
                            required
                            :rules="[v => !!v || 'Last Name is required']"
                          />
                        </v-col>
                        <v-col cols="12" sm="6" md="4">
                          <v-text-field v-model.trim="user.email" label="Email"/>
                        </v-col>
                      </v-row>
                      <v-row>
                        <v-col cols="12" sm="6" md="4">
                          <v-text-field v-model.trim="user.title" label="Title"/>
                        </v-col>
                        <v-col cols="12" sm="6" md="4">
                          <v-text-field v-model.trim="user.phone" label="Phone"/>
                        </v-col>
                        <v-col cols="12" sm="6" md="4">
                          <v-select v-model.trim="user.status" :items="status" label="Status"/>
                        </v-col>
                      </v-row>
                      <v-row>
                        <v-col cols="12" sm="6" md="4">
                          <v-text-field type="password" label="Password" v-model.trim="user.password" v-if="isCreate"/>
                        </v-col>
                        <v-col cols="12" sm="6" md="4">
                          <v-switch v-model="user.admin" color="primary" label="Admin"/>
                        </v-col>
                        <v-col cols="12" sm="6" md="4">
                          <v-switch v-model="user.appointments" color="primary" label="Appointment"/>
                        </v-col>
                      </v-row>
                      <v-row>
                        <v-col md="12">
                          <v-textarea v-model.trim="user.comment" label="Comment" outlined/>
                        </v-col>
                      </v-row>
                    </v-form>
                  </v-card-text>
                  <v-card-actions class="pr-5 pb-5">
                    <div class="flex-grow-1"></div>
                    <v-btn color="grey" @click="close">Cancel</v-btn>
                    <v-btn color="primary" @click="save">{{isCreate ? "Create" : "Save"}}</v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
          </v-card-title>
          <v-card-text>
            <v-data-table
              :headers="headers"
              :items="items"
              :items-per-page="15"
              :search="search"
            >
              <template v-slot:item.status="{item}">
                {{item.status == 1 ? "Active" : "Inactive"}}
              </template>
              <template v-slot:item.appointments="{item}">
                {{item.appointments == 1 ? "Yes" : "No"}}
              </template>
              <template v-slot:item.admin="{item}">
                {{item.admin == 1 ? "Yes" : "No"}}
              </template>
              <template v-slot:item.created="{item}">
                {{dateFormat(item.created)}}
              </template>
              <template v-slot:item.action="{ item }">

                <v-tooltip right>
                  <template v-slot:activator="{ on }">
                    <v-icon small text class="mr-2" v-if="$store.state.user.admin == 1" @click="editUser(item)" v-on="on">edit</v-icon>
                  </template>
                  <span>Edit</span>
                </v-tooltip>
    
                <v-tooltip right>
                  <template v-slot:activator="{ on }">
                    <v-icon small text v-if="$store.state.user.admin == 1 && item.id !== $store.state.user.id" @click="deleteUser(item)" v-on="on">delete</v-icon>
                  </template>
                  <span>Delete</span>
                </v-tooltip>
              
              </template>
            </v-data-table>
          </v-card-text>
        </v-card>
      </v-container>
      <v-dialog v-model="delDialog" persistent max-width="400">
        <v-card>
          <div class="text-center">
            <v-avatar size="120">
              <v-img :src="require('../assets/images/warning.png')"></v-img>
            </v-avatar>
          </div>
          <v-card-text class="text-center display-1">Delete user?</v-card-text>
          <v-card-actions class="pr-5 pb-5">
            <div class="flex-grow-1"></div>
            <v-btn color="grey" @click="delDialog = false">Cancel</v-btn>
            <v-btn color="primary" @click="deleteHandle">Delete</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
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
      dialog: false,
      delDialog: false,
      isCreate: true,
      search: "",
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
        }, {
          text: "Title",
          value: "title"
        }, {
          text: "Phone",
          value: "phone"
        }, {
          text: "Comment",
          value: "comment"
        }, {
          text: "Status",
          value: "status"
        }, {
          text: "Appointments",
          value: "appointments"
        }, {
          text: "Schedule",
          value: "schedule"
        }, {
          text: "Admin",
          value: "admin",
        }, {
          text: "Created",
          value: "created",
        }, {
          text: "Actions",
          value: "action"
        }
      ],
      items: [],
      editedIndex: -1,
      user: {
        firstname: "",
        lastname: "",
        email: "",
        title: "",
        phone: "",
        password: "",
        status: false,
        admin: false,
        appointments: false
      },
      activedUserId: 0,
      status: [{
        text: "Active", value: true
      }, {
        text: "Inactive", value: false
      }]
    }
  },
  components: {
    VCustomHeader,
    VCustomFooter
  },
  created() {
    this.initTable();
  },
  computed: {
    cur_user() {
      return this.$store.state.user
    }
  },
  mounted() {
    let vm = this;
    window.addEventListener('keyup', this.enterEscHandle)
  },
  destroyed() {
    window.removeEventListener('keyup', this.enterEscHandle)
  },
  methods: {
    enterEscHandle(e) {
      if (e.code == 'Enter' && this.dialog) {
        this.save();
      } else if (e.code == 'Enter' && this.delDialog) {
        this.deleteHandle();
      } else if (e.code == 'Escape' && this.dialog) {
        this.close()
      } else if (e.code == 'Escape' && this.delDialog) {
        this.delDialog = false;
      }
    },
    initTable() {
      let params = {
        client_id: this.cur_user.client_id
      }
      this.$http.post('/users', params).then(res => { //new
      this.items = res.data.users
      }, err => {

      });
    },
    createHandle() {
      this.dialog = true;
      this.isCreate = true;
      if (this.$refs.userForm) this.$refs.userForm.reset();
    },

    save() {
      if (this.$refs.userForm.validate()) {
        var url = "";
        var vm = this;
        if (this.isCreate) {
          url = `/users/create`;
          vm.user.client_id = vm.cur_user.client_id;
          vm.user.created_user_id = vm.cur_user.id;
          vm.user.password = vm.user.password ? vm.user.password : "";
          vm.user.phone = vm.user.phone ? vm.user.phone : "";
          vm.user.admin = vm.user.admin ? true : false;
          vm.user.appointments = vm.user.appointments ? true : false;
          vm.user.status = vm.user.status ? true : false;
          vm.user.title = vm.user.title ? vm.user.title : "";
        }
        else {
          url = `/users/update/${vm.user.id}`; 
          vm.user.client_id = vm.cur_user.client_id;  //?
          vm.user.updated_user_id = vm.cur_user.id;
        }
        vm.$http.post(url, vm.user).then(res => {
          if (res.data.error) {
            vm.$toast.error({
              title: 'Warning!', 
              message: res.data.error
            });
          } else {
            vm.initTable();
            if (!vm.isCreate) {
              vm.$toast.success({
                title:'Success!', 
                message: "Your information was updated."
              });
            }
            vm.dialog = false;
          }
        }, err => {
          console.error(err)
        })
      } else {
        this.$toast.error({
          title: 'Warning!', 
          message: 'First and last name is required.'
        })
      }
    },

    close() {
      this.dialog = false;
    },

    editUser(item) {
      this.isCreate = false;
      this.dialog = true;
      this.user = {...item}
      this.user.appointments = this.user.appointments == 1 ? true : false;
      this.user.admin = this.user.admin == 1 ? true : false;
      this.user.status = this.user.status == 1 ? true : false
    },

    deleteUser(item) {
      this.delDialog = true;
      this.activedUserId = item.id
    },

    deleteHandle() {
      var vm = this;
      vm.$http.post(`/users/delete/${vm.cur_user.client_id}/${vm.activedUserId}`).then(res => {
        if (res.data.error) {
          this.$toast.error({
            title: "Warning!", 
            message: res.data.error
          });

        } else {
          this.initTable();
        }
        this.delDialog = false;
      }, err => {
        this.$toast.error({
          title: "Warning",
          message: err.toString()
        })
      })
    },
    dateFormat(date) {
      return moment(date).format('ll');
    }
  }
}
</script>

<style>
.v-data-table th {
  padding: 5px !important;
  padding-top: 5px !important;
  padding-bottom: 5px !important;
  padding-left: 5px !important;
  padding-right: 5px !important;
}
</style>