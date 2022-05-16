// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {

    //address[] public funders;
    
    uint public numOfFunders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    modifier limitWithdraw(uint withdrawAmount) {
        require(
            withdrawAmount <= 1000000000000000000, 
            "Cannot withdraw more than 1 ether"
            );
        _;
    }

    function test1() external onlyOwner {
        // some admin management stuff
    }

    function test2() external onlyOwner {
        // some admin management stuff
    }

    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }
    // no function name specified - this will be called
    // external - part of contract interface, 
    // could be called from other contracts and txs
    receive() external payable {}

    function emitLog() public override pure returns(bytes32) {
        return "Hello world";
    }

    function addFunds() external override payable {
        //funders.push(msg.sender);
        address funder = msg.sender;
        if(!funders[funder]) {
            uint index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function withdraw(uint withdrawAmount) external override limitWithdraw (withdrawAmount) {        
        payable(msg.sender).transfer(withdrawAmount);
    }
    // function getAllFunders() public view returns(address[] memory) {
    //     return funders;
    // }
    function getAllFunders() external view returns(address[] memory) {
        address[] memory _funders = new address[](numOfFunders);
        for(uint i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }
        return _funders;
    }
    function getFunderAtIndex(uint8 index) external view returns(address) {
        //address[] memory _funders = getAllFunders();
        return lutFunders[index];
    }
    // read-only calls, no gass fees
    // view - will not change storage state
    // pure - won't even view storage stats 
    function justTesting() external pure returns(uint){
        return 2 + 2;
    }
}

// const instance = await Faucet.deployed()
// instance.addFunds({from: accounts[0], value: "2000000000000000000"})
// instance.addFunds({from: accounts[1], value: "2000000000000000000"})
// instance.getFunderAtIndex(0)
// instance.getAllFunders()
// instance.withdraw("10000000", {from: accounts[1]})