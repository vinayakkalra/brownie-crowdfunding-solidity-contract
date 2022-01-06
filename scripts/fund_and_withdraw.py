from brownie import FundMe, config, network
from scripts.helpful_scripts import get_account

def fund():
    fund_me = FundMe[-1]
    account = get_account()
    entrance_fees = fund_me.getEntranceFees()
    print(entrance_fees)
    fund_me.fund({"from":account, "value": entrance_fees})

def withdraw():
    fund_me = FundMe[-1]
    account = get_account()
    fund_me.withdraw({"from":account})


def main():
    fund()
    withdraw()
