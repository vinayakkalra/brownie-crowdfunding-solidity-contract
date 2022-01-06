# Simple Crowdfunding Contract using Solidity

A simple crowdfunding contract made using solidity and brownie to deploy on EVM compatible chains. This contract makes use of chainlink AggregatorV3Interface to get the dollar data.

The logical use case of this contract is to gather funds in this contract from friends and family. Only the owner of the contract will be able to withdraw the funds deposited in the contract. We are making use of chainlink to make sure that any given time, the amount of ETH deposited is greater than 50$. The check of the dollar amount is happening using chainlink.

## Code Walkthorugh

1. You can find the FundMe.sol in the contracts folder. contract/tests contain the mock contract for AggregatorV3Interface
2. You can find the scripts in the scripts folder. Use the deploy.py script for deployment of contracts on the network chosen. Use fund_and_withdraw.py to test the funding of the contract and withrdrawal to the owner account

To run the deploy script use:

```
brownie run scripts/deploy.py
```

Todo: create tests for the funding contract and try funding in ERC20 tokens as well.

