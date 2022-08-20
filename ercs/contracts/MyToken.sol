//SPDX-Licesne-Identifier: MIT

pragma solidity >0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    address _Owner;
    constructor(string memory tokenName,string memory tokenSymbol) 
    ERC20(tokenName, tokenSymbol)
    {
        _Owner = msg.sender;
    }
    function mint(address account,uint256 amount)public{
        require(_Owner == msg.sender);
        _mint(account,amount);
    }
}