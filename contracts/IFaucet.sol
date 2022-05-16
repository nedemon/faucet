// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// can only inherit from interfaces
// no constructor
// no state vars
// all functions have to be external

interface IFaucet {

    function addFunds() external payable;

    function withdraw(uint withdrawAmount) external;
    
}