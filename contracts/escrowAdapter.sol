//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title Escrow contract that facilitates token locking and transfer in cases of mischief/incorrect data
/// @author 0xAllan
/// @dev Explain to a developer any extra details

contract Escrow {

    address transactionToken;

    struct requestData {
        uint id;
        uint256 reqAmount;
        // address requestOrigin;
        address oracleOrigin;
        uint256 disputeDeadline;
        bool status;
    }

    requestData[] public requestDeposits;

    mapping(uint256 => requestData) reqData;

    constructor(address _txToken) {
        transactionToken = _txToken;
    }

    /// @notice This is a payable function that recieves the requester/oracle stake and verifies stake amount/oracle and requester addresses
    /// @return Returns a boolean value if the transaction is completed succesfully
    function requestDeposit(address _oracleAddress, uint _amount, uint256 _timeStamp) public payable returns( bool ){
        
        //minimum data provider staking amount requirement check
        require(10000000000000000  > _amount, "INSUFFICIENT_REQUEST_STAKE_AMOUNT!!");
       
        // transfer stake from data provider to escrow contract
        IERC20(transactionToken).transferFrom(msg.sender, address(this), _amount);

        //get escrow reqests array last item index
        uint256 escrowRequestsLength = requestDeposits.length - 1;

        //get last escrow request item
        requestData memory lastEscrowRequest = requestDeposits[escrowRequestsLength];

        //set expiry time for dispute 3 days after amount is staked in escrow
        uint256 disputeExpiryDeadline = _timeStamp + 3 days;

        //add new data provider escrow request to requests array
        requestDeposits.push(requestData(lastEscrowRequest.id++, _amount, _oracleAddress, disputeExpiryDeadline, true));

        //succesful escrow stake by data provider
        return true;
    }

    /// @notice this function withdraws a user/oracle's stake after a succesful transaction occurs and expiry time has passed
    function requestWithdrawal(uint _requestId, uint256 _requestExpiryTimestamp, uint256 _withdrawalAmount) public returns (bool) {
        require(block.timestamp > _requestExpiryTimestamp, "REQUEST_TIME_EXPIRY_NOT_YET" );
        requestData storage reqOracle = reqData[_requestId];
        
        // in future acceptance of different tokens aside from chain's native token
        // uint contractTokenBalance =  IERC20(<tokenAddress>).balanceOf(address(this));
        
        require(_withdrawalAmount > address(this).balance, "Withdrawal amount can't be greater than contract balance");
        IERC20(transactionToken).transferFrom(address(this), reqOracle.oracleOrigin, reqOracle.reqAmount);

        return true;
    }

    /// @notice this function slashes the stake of a requester when they dispute a valid data feed.
    /// Not sure about this yet
    // function slashRequesterStake(uint _requestId) public returns (bool) {
    //     requestData storage reqObject = reqData[_requestId];
    //     uint256 slashAmount = reqObject.reqAmount * 60 / 100;
    //     IERC20(transactionToken).transferFrom(address(this), reqObject.oracleOrigin, slashAmount);

    //     return true;
    // }


    /// @notice this function slashes an oracle's stake when a mischief/bad feed occurs and is validated by the disputeAdapter
    function slashOracleStake(uint _requestId) public returns(bool){
        requestData storage reqObject = reqData[_requestId];
        uint256 slashAmount = reqObject.reqAmount * 60 / 100;
        IERC20(transactionToken).transferFrom(address(this), reqObject.oracleOrigin, slashAmount);

        return true;
    }
}
