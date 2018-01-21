---
layout: post
title: "Enable WebSocket support of Ganache CLI and Subscribe to Events"
tags: [BlockChain]
---

This week, [Ganache CLI released beta version 7.0.0](https://github.com/trufflesuite/ganache-cli/releases/tag/v7.0.0-beta.0) which introduces support for WebSocket. It means that features in Web3 1.0.0 such as block event subscription and contract event listening is now possible. 

This article serves as a brief walkthrough on how to enable WebSocket support of Ganache CLI and what you can do with it.

*Be aware that, as of January 2018, Ganache-cli 7.0.0 has just released its first beta version. Try it at your discretion.*

1. TOC
{:toc}

# Start the Ganache CLI

Run `ganache-cli --networkId [MY_NETWORK_ID]` will start the client on the localhost at the default port 8545 with the specified network ID. You can [configure](https://github.com/trufflesuite/ganache-cli/tree/v7.0.0-beta.0#command-line) the hostname or the port using `--hostname` or `--port` argument, respectively.

# Start a Listening Server

This article used [express.js](https://expressjs.com/), but any server on Node.js should work. Details for server setup is omitted.

## Create Web3 Instance

```
let Web3 = require('web3')
let web3 = new Web3(new Web3.providers.WebsocketProvider('ws://localhost:8545'))
```

note that if we use the conventional

```
let web3 = new Web3('http://localhost:8545')
```

then when you try to use the websocket-only features, it will throw `Error: The current provider doesn't support subscriptions: HttpProvider`

## Get Contract Instance

If you use [truffle](truffleframework.com) to compile the contract, you can get the instance by

```
import MyContract from 'path/to/MyContract.json'

const myContract = new web3.eth.Contract(
  MyContract.abi,
  MyContract.networks[MY_NETWORK_ID].address,
  {from: MY_COINBASE, gas: MY_DEFAULT_GAS, gasPrice: MY_DEFAULT_GAS_PRICE}
)
```

## Subscribe to Block Events

e.g. if we want to log the block header to the console whenever a new block is submitted to the blockchain:

```
web3.eth.subscribe('newBlockHeaders', function (error, blockHeader) {
  if (error) console.log(error)
  console.log(blockHeader)
})
  .on('data', function (blockHeader) {
    // alternatively we can log it here
    console.log(blockHeader)
  })
```

## Subscribe to All Contract Events

```
// or `myContract.events.MyEvent` to subscribe to a specific event
myContract.events.allEvents({
  fromBlock: 0
}, function (error, event) {
  if (error) console.log(error)
  console.log(event)
})
```
