// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


/// @title ERC20 Token
/// @author 0xAllan
/// @notice This token contract handles the governance of the Sentinel protocol i.e minting/burning
contract SNT is ERC20 {

    string constant token = "SNT";

    constructor(uint _tokenAmount) ERC20("Sentinel", "SNT") {
        _mint(msg.sender, 1000);
        // owner() = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender = owner(), "OWNER_ONLY_FUNCTION");
        _;
    }

    function mintSNT(uint _amount, address _recipient) onlyOwner() returns (bool) {
        
        _mint(_recipient, _amount);

        return true;
    }

    function burnSNT(uint _amount, address _recipient) onlyOwner() returns (bool) {
        
        _burn(_recipient, _amount);

        return true;
    }
    
}