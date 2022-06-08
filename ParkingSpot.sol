
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

import "./Ownable.sol";

contract ParkingSpot is Ownable {

    uint public spotId;

    enum LotStatuses { VACANT, FULL}
    LotStatuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    constructor(uint _spotId) {
        super;
        currentStatus= LotStatuses.VACANT;
        spotId = _spotId;
    }

    modifier checkVacancy {
        require(currentStatus == LotStatuses.VACANT, "Parking is Full!");
        _;
    }

    modifier checkCost (uint _amount) {
        require(msg.value >= _amount, "Not enough, parking costs 10 ether");
        _;
    }

    function isVacant() external view returns(bool) {
        if (currentStatus == LotStatuses.FULL) {
            return false;
        } else {
            return true;
        }
    }

    // function park() payable external checkVacancy checkCost(10 ether) {
    //     currentStatus= LotStatuses.FULL;
    //     owner.transfer(msg.value);
    //     emit Occupy(msg.sender, msg.value);
    // }

    function markAvailable() external checkOwnership {
        currentStatus= LotStatuses.VACANT;
    }

    receive() external payable checkVacancy checkCost(10 ether) {
        currentStatus = LotStatuses.FULL;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}
