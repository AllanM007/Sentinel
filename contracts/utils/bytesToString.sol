///SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract bytesToString {

    address immutable private utilAddress;

    constructor(){
        utilAddress = address(this);
    }

    function convertBtyesToString(bytes32 _bytes) private pure returns ( string memory ) {
        
    }
}