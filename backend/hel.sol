// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicineRegistry {
    struct Medicine {
        string name;
        uint256 expDate;
        uint256 price;
    }

    mapping(uint256 => Medicine) public medicines;
    uint256 public medicineCount;

    event MedicineCreated(uint256 indexed id, string name, uint256 expDate, uint256 price);

    constructor() {
        medicineCount = 0;
    }
function createMedicine(string memory name, uint256 expDate, uint256 price) public {
    uint256 id = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, medicineCount)));
    medicines[id] = Medicine(name, expDate, price);
    emit MedicineCreated(id, name, expDate, price);
    medicineCount++;
}

function getMedicine(uint256 id) public view returns (Medicine memory) {
    require(id != 0, "Invalid id");
    return medicines[id];
}

function checkMedicineExists(uint256 id) public view returns (bool) {
    return medicines[id].expDate != 0;
}
}