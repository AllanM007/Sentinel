//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// import "hardhat/console.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

abstract contract Oracle{

    string public oracle;

    struct tokenPairs{
        uint256 id;
        string firstTokenName;
        string secondTokenName;
        uint256 tokenPairExchangeRate;
    }

    constructor(string storage _oracleName){
        oracle = _oracleName;
    }

    function newPair(
        uint256 firstToken,
        uint256 secondToken,
        uint256 pairExchange,
        uint256 trustLevel
    ) public pure returns (bool){
        return true;
    }

    function getPairExchangeRate(
        uint256 firstToken,
        uint256 secondToken
    ) public payable returns (bool){
        return true;
    }
}