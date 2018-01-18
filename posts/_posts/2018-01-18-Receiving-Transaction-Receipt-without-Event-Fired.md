---
layout: post
title: "Receiving Transaction Receipt without Event Fired"
tags: [BlockChain]
---

Since Web3 1.0.0 (currently beta.27) you can integrate the process of 

1. sending a transaction
2. handling the emitted events of the mined transaction 

together nicely as the following 

```
someContractInstance.methods[someMethodName](...args).send({ gas: someGasLimit })
  .on('transactionHash', function (txHash) {
	// after transaction sent and before transaction mined.
  })
  .on('receipt', function (receipt) {
	// after transaction mined.
	// if transaction fired some event, you can find the event return values in 
	console.log(receipt.events[someEventName].returnValues)
  })
  .on('error', console.error)
```

However, yesterday after I deployed a contract on a private network, I encountered the following error:

``` 
Error: Transaction was not mined within 50 blocks, please make sure your transaction was properly send. Be aware that it might still be mined!
```

With some debugging, I found out that `receipt.events[someEventName]` was null, which caused the problem.

However, the script did not raise some error like `Cannot read property 'returnValues' of null` (which I believe should be the correct and direct error message). 
Instead it stopped there, and triggered the `on('receipt', ...)` again, and until it repeated for 50 times, it raised the `Transaction was not mined within 50 blocks` error.

Since the `on('receipt', ...)` should not be triggered until the transaction is actually *mined and executed*, the event was not fired probably because the gas was used up before the miner reached the `Event` statement in the contract.

After I raised the gas limit, the problem solved, and indeed the receipt showed that I used 250,000 gas, which was higher than the 200,000 gas limit I set.

