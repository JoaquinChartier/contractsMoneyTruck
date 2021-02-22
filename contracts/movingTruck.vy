# @version 0.2.8

interface ERC20Token:
    def transferFrom(sender: address, recipient: address, amount: uint256): nonpayable

token: ERC20Token

@external
def move(tokenAddressArray: address[10], tokenAmountArray: uint256[10], recipient: address):
    emptyAddress: address = empty(address)
    for tokenAddress in tokenAddressArray:
        if (tokenAddress != emptyAddress):
            self.token = ERC20Token(tokenAddress)
            #assert self.token
            self.token.transferFrom(msg.sender, recipient, 10 * 10 ** 18)