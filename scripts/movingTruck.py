from brownie import *
import random

tokenAmountList = []
addressList = []

def main():
    #Fill array amounts
    for i in range(20):
        tokenAmountList.append(random.randint(10,20))

    #Fill array with empty addresses
    for i in range(20):
        addressList.append('0x0000000000000000000000000000000000000000')

    #Deploy contract
    t = accounts[0].deploy(movingTruck)

    #Deploy 10 tokens and approve them
    for i in range(5):
        a = accounts[0].deploy(ERC20Preset, 'Argenpeso', 'ARG', 18, 20000)
        addressList[i] = a.address
        a.approve(t.address, 1000 * 10 ** 18)
    
    #print(addressList)

    #Execute moving
    e = t.move(addressList, tokenAmountList, accounts[1].address, True, {'amount':1000000000000000000})
    #print balance to check //10000000000000000000
    print(a.balanceOf(accounts[1]))
    print(accounts[1].balance())
    print(t.balance())

    t.extractTips()
    print(accounts[0].balance())