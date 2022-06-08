// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

import "./Ownable.sol";
import"./ParkingSpot.sol";


contract ParkingLot is Ownable {
    mapping (uint => address) public spots;

    function createSpot(uint _spotId) external checkOwnership {
        ParkingSpot spot = new ParkingSpot(_spotId);
        spots[_spotId] = address(spot);
    }

    function parkSpotStatus(uint _spotId) external view returns(bool) {
        ParkingSpot spot = ParkingSpot(spots[_spotId]);
        return spot.isVacant();
    }


    function takeUpSpot(uint _spotId) payable external {
        ParkingSpot spot = ParkingSpot(spots[_spotId]);
        spot.park{value: msg.value}();
    }

    function freeUpSpot(uint _spotId) external checkOwnership {
        ParkingSpot spot = ParkingSpot(spots[_spotId]);
        spot.markAvailable();
    }
}
