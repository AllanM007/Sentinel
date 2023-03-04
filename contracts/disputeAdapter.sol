//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


import "hardhat/console.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

abstract contract Dispute{
    
    mapping (uint256 => uint) public disputeTime;
    mapping (uint => uint) public disputeVote;

    struct disputeMetaData {
        uint256 id;
        string disputeName;
        address disputeAddress;
        string dataSource;
        uint256 tokenPairExchangeRate;
        bool status;
    }

    disputeMetaData dispute;

    /// @notice Event triggered when a dispute is raised on a bad feed
    event disputeRaised(address disputeRaiser, address disputeSource, uint256 disputeSourceId);

    /// @notice Event triggered when a dispute is paused on a bad feed
    event disputePaused(address disputeRaiser, address disputeSource, uint256 disputeSourceId);
    
    /// @notice Event triggered when a dispute is resolved on a disputed bad feed
    event disputeResolved(address disputeRaiser, address disputeSource, uint256 disputeSourceId, bool disputOutcome);

    constructor(){
        disputeTime = block.timestamp;
    }

    function newDispute(uint256 firstToken, uint256 secondToken, uint256 pairExchange) public pure returns (bool){
        return true;
    }

    function voteDispute(uint256 firstToken, uint256 secondToken) public payable returns (bool){
        return true;
    }

    // function delegateVotedispute(uint256 disputeId, uint256 secondToken) public payable returns (bool){
    //     return true;
    // }

    function deactivateDispute(uint256 disputeId) public payable returns (bool){
        currentdispute = disputeMetaData[id] = disputeId;
        currentdispute.status = false;
        return true;
    }
}