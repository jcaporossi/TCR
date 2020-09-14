pragma solidity ^0.6.0;

library AttributeStore {
    struct Data {
        mapping(bytes32 => uint) store;
    }

    function getAttribute(Data storage self, bytes32 UUID, string memory attrName) public returns (uint) {
        bytes32 key = sha3(UUID, attrName);
        return self.store[key];
    }

    function attachAttribute(Data storage self, bytes32 UUID, string memory attrName, uint attrVal) public {
        bytes32 key = sha3(UUID, attrName);
        self.store[key] = attrVal;
    }
}