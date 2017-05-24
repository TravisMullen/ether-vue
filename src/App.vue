<template>
  <div id="app">
    <img src="./assets/Ethereum_logo_2014.svg">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app'
  // data () {
  //   return {
  //     logo: require('/src/assets/Ethereum_logo_2014.svg')
  //   }
  // }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
img {
  width: 3rem;
}
</style>
