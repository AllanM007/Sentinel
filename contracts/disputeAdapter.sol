//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title DisputeAdapter Contract
/// @author 0xAllan
/// @notice This contract handles creation/voting/disableing of disputes on invalid
/// data from providers

contract Dispute {
    
    uint public disputesNo;

    struct disputeMeta {
        uint256 id;
        address tokenA;
        address tokenB;
        address disputerAddress;
        uint providerId;
        uint256 tokenPairExchangeRate;
        uint forVotes;
        uint againstVotes;
        uint timeStamp;
        bool status;
    }

    mapping(uint256 => disputeMeta) public dispute;

    disputeMeta[] public disputes;

    // disputeMeta public dispute;

    address voteToken;

    address stakingToken;

    /// @notice Event triggered when a dispute is raised on a bad feed
    event disputeRaised(address disputeOriginator, uint256 disputeSourceId);
    
    /// @notice Event triggered when a dispute is resolved on a disputed bad feed
    event disputeResolved(address disputeOriginator, uint256 disputeSourceId, bool disputeOutcome);

    constructor(address _votingToken){
        voteToken = _votingToken;
    }

    function newDispute (
        address firstToken,
        address secondToken,
        uint256 pairExchangeRate,
        uint timeStamp,
        uint _providerId
    ) public returns (bool){

        uint256 disputeBalance = IERC20(stakingToken).balanceOf(msg.sender);

        require(1e18 > disputeBalance, "INSUFFICIENT_STAKE_AMOUNT");

        //get last index of disputes array
        uint256 disputesLength = disputes.length - 1;
        
        //intiate disputeMeta Object for last dispute raised
        disputeMeta memory lastDispute  = dispute[disputesLength];

        //address can only have one active dispute
        // A disputer can't submit a dispute while another is pending 
        require(msg.sender == lastDispute.disputerAddress, "INVALID_DISPUTER");

        //new dispute is added to disputes array for mediation
        disputes.push(
            disputeMeta(1, firstToken, secondToken, msg.sender, _providerId, pairExchangeRate, 0, 0, timeStamp, true)
        );

        //increment no of disputes
        disputesNo++;

        emit disputeRaised(msg.sender, _providerId);

        return true;
    }

    function voteDispute(uint256 _disputeId, bool _vote, uint256 _voteAmount) public returns (bool){

        // transfer voting stake to contract
        IERC20(voteToken).transferFrom(msg.sender, address(this), _voteAmount);

        disputeMeta memory activeDispute = disputes[_disputeId];

        require(activeDispute.status == true, "INACTIVE_DISPUTE");

        if (_vote) {
            activeDispute.forVotes++;
        } else {
            activeDispute.againstVotes++;
        }

        // require(_voteAmount > 1e18, "LOW_VOTE_AMOUNT");

        return true;
    }

    // function delegateVotedispute(uint256 disputeId, uint256 secondToken) public payable returns (bool){
    //     return true;
    // }

    function deactivateDispute(uint256 _disputeId) public payable returns (bool){
       disputeMeta storage currentdispute = dispute[_disputeId]; 
       
       currentdispute.status = false;

       bool disputeOutcome;

       if (currentdispute.forVotes > currentdispute.againstVotes) {
        disputeOutcome = true;
       } else {
        disputeOutcome = false;
       }

       emit disputeResolved(currentdispute.disputerAddress, currentdispute.providerId , disputeOutcome);
        
        return true;
    }
}