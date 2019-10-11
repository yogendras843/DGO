<template>
  <div>
    <nav class="navbar navbar-expand-sm bg-light fixed-top">
      <div class="container p-0">
        <a class="navbar-brand" :to="{name: 'home'}"><img :src="require('@/assets/images/logo1.png')"/></a>
      </div>
    </nav>
    <div class="container mt-8">
      <div class="row mt-8">
        <div class="col-md-9 col-lg-7">
          <h1 class="mb-5">Software for functional and integrative medical pracices</h1>
          <p>Clinios is the next generation of software for functional medicine physicians.</p>
        </div>
        <div class="col-md-3 col-lg-5">
        </div>
      </div>
      <div class="row mt-5">
        <div class="col-md-6">
          <h2 class="mb-5">Integration With Labs</h2>
          <p>Clinios is integrated with Labcorp, Quest Diagnostics, Doctors Data, Great Plains Laboratory, Diagnostic Solutions Laboratory, Precision Analytical, and can integrate with additional laboratories upon request.</p>
        </div>
        <div class="col-md-6 text-center">
          <img :src="require('@/assets/images/integrations.png')" style="max-height: 205px; width: 100%"/>
        </div>
      </div>
      <div class="row mt-5">
        <div class="col-md-6">
          <h2 class="mb-5">Blood Chemistry Analysis</h2>
          <p>Clinios performs functional analysis on dozens of patients blood markers.</p>
        </div>
        <div class="col-md-6 text-center">
          <img :src="require('@/assets/images/alt.png')" style="max-height: 250px; width: 100%;"/>
        </div>
      </div>
      <div class="d-flex flex-row justify-content-center align-center w-100 mt-5">
        <router-link class="btn btn-link" :to="{name: 'login'}">Physician Login</router-link>
        <router-link class="btn btn-link" :to="{name: 'patient-login'}">Patient Login</router-link>
      </div>
      <div class="d-flex flex-row justify-content-center mt-5 pt-2">
        <p>Copyright@clinios 2019</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {

};
</script>
<style scoped>
</style>
