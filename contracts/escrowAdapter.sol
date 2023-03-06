//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Escrow {

    address transactionToken;

    struct requestData {
        uint id;
        uint256 reqAmount;
        address requestOrigin;
        address oracleOrigin;
        uint256 disputeDeadline;
        bool status;
    }

    requestData reqData;

    constructor(address _txToken) {
        transactionToken = _txToken;
    }

    function requestDeposit(address _requestOrigin, uint _amount, uint256 _timeStamp) public payable returns( bool ){
        // require(10000000000000000  > _amount, "Insufficient request stake amount!!");
        IERC20(transactionToken).transferFrom(msg.sender, address(this), _amount);

        return true
    }

    function requestWithdrawal(uint _requestId) returns (bool) {
        reqOracle = reqData[_requestId]
        IERC20(transactionToken).transferFrom(address(this), reqOracle.oracleOrigin, reqOracle.reqAmount);

        return true;
    }

    function slashRequesterStake(uint _requestId) {
        reqObject = reqData[_requestId]
        uint256 slashAmount = reqOracle.reqAmount * 60 / 100
        IERC20(transactionToken).transferFrom(address(this), reqObject.oracleOrigin, reqOracle.reqAmount);

        return true;
    }

    function slashOracleStake(uint _requestId) public returns(bool){
        reqObject = reqData[_requestId]
        uint256 slashAmount = reqOracle.reqAmount / * 60 / 100
        IERC20(transactionToken).transferFrom(address(this), reqObject.oracleOrigin, reqOracle.reqAmount);

        return true;
    }
}
