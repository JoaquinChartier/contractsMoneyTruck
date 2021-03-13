# @version 0.2.8

interface ERC20Token:
    def transferFrom(sender: address, recipient: address, amount: uint256): nonpayable
    def balanceOf(sender: address) -> uint256: nonpayable 

token: ERC20Token
owner: address

@external
def __init__():
    #Set owner address
    self.owner = msg.sender

@external
def extractTips():
    #Extract the tips to owner address
    assert self.balance > 0
    send(self.owner, self.balance)

@payable
@external
def move(tokenAddressArray: address[20], tokenAmountArray: uint256[20], recipient: address, sendTip: bool):
    #Prevent sending funds to bad places
    assert not (recipient == self)
    #Iterate X times
    for i in range(20):
        tokenAddress: address = tokenAddressArray[i]
        amount: uint256 = tokenAmountArray[i]
        #If everything is OK, move tokens
        if (tokenAddress != ZERO_ADDRESS and amount != 0):
            self.token = ERC20Token(tokenAddress)
            assert self.token.balanceOf(msg.sender) >= amount
            self.token.transferFrom(msg.sender, recipient, amount)
    #Move ETH, if tip == True, move tip to contract balance
    if (msg.value > 0):
        if (sendTip):
            send(recipient, msg.value - (msg.value * 1 / 100))
        else:
            send(recipient, msg.value)