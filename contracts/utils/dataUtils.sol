// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract dataUtils {
    

    function varExists(
        uint256 _uniqueAddress,
        uint256[] memory addressArray
    ) public pure returns (bool) {
        for (uint i = 0; i < addressArray.length; i++) {
            if (addressArray[i] == _uniqueAddress) {
                return true;
            }
        }
        
        return false;
    }
}