from brownie import *

tokenAmountList = [10,10,10,10,10,10,10,10,10,10]
addressList = []

def main():
    #Fill array with empty addresses
    for i in range(10):
        addressList.append('0x0000000000000000000000000000000000000000')

    #Deploy contract
    t = accounts[0].deploy(movingTruck)

    #Deploy 10 tokens and approve them
    for i in range(7):
        a = accounts[0].deploy(ERC20Preset, 'Argenpeso', 'ARG', 18, 20000)
        addressList[i] = a.address
        a.approve(t.address, 100 * 10 ** 18)
    
    #print(addressList)

    #Execute moving
    e = t.move(addressList, tokenAmountList, accounts[1].address)
    #print balance to check //10000000000000000000
    print(a.balanceOf(accounts[1]))