import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : null,
    token: localStorage.getItem("token") ? localStorage.getItem("token") : null,
    patientId: 0,
    lastSeenPatient: localStorage.getItem("lastSeenPatient") ? JSON.parse(localStorage.getItem("lastSeenPatient")) : null,
    schedules: [
      {
        id: '',
        userId: '',
        start: '',
        end: '',
      }
    ],
    calendars: [
      {
        id: '',
        userId: '',
        start: '',
        end: '',
        firstname: '',
      }
    ],
    users: []
  },
  mutations: {
    SET_USERDATA(state, payload) {
      localStorage.setItem("user", JSON.stringify(payload.user));
      if (payload.last_viewed_patient) {
        localStorage.setItem("lastSeenPatient", JSON.stringify(payload.last_viewed_patient));
      }
      localStorage.setItem("token", JSON.stringify(payload.token))
      state.user = payload.user;
      state.lastSeenPatient = payload.last_viewed_patient;
      state.token = payload.token;
    },
    LOGOUT(state) {
      localStorage.clear();
      state.user = null;
      state.token = null;
    },
    SET_LASTSEENPATIENT(state, patient) {
      localStorage.setItem("lastSeenPatient", JSON.stringify(patient));
      state.lastSeenPatient = patient
    },
    ADDSCHEDULE(state, data) {
      state.schedules.push(data);
    },
    UPDATESCHEDULE(state, data) {
      let index = state.schedules.findIndex((e) => e.id == data.id)
      if (index > -1) {
        state.schedules[index].id = data.id
        state.schedules[index].start = data.start_event
        state.schedules[index].end = data.end_event
        state.schedules = JSON.parse(JSON.stringify(state.schedules))
      }
    },
    DELETESCHEDULE(state, data) {
      state.schedules = state.schedules.filter(item => item.id !== data)
    },
    GETSCHEDULE(state, payload) {
      state.schedules = [];
      payload.map(function (date) {
        state.schedules.push(date)
      })
    },
    ADDCALENDAR(state, data) {
      state.calendars.push(data);
    },
    UPDATECALENDAR(state, data) {
      let index = state.calendars.findIndex((e) => e.id == data.id)
      if (index > -1) {
        state.calendars[index].id = data.id
        state.calendars[index].start = data.start_event
        state.calendars[index].end = data.end_event
        state.calendars = JSON.parse(JSON.stringify(state.calendars))
      }
    },
    DELETECALENDAR(state, data) {
      state.calendars = state.calendars.filter(item => item.id !== data)
    },
    GETCALENDAR(state, payload) {
      state.calendars = [];
      payload.map(function (date) {
        state.calendars.push(date)
      })
    }
  },
  actions: {

  }
})
