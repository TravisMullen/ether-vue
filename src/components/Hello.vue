<template lang="pug">
.hello
  // <pre>{{ethjs}}</pre>
  h1 {{ msg }}
  h3 {{ status }}
  h2 Connected: 
    strong {{isConnected()}}
  h2
    strong
      | Coin
      em base
    |  {{ coinbase }}
  li
    strong balance
    |  {{originalBalance}}
  li
    strong updated balance (as event callback)
    |  {{updatedBalance}}
  li.panel(v-if='syncing.currentBlock')
    strong syncing
    h3 {{ syncing.currentBlock }} / {{ syncing.highestBlock }}
    // todo:: // add progress guage
    h1 {{syncPercetage}}%
  li
    strong hashrate
    |  {{ hashrate }}
  li
    strong accounts
    |  {{ accounts }}
</template>

<script>
//
// goals: set listeners for contract events
// to data vars (bound  observers)
// todo :: compile smart contact from `.sol`
// call contract from URL param/route
//
// use imports for library
import Web3 from 'web3'
// import TestRPC from 'ethereumjs-testrpc'
// use `TestRPC` (needed for spec test?)
// import * as ethjs from 'ethereumjs-util'

// check for Mist.
let web3 = web3 || undefined
if (!web3) {
  web3 = new Web3()
}
// geth attach // to testrpc or main
// > admin.startRPC("127.0.0.1", 8545, "*")
// [HPM] Proxy created: /jsonrpc  ->  http://127.0.0.1:8545/
// [HPM] Proxy rewrite rule created: "^/" ~> "/jsonrpc"
web3.setProvider(new Web3.providers.HttpProvider('http://127.0.0.1:8080/jsonrpc/'))
// web3.setProvider(TestRPC.provider())
export default {
  name: 'hello',
  data () {
    return {
      msg: 'Ethereum Node Status',
      status: '',

      // minor obj
      // miner: web3.admin.miner,

      // adding the web3 data
      coinbase: web3.eth.coinbase,
      hashrate: web3.eth.hashrate,

      accounts: web3.eth.accounts,
      peers: web3.eth.peers,

      // nodeId: web3.admin.nodeInfo,

      syncing: {},

      originalBalance: web3.eth.getBalance(web3.eth.coinbase).toString(10),
      updatedBalance: web3.eth.getBalance(web3.eth.coinbase).toString(10)
    }
  },
  computed: {
    // todo :: is mining
    syncPercetage () {
      let percentage = this.syncing.currentBlock / this.syncing.highestBlock
      // return Math.floor(percentage * 100)
      return percentage * 100
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
    // add socket/http/event watchers here
    web3.eth.isSyncing((error, sync) => {
      if (!error) {
        dis.status = 'Syncing Chain...'
        if (sync && sync.currentBlock) {
          // dis.syncing = Object.assign({}, dis.syncing, sync)
          dis.syncing = sync
        }
      }
    })
    // default events for UI manipulation
    web3.eth.filter('latest').watch(() => {
      // this shows we dont really need manually set the variable value
      // because the web3 object is updated and observed by the vue.data {}
      dis.updatedBalance = web3.eth.getBalance(web3.eth.coinbase).toString(10)
      // put this in timeout?
      dis.status = 'Updated Info.'
    })
    web3.eth.filter('pending').watch(function () {
      // if (dis.miner.hashrate > 0) return

      dis.status = 'Pending transactions! Looking for next block...'
      // todo :: create settings service
      // miner.start(settings.threads)
    })
    //
    // declare contract event listeners here!
    //
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
.panel {
  border: 1px solid black;
}
a {
  color: #42b983;
}
</style>
