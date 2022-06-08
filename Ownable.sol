
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract Ownable {
    address payable public owner;

    constructor(){
        owner = tx.origin;
    }

    modifier checkOwnership {
        require(tx.origin == owner);
        _;
    }
}

