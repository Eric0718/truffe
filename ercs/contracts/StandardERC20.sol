// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title ERC20Decimals
 * @dev Implementation of the ERC20Decimals. Extension of {ERC20} that adds decimals storage slot.
 */
abstract contract ERC20Decimals is ERC20 {
    uint8 immutable private _decimals;

    /**
     * @dev Sets the value of the `decimals`. This value is immutable, it can only be
     * set once during construction.
     */
    constructor (uint8 decimals_) {
        _decimals = decimals_;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
}

// File: contracts/service/ServicePayer.sol



pragma solidity ^0.8.0;

interface IPayable {
    function pay(string memory serviceName) external payable;
}

/**
 * @title ServicePayer
 * @dev Implementation of the ServicePayer
 */
abstract contract ServicePayer {

    constructor (address payable receiver, string memory serviceName) payable {
        IPayable(receiver).pay{value: msg.value}(serviceName);
    }
}

// File: contracts/token/ERC20/StandardERC20.sol



pragma solidity ^0.8.0;



/**
 * @title StandardERC20
 * @dev Implementation of the StandardERC20
 */
contract StandardERC20 is ERC20Decimals, ServicePayer {

    constructor (
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initialBalance_,
        address payable feeReceiver_
    )
        ERC20(name_, symbol_)
        ERC20Decimals(decimals_)
        ServicePayer(feeReceiver_, "StandardERC20")
        payable
    {
        require(initialBalance_ > 0, "StandardERC20: supply cannot be zero");

        _mint(_msgSender(), initialBalance_);
    }

    function decimals() public view virtual override returns (uint8) {
        return super.decimals();
    }
}

//useful erc20 contract
pragma solidity ^0.8.7;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    constructor(uint _totalSuperNum) ERC20("MyToken","MTK") {
        _mint(msg.sender,_totalSuperNum);
    }

}