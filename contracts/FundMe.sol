// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public funders;
    address public owner;
    address[] fundersArray;
    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) public {
        priceFeed = AggregatorV3Interface(_priceFeed);
        owner = msg.sender;
    }

    function fund() public payable {
        uint256 minimumValue = 50 * 10**18;
        require(
            getConversionRate(msg.value) >= minimumValue,
            "Need to spend more ETH"
        );
        funders[msg.sender] += msg.value;
        fundersArray.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
    }

    function getConversionRate(uint256 eth) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        return (eth * ethPrice) / 1000000000000000000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an Owner");
        _;
    }

    function withdraw() public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
        for (
            uint256 funderIndex = 0;
            funderIndex < fundersArray.length;
            funderIndex++
        ) {
            funders[fundersArray[funderIndex]] = 0;
        }
        fundersArray = new address[](0);
    }

    function getEntranceFees() public view returns (uint256) {
        uint256 minimumUsd = 50 * 10**18;
        uint256 price = getPrice();
        uint256 precesion = 1 * 10**18;
        return (minimumUsd * precesion) / price;
    }
}
