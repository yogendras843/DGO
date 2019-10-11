import Vue from 'vue'
import Router from 'vue-router'

// page for static public site
import Index from './views/Index.vue'

// page for client (doctor)
import Login from './views/Login.vue'
import Verify from './views/Verify.vue'
import Reset from './views/Reset.vue'
import Home from './views/Home.vue'
import Workflow from './views/Workflow.vue'
import Patients from './views/Patients.vue'
import Patient from './views/Patient.vue'
import Users from './views/Users.vue'
import Myself from './views/Myself.vue'
import Reports from './views/Reports.vue'
import FeeTypes from './views/FeeTypes.vue'
import Schedule from './views/Schedule.vue'

// page for patient
import PPContainer from './views/PPContainer'
import PPLogin from './views/PPLogin'
import PPVerify from './views/PPVerify'
import PPReset from './views/PPReset'
import PPHome from './views/PPHome'
import PPProfile from './views/PPProfile'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    // route for static public site
    {
      path: '/',
      name: 'index',
      component: Index
    },

    // route for client
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/verify',
      name: 'verify',
      component: Verify
    },
    {
      path: '/reset/:id',
      name: 'reset',
      component: Reset
    },
    {
      path: '/home/:id',
      name: 'home',
      component: Home,
      meta: {
        permission: 1
      }
    },
    {
      path: '/schedule/:id',
      name: 'schedule',
      component: Schedule,
      meta: {
        permission: 1
      }
    },
    {
      path: '/workflow',
      name: 'workflow',
      component: Workflow,
      meta: {
        permission: 1
      }
    },
    {
      path: '/patients',
      name: 'patients',
      component: Patients,
      meta: {
        permission: 2
      }
    }, 
    {
      path: '/patient/:id',
      name: 'patient',
      component: Patient,
      meta: {
        permission: 2
      }
    },
    {
      path: '/users',
      name: 'users',
      component: Users,
      meta: {
        permission: 2
      }
    }, 
    {
      path: '/myself',
      name: 'myself',
      component: Myself,
      meta: {
        permission: 2
      }
    }, 
    {
      path: '/reports',
      name: 'reports',
      component: Reports,
      meta: {
        permission: 2
      }
    }, 
    {
      path: '/fee-types',
      name: 'fee-types',
      component: FeeTypes,
      meta: {
        permission: 2
      }
    }, 

// route for patient
    {
      path: '/patient-login',
      name: 'patient-login',
      component: PPLogin
    }, {
      path: '/patient-verify',
      name: 'patient-verify',
      component: PPVerify
    }, {
      path: '/patient-reset/:id',
      name: 'patient-reset',
      component: PPReset
    }, {
      path: '/PatientPortal',
      component: PPContainer,
      children: [{
        path: 'home',
        name: 'patient-home',
        component: PPHome,
        meta: {
          permission: 1
        }
      }, {
        path: 'profile',
        name: 'patient-profile',
        component: PPProfile,
        meta: {
          permission: 1
        }
      }]
    }
  ]
})
