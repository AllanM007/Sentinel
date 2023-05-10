// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { SafeMath } from "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract safeMath {

    using SafeMath for uint;
    constructor (){}

    function add(uint a, uint b) private pure returns(uint c) {
        c = SafeMath.add(a, b);

        return c;
    }

    function sub(uint a, uint b) private pure returns (uint c) {
        c = SafeMath.sub(a, b);

        return c;
    }

    function mul(uint a, uint b) private pure returns (uint c) {
        c = SafeMath.mul(a, b);

        return c;
    }

    function div(uint a, uint b) private pure returns (uint c) {
        c = SafeMath.div(a, b);

        return c;
    }
}