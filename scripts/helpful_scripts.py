from brownie import MockV3Aggregator, config, network, accounts
from web3 import Web3

DECIMALS=8
STARTING_PRICE=200000000000
LOCAL_BLOCKCHAIN_ENV = ["development", "ganache-local"]
FORKED_LOCAL_ENV = ["mainnet-fork", "mainnet-fork-dev"]

def get_account():
    if network.show_active() in LOCAL_BLOCKCHAIN_ENV or network.show_active in FORKED_LOCAL_ENV:
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])

def deploy_mocks():
    print(f"The active network is {network.show_active()}")
    print("Deploying mocks")
    if len(MockV3Aggregator)<=0:
        mock = MockV3Aggregator.deploy(DECIMALS, STARTING_PRICE, {"from": get_account()})
        print("Deployed")