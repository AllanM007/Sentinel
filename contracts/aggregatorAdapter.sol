//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


// import "hardhat/console.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import './proposalAdapter.sol';

/// @title Price Aggregator Contract
/// @author 0xAllan
/// @notice This contract handles the aggregation of different prices from data providers to set the optimal ratio

contract Aggregator {

    string constant public name = "Sentinel Aggregator";

    // address public governanceTokenAddress;

    struct aggregateMetaData {
        uint id;
        string firstTokenName;
        string secondTokenName;
        address[] dataProviders;
        uint256 aggregateDeadlineTimestamp;
        uint256 tokenPairExchangeRate;
        bool status;
    }

    struct tokenExchangeRatio {
        uint256 tokenA;
        uint256 tokenB;
        uint256 expiry;
    }

    uint256[] private providerIds;

    uint256[] private tokenAArray;
    uint256[] private tokenBArray;

    mapping(uint256 => uint256[]) private pairTokenA;
    mapping(uint256 => uint256[]) private pairTokenB;

    // mapping (uint256 => uint) public aggregationTime;
    // mapping (uint => uint) public aggregationAnswer;

    uint256 public noOfAggregations;

    uint256 public noOfPairs;

    mapping(uint256 => tokenExchangeRatio) public pairRatio;

    mapping(uint256 => tokenExchangeRatio) public providerRatio;

    aggregateMetaData internal aggregate;


    /// @notice Event triggered when a aggregation is started for a feed
    event aggregateStarted(address proposer, uint256 aggregateId);
    
    /// @notice Event triggered when an aggregation is completed for a feed
    event aggregateCompleted(address proposalVoter, uint256 aggregateId);
    
    /// @notice Event triggered when an aggregation for a feed ends/cancelled/aggregation time expires
    event aggregateDeactivated(uint256 aggregateId);

    /// @notice Event triggered when an aggregation for a feed fails
    event aggregateFailed(uint256 aggregateId);

    constructor(){}

    // function getPairs() view public returns () {}

    function recievePrice(
        uint256 _providerId,
        uint256 _pairId,
        uint256 _tokenA,
        uint256 _tokenB,
        uint256 _timeStamp
    ) public returns (bool) {

        require(_timeStamp > block.timestamp, "INVALID_TIME_FEED");

        uint256 priceExpiry = _timeStamp + 15 minutes;

        providerRatio[_providerId] = tokenExchangeRatio(_tokenA, _tokenB, priceExpiry);

        pairRatio[_pairId] = tokenExchangeRatio(_tokenA, _tokenB, priceExpiry);

        tokenAArray.push(_tokenA);
        tokenBArray.push(_tokenB);

        return true;  
    }

    /// @notice new proposals to add a token pair feed to the oracle
    /// @dev metadata such as url,api key
    function newAggregationPrice(
        uint256 pairId,
        uint256 _firstTokenId,
        uint256 _secondTokenId,
        uint256[] memory _pairRatio,
        uint256 _proposerId,
        uint256 timeStamp
    ) public returns (bool){
        noOfAggregations ++;

        return true;
    }

    function calculateAggregate(
        uint256[] memory array
    ) public pure returns (uint256) {
        uint256 answer = 9;
        return answer;
    }

}