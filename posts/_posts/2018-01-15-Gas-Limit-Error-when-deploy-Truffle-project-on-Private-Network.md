---
layout: post
title: "Gas Limit Error when deploy Truffle project on Private Network"
tags: [BlockChain]
---

The most annoying error ever when deploying contracts with truffle is:

```Error encountered, bailing. Network state unknown. Review successful transactions manually.```

`truffle migrate` might throw the above error if:

1. [`truffle.js` did not set a proper `gas` limit.](https://github.com/trufflesuite/truffle/issues/271)
2. forgot to unlock the main account: `Error: authentication needed: password or unlock`
3. wrong `from` account in `truffle.js`: `Error: unknown account`
4. forgot to open the RPC or the RPC port was incorrect: `Error: Invalid JSON RPC response: ""`

The first one is the tough error that this article intends to solve. The truffle version is v4.0.4.

1. TOC
{:toc}

Many solutions suggested that setting a good, large gas limit will solve the error forever. It is not the case for me and probably for many other developers actively building some dApps. However, with some experiments I found out that careful finetuning of the gas limit usually works.

# Two places to set gas limits

1. in `truffle.js`, under some network configuration there is `gas: 1000000,` the overall gas limit when deploying.
2. in migration file such as `2_deploy_contracts.js` there is `deployer.deploy(MyContract, {gas: 1000000});` the specific gas limit for each contract.

From my experience, we do not need to set any gas limit for small contracts in the migration file. We do normally need to set an overall gas limit in `truffle.js`, and a smaller gas limit for the large contracts to be deployed.

# Two stages of solution

Here we focus on two development stages when we encounter this gas limit related error: on local TestRPC and on private network.

## Ganache

First, we want to deploy on the local TestRPC, e.g. Ganache. 

If the error shows that your gas limit is too large: `Error: exceeds block gas limit`, what it actually tells us is that **it has calculated an appropriated block gas limit for us and we are going above it.** The block gas limit is supposed to be always enough, so although it is saying that gas limit set it `truffle.js` exceeds current block gas limit, it is actually telling us to **set the overall gas limit a little bit lower**.

On the other hand, if it tells us that the gas limit is too low: `Error: intrinsic gas too low`,
 it does not have enough gas to deploy the contract. When it does deploy the contract but used up its gas so it cannot **save** the contract (I guess), it will raise `Error: The contract code couldn't be stored, please check your gas amount.` In both cases, we should set a higher gas limit.

In this way, we can use binary search to find out the appropriate gas limit that pass the `truffle deploy`.

When the deployment succeeds, we can check the Blocks or Transactions panel in Ganache, where we can find the gas used during deployment. The gas used should be a bit lower than the appropriate gas limit you just found. 

## Private Network

Second, we want to deploy on a private network. Intuitively, the gas limit we have found when deploying to Ganache should work as well for the private network. 

It is true, when **the block gas limit is enough.** [check the gas limit](https://github.com/trufflesuite/truffle/issues/667#issuecomment-354311886) by `web3.eth.getBlock("pending").gasLimit`

If this gasLimit is larger than the appropriate value we have set for the local TestRPC, then it is easy: we just need to configure the gas limit exactly the same as your localRPC configuration, and it should works.

However, if it is not enough, we need to [increase the block’s gas limit](https://ethereum.stackexchange.com/questions/13730/how-to-increase-gas-limit-in-block-using-geth). Be patient since you need to mine a lot before your gas limit start to increase significantly. 

Although it is a quick fix, this increase in gas limit is both local and temporary, and you may need to do this over and over again. As an alternative, you may set a higher gas limit in your genesis file.

