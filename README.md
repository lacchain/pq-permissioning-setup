# Post Quantum permissioning setup

This project uses [Truffle](https://www.trufflesuite.com/) to build, deploy and setup permissioning smart contracts for the Post Quantum safe blockchain demostration.

## Prerequisites

  * Truffle (i.e. `npm install truffle`)
  * A Hyperledger Besu network with nodes running the [LACChain fork](https://github.com/lacchain/besu) which adds a [Falcon-512](https://falcon-sign.info/) verification precompiled contract

## Config
You must configure Truffle according your environment, this is done through the [truffle-config.js](https://www.trufflesuite.com/docs/truffle/reference/configuration) file. E.g.
```javascript
const HDWalletProvider = require('@truffle/hdwallet-provider');
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      gasPrice: 0,
      provider: () => new HDWalletProvider('0x8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63', 'http://localhost:8545')
    }
  },
  compilers: {
    solc: {
      version: "0.6.5"
    }
  }
};
```
> note: you may need to `npm install @truffle/hdwallet-provider` for using exactly the provided example

## Running
```shell
$ npx truffle migrate
```
