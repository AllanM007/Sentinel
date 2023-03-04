//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


import "hardhat/console.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract Aggregator {

    address governanceTokenAddress;
    address[] public members;
    mapping( uint256 => proposal) public proposalId;
    mapping (uint256 => uint) public proposalTime;
    mapping (uint => uint) public proposalVote;

    struct aggregateMetaData {
        uint id;
        address aggregateSourceAddress;
        string firstTokenName;
        string secondTokenName;
        string dataSource;
        uint256 aggregateDeadlineTimestamp;
        uint256 tokenPairExchangeRate;
        bool status;
    }

    aggregateMetaData aggregate;

    /// @notice Event triggered when a aggregation is started for a feed
    event aggregateStarted(address proposer, uint256 aggregateId);
    
    /// @notice Event triggered when an aggregation is completed for a feed
    event aggregateCompleted(address proposalVoter, uint256 aggregateId);
    
    /// @notice Event triggered when an aggregation for a feed ends/cancelled/aggregation time expires
    event aggregateDeactivated(uint256 aggregateId);

    /// @notice Event triggered when an aggregation for a feed fails
    event aggregateFailed(uint256 aggregateId);

    constructor(address _govTokenAddress){
        governanceTokenAddress = _govToken;
        genesisTimeStamp = block.timestamp;
    }

    /// @notice new proposals to add a token pair feed to the oracle
    /// @dev metadata such as url,api key
    /// @param Documents a parameter just like in doxygen (must be followed by parameter name)
    /// @return Documents the return variables of a contract’s function state variable
    function newAggregation(uint256 _firstToken, uint256 _secondToken, uint256 _pairExchange, string _proposerName, uint256 trustLevel) public returns (bool){
        noOfProposals ++;

        proposal.id = noOfProposals;
        proposal.proposerName = _proposerName;
        proposal.proposerAddress = msg.sender;
        proposal.proposalTimestamp = block.timestamp;
        proposal.status = true;
        proposal.firstToken = firstToken;

        return true;
    }

    function getAggregation(uint256 _aggregationId) public pure returns ( aggregateMetaData memory ){
        return aggregateId[_aggregationId];
    }

    // function voteProposal(uint256 _proposalId, uint256 vote) public payable returns (bool){
    //     require(10000000000000000  > msg.value, "Insufficient proposal stake amount!!");
    //     IERC20(governanceTokenAddress).transferFrom(msg.sender, address(this), 10000000000000000);

    //     if (vote == true) {
    //         proposal[_proposalId].forVotes ++;
    //     } else {
    //         proposal[_proposalId].againstVotes ++;
    //     }

    //     return true;
    // }

    function cancelAggregation(uint256 _aggregationId) public returns (bool){
        currentAggregation = aggregationMetaData[id] = _aggregationId;
        currentAggregation.status = false;
        return true;
    }

    function deactivateAggregation(uint256 _aggregationId) public returns (bool){
        uint256 currentTime = aggregateMetaData[_aggregationId].expiryDate;

        if (block.timestamp > currentTime) {
            aggregateMetaData[_aggregationId].status = false;
        } 
        else {
            aggregateMetaData[_aggregationId].status = true;
        }
        currentAggregation = aggregateMetaData[id] = _aggregationId;
        currentAggregation.status = false;
        return true;
    }
}