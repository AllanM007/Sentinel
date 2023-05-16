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

    // address public governanceToken0ddress;

    struct aggregateMetaData {
        uint id;
        string firstTokenName;
        string secondTokenName;
        address[] dataProviders;
        uint aggregateDeadlineTimestamp;
        uint tokenPairExchangeRate;
        bool status;
    }

    struct tokenExchangeRatio {
        uint token0;
        uint token1;
        uint expiry;
    }

    uint[] private providerIds;

    uint[] private token0Array;
    uint[] private token1Array;

    mapping(uint => uint[]) private pairToken0;
    mapping(uint => uint[]) private pairToken1;

    // mapping (uint => uint) public aggregationTime;
    // mapping (uint => uint) public aggregationAnswer;

    // uint public noOfAggregations;

    uint public noOfPairs;

    mapping(uint => tokenExchangeRatio) public pairRatio;

    mapping(uint => tokenExchangeRatio) public providerRatio;

    aggregateMetaData internal aggregate;

    /// @notice Event triggered when a aggregation is started for a feed
    event aggregateStarted(address proposer, uint aggregateId);
    
    /// @notice Event triggered when an aggregation is completed for a feed
    event aggregateCompleted(address proposalVoter, uint aggregateId);
    
    /// @notice Event triggered when an aggregation for a feed ends/cancelled/aggregation time expires
    event aggregateDeactivated(uint aggregateId);

    /// @notice Event triggered when an aggregation for a feed fails
    event aggregateFailed(uint aggregateId);

    constructor(){}

    // function getPairs() view public returns () {}

    function recievePrice(
        uint _providerId,
        uint _pairId,
        uint _token0,
        uint _token1,
        uint _timeStamp
    ) public returns (bool) {

        require(_timeStamp > block.timestamp, "INVALID_TIME_FEED");

        uint priceExpiry = _timeStamp + 15 minutes;

        providerRatio[_providerId] = tokenExchangeRatio(_token0, _token1, priceExpiry);

        pairRatio[_pairId] = tokenExchangeRatio(_token0, _token1, priceExpiry);

        token0Array.push(_token0);
        token1Array.push(_token1);

        return true;  
    }

    /// @notice new proposals to add a token pair feed to the oracle
    function newAggregationPrice(
        uint _pairId,
        uint[] memory _pairRatio,
        uint _providerId,
        uint _timeStamp
    ) public returns (bool){

        uint token0;
        uint token1;

        providerRatio[_providerId] = tokenExchangeRatio(_pairRatio[0], _pairRatio[1], 1);

        if (15 >= token0Array.length || 15 >= token1Array.length ) {
            token0Array.push(_pairRatio[0]);
            token1Array.push(_pairRatio[1]);

        } else {

            token0Array.push(_pairRatio[0]);
            token1Array.push(_pairRatio[1]);
            
            token0 = calculateAggregate(token0Array);
            token1 = calculateAggregate(token1Array);

            uint expiry = _timeStamp + 15 minutes;

            pairRatio[_pairId] = tokenExchangeRatio(token0, token1, expiry);
            
        }
        
        return true;
    }

    function calculateAggregate(
        uint[] memory array
    ) public pure returns (uint) {
        uint answer = 9;
        return answer;
    }

    function checkDeviation(
        uint[] memory _tokenArray,
        uint _providerId
    ) private pure returns(uint){

        if (_tokenArray.length > 3) {
            for (uint index = 0; index < _tokenArray.length; index++) {
                
            }
        } else {
            
        }
    }

function getMedian(uint[] memory data) public pure returns (uint) {
    require(data.length > 0, "Array must not be empty");
    uint[] memory sortedData = sort(data);
    uint middleIndex = sortedData.length / 2;
    if (sortedData.length % 2 == 0) {
        // Average of middle two numbers if array length is even
        return (sortedData[middleIndex - 1] + sortedData[middleIndex]) / 2;
    } else {
        // Middle number if array length is odd
        return sortedData[middleIndex];
    }
}

function sort(uint[] memory data) internal pure returns (uint[] memory) {
    if (data.length == 0) {
        return data;
    } else {
        // Sort array using bubble sort
        for (uint i = 0; i < data.length - 1; i++) {
            for (uint j = i + 1; j < data.length; j++) {
                if (data[i] > data[j]) {
                    uint temp = data[i];
                    data[i] = data[j];
                    data[j] = temp;
                }
            }
        }
        return data;
    }
}


}