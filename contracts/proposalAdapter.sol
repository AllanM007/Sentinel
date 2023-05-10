//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


// import "hardhat/console.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract Proposal {

    address governanceTokenAddress;
    address[] public members;
    uint256 public genesisTimeStamp;
    uint256 noOfProposals;
    mapping( uint256 => proposalMetaData) public proposalId;
    mapping (uint256 => uint) public proposalTime;
    mapping (uint => uint) public proposalVote;

    struct proposalMetaData {
        uint256 id;
        string proposerName;
        address proposerAddress;
        address firstToken;
        address secondToken;
        string dataSource;
        // string apiKey;
        uint256 proposalTimestamp;
        uint256 tokenPairExchangeRate;
        uint256 forVotes;
        uint256 againstVotes;
        uint256 expiryDate;
        bool status;
    }

    proposalMetaData proposal;

    /// @notice Event triggered when a proposal is raised for a new feed
    event proposalRaised(address proposer, uint256 proposalId);
    
    /// @notice Event triggered when a vote is casted for an active proposal of a new feed
    // event proposalVote(address proposalVoter, uint256 proposalId);
    
    /// @notice Event triggered when a proposal for a new ends/cancelled/participation time expires
    event proposalDeactivated(uint256 proposalId);

    constructor(address _govTokenAddress){
        governanceTokenAddress = _govTokenAddress;
        genesisTimeStamp = block.timestamp;
    }

    /// @notice new proposals to add a token pair feed to the oracle
    /// @dev metadata such as url,api key
    /// @return the return variables of a contract’s function state variable
    function newProposal(
        address _firstToken,
        address _secondToken,
        uint256 _pairExchange,
        string memory _proposerName,
        uint256 trustLevel
    ) public returns (bool){
        noOfProposals ++;

        proposal.id = noOfProposals;
        proposal.proposerName = _proposerName;
        proposal.proposerAddress = msg.sender;
        proposal.proposalTimestamp = block.timestamp;
        proposal.status = true;
        proposal.firstToken = _firstToken;

        return true;
    }

    function getProposal(uint256 _proposalId) public view returns ( proposalMetaData memory ){
        return proposalId[_proposalId];
    }

    function voteProposal(uint256 _proposalId, uint256 vote) public payable returns (bool){
        require(10000000000000000  > msg.value, "Insufficient proposal stake amount!!");
        IERC20(governanceTokenAddress).transferFrom(msg.sender, address(this), 10000000000000000);

        // if (vote == true) {
        //     proposal[_proposalId].forVotes ++;
        // } else {
        //     proposal[_proposalId].againstVotes ++;
        // }

        return true;
    }

    function cancelProposal(uint256 _proposalId) public returns (bool){
        // currentProposal = proposalMetaData[id] = _proposalId;
        // currentProposal.status = false;
        return true;
    }

    // function deactivateProposal(uint256 _proposalId) public returns (bool){
    //     uint256 currentTime = proposalMetaData[_proposalId].expiryDate;

    //     if (block.timestamp > currentTime) {
    //         proposalMetaData[_proposalId].status = false;
    //     } 
    //     else {
    //         proposalMetaData[_proposalId].status = true;
    //     }
    //     // currentProposal = proposalMetaData[id] = _proposalId;
    //     // currentProposal.status = false;
    //     return true;
    // }
}