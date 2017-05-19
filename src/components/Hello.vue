<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <h2>isConnected {{isConnected()}}</h2>
      <h2><strong>coinbase</strong> {{ coinbase }}</h2>

      <li><strong>syncing</strong> {{ syncing.currentBlock }} / {{ syncing.highestBlock }} <h1>{{syncPercetage}}%</h1></li>
      <li><strong>hashrate</strong> {{ hashrate }}</li>

      <li><strong>accounts</strong> {{ accounts }}</li>
      <li><strong>original balance</strong> {{originalBalance}}</li>
      <!-- <li><strong>original balance</strong> {{latest}}</li> -->
    </ul>
  </div>
</template>

<script>
import Web3 from 'web3'
// import * as ethjs from 'ethereumjs-util'

// check for Mist (predefined)
const web3 = new Web3()
web3.setProvider(new Web3.providers.HttpProvider('http://localhost:8080/abi/'))
// web3.eth.filter('latest').watch(() => {
  //       return web3.eth.getBalance(web3.eth.coinbase).toString(10)
  //     })
// console.log('web3', web3)
export default {
  name: 'hello',
  data () {
    return {
      msg: 'Ethereum Status',
      coinbase: web3.eth.coinbase,
      hashrate: web3.eth.hashrate,

      accounts: web3.eth.accounts,
      peers: web3.eth.peers,

      syncing: {},

      originalBalance: web3.eth.getBalance(web3.eth.coinbase).toString(10)
    }
  },
  computed: {
    syncPercetage () {
      let percentage = this.syncing.currentBlock / this.syncing.highestBlock
      return Math.floor(percentage * 100)
    }
  },
  methods: {
    isConnected: () => {
      if (web3.isConnected()) {
        return true
      }
    }
  },
  beforeCreate () {
    let dis = this
    // add socket/http event based watchers here
    web3.eth.isSyncing((error, sync) => {
      if (!error) {
        if (sync && sync.currentBlock) {
          // dis.syncing = Object.assign({}, dis.syncing, sync)
          dis.syncing = sync
        }
      }
    })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  /*display: inline-block;*/
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
