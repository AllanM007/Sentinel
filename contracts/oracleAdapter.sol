//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./aggregatorAdapter.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract Oracle {

    struct tokenPairs {
        uint id;
        string firstTokenName;
        string secondTokenName;
        uint tokenPairExchangeRate;
    }

    constructor(){}

    function newPair(
        uint firstToken,
        uint secondToken,
        uint pairExchange,
        uint trustLevel
    ) public pure returns (bool){
        return true;
    }

    function getPairExchangeRate(
        uint _oracleId,
        uint firstToken,
        uint secondToken
    ) public payable returns (bool){
        return true;
    }
}