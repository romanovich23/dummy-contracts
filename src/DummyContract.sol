// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract DummyContract {
    struct DummyStruct {
        uint unsignedInt;
        int signedInt;
        bool booleanValue;
        address walletAddress;
        string textData;
        bytes32 hashData;
    }

    mapping(uint => DummyStruct) internal _dummyStructs;
    uint internal _nextId;

    event DummyStructCreated(
        uint id,
        uint unsignedInt,
        int signedInt,
        bool booleanValue,
        address walletAddress,
        string textData,
        bytes32 hashData
    );

    event DummyStructUpdated(
        uint id,
        uint unsignedInt,
        int signedInt,
        bool booleanValue,
        address walletAddress,
        string textData,
        bytes32 hashData
    );

    error DummyStructDoesNotExist();

    function createDummyStruct(
        uint _unsignedInt,
        int _signedInt,
        bool _booleanValue,
        address _walletAddress,
        string memory _textData,
        bytes32 _hashData
    ) external {
        _createDummyStruct(
            _unsignedInt,
            _signedInt,
            _booleanValue,
            _walletAddress,
            _textData,
            _hashData
        );
    }

    function createDummyStruct(uint _unsignedInt, int _signedInt) external {
        _createDummyStruct(
            _unsignedInt,
            _signedInt,
            true,
            msg.sender,
            "Default Text",
            bytes32(0)
        );
    }

    function updateDummyStruct(
        uint _id,
        uint _unsignedInt,
        int _signedInt,
        bool _booleanValue,
        address _walletAddress,
        string memory _textData,
        bytes32 _hashData
    ) external {
        _updateDummyStruct(
            _id,
            _unsignedInt,
            _signedInt,
            _booleanValue,
            _walletAddress,
            _textData,
            _hashData
        );
    }

    function updateDummyStruct(
        uint _id,
        uint _unsignedInt,
        int _signedInt
    ) external {
        _updateDummyStruct(
            _id,
            _unsignedInt,
            _signedInt,
            false,
            address(0),
            "Updated Text",
            bytes32(0)
        );
    }

    function getDummyStruct(
        uint _id
    ) external view returns (uint, int, bool, address, string memory, bytes32) {
        if (_id >= _nextId) revert DummyStructDoesNotExist();
        DummyStruct storage obj = _dummyStructs[_id];
        return (
            obj.unsignedInt,
            obj.signedInt,
            obj.booleanValue,
            obj.walletAddress,
            obj.textData,
            obj.hashData
        );
    }

    function _createDummyStruct(
        uint _unsignedInt,
        int _signedInt,
        bool _booleanValue,
        address _walletAddress,
        string memory _textData,
        bytes32 _hashData
    ) private {
        DummyStruct memory newStruct = DummyStruct({
            unsignedInt: _unsignedInt,
            signedInt: _signedInt,
            booleanValue: _booleanValue,
            walletAddress: _walletAddress,
            textData: _textData,
            hashData: _hashData
        });

        _dummyStructs[_nextId] = newStruct;

        emit DummyStructCreated(
            _nextId,
            _unsignedInt,
            _signedInt,
            _booleanValue,
            _walletAddress,
            _textData,
            _hashData
        );

        _nextId++;
    }

    function _updateDummyStruct(
        uint _id,
        uint _unsignedInt,
        int _signedInt,
        bool _booleanValue,
        address _walletAddress,
        string memory _textData,
        bytes32 _hashData
    ) private {
        if (_id >= _nextId) revert DummyStructDoesNotExist();

        DummyStruct storage obj = _dummyStructs[_id];
        obj.unsignedInt = _unsignedInt;
        obj.signedInt = _signedInt;
        obj.booleanValue = _booleanValue;
        obj.walletAddress = _walletAddress;
        obj.textData = _textData;
        obj.hashData = _hashData;

        emit DummyStructUpdated(
            _id,
            _unsignedInt,
            _signedInt,
            _booleanValue,
            _walletAddress,
            _textData,
            _hashData
        );
    }
}
