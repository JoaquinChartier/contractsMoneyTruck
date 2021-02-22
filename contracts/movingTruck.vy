# @version 0.2.8

interface ERC20Token:
    def transferFrom(sender: address, recipient: address, amount: uint256): nonpayable
    def balanceOf(sender: address) -> uint256: nonpayable 

token: ERC20Token

@payable
@external
def move(tokenAddressArray: address[20], tokenAmountArray: uint256[20], recipient: address):
    assert not (recipient == self)
    for i in range(20):
        tokenAddress: address = tokenAddressArray[i]
        amount: uint256 = tokenAmountArray[i]
        if (tokenAddress != ZERO_ADDRESS and amount != 0):
            self.token = ERC20Token(tokenAddress)
            assert self.token.balanceOf(msg.sender) >= amount * 10 ** 18
            self.token.transferFrom(msg.sender, recipient, amount * 10 ** 18)
    if (msg.value > 0):
        send(recipient, msg.value)