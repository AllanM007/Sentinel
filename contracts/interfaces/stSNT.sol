// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


/// @title ERC20 Token
/// @author 0xAllan
/// @notice This token contract handles the staking token of the Sentinel protocol 
/// i.e minting/burning/redeeming/slashing
contract stSNT is ERC20 {

    string constant token = "stSNT";
    address private owner;

    constructor(uint _tokenAmount) ERC20("Staked Sentinel", "stSNT") {
        _mint(msg.sender, 1000);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender = owner, "OWNER_ONLY_FUNCTION");
        _;
    }

    function mintstSNT(uint _amount, address _recipient) onlyOwner() public returns (bool) {
        
        _mint(_recipient, _amount);

        return true;
    }

    function burnstSNT(uint _amount, address _recipient) onlyOwner() public returns (bool) {
        
        _burn(_recipient, _amount);

        return true;
    }

    function slashStSNT(address _provider, uint _amount) public returns (bool) {

        IERC20(address(this)).transferFrom(_provider, address(this));
        
        return true;
    }

    function redeemStSNT(address _provider, uint _amount) public returns (bool) {

        IERC20(address(this)).transferFrom(address(this), _provider);
        
        return true;
    }

}