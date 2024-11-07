// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.25;

import "forge-std/Test.sol";
import "../src/DummyContract.sol";

contract DummyContractTest is Test {
    DummyContract dummyContract;

    function setUp() public {
        dummyContract = new DummyContract();
    }

    function testCreateDummyStructFull() public {
        dummyContract.createDummyStruct(
            100,
            -50,
            true,
            address(this),
            "Test Text",
            keccak256("test hash")
        );

        (
            uint unsignedInt,
            int signedInt,
            bool booleanValue,
            address walletAddress,
            string memory textData,
            bytes32 hashData
        ) = dummyContract.getDummyStruct(0);

        assertEq(unsignedInt, 100);
        assertEq(signedInt, -50);
        assertTrue(booleanValue);
        assertEq(walletAddress, address(this));
        assertEq(textData, "Test Text");
        assertEq(hashData, keccak256("test hash"));
    }

    function testCreateDummyStructWithDefaults() public {
        dummyContract.createDummyStruct(200, -100);

        (
            uint unsignedInt,
            int signedInt,
            bool booleanValue,
            address walletAddress,
            string memory textData,
            bytes32 hashData
        ) = dummyContract.getDummyStruct(0);

        assertEq(unsignedInt, 200);
        assertEq(signedInt, -100);
        assertTrue(booleanValue);
        assertEq(walletAddress, address(this));
        assertEq(textData, "Default Text");
        assertEq(hashData, bytes32(0));
    }

    function testUpdateDummyStructFull() public {
        dummyContract.createDummyStruct(
            300,
            -150,
            false,
            address(this),
            "Initial Text",
            keccak256("initial hash")
        );

        dummyContract.updateDummyStruct(
            0,
            400,
            -200,
            true,
            address(0x123),
            "Updated Text",
            keccak256("updated hash")
        );

        (
            uint unsignedInt,
            int signedInt,
            bool booleanValue,
            address walletAddress,
            string memory textData,
            bytes32 hashData
        ) = dummyContract.getDummyStruct(0);

        assertEq(unsignedInt, 400);
        assertEq(signedInt, -200);
        assertTrue(booleanValue);
        assertEq(walletAddress, address(0x123));
        assertEq(textData, "Updated Text");
        assertEq(hashData, keccak256("updated hash"));
    }

    function testUpdateDummyStructWithDefaults() public {
        dummyContract.createDummyStruct(
            500,
            -250,
            false,
            address(this),
            "Another Text",
            keccak256("another hash")
        );

        dummyContract.updateDummyStruct(0, 600, -300);

        (
            uint unsignedInt,
            int signedInt,
            bool booleanValue,
            address walletAddress,
            string memory textData,
            bytes32 hashData
        ) = dummyContract.getDummyStruct(0);

        assertEq(unsignedInt, 600);
        assertEq(signedInt, -300);
        assertTrue(!booleanValue);
        assertEq(walletAddress, address(0));
        assertEq(textData, "Updated Text");
        assertEq(hashData, bytes32(0));
    }

    // TODO: Review this test
    // function testFailToUpdateNonExistentStruct() public {
    //     vm.expectRevert(DummyContract.DummyStructDoesNotExist.selector);
    //     dummyContract.updateDummyStruct(
    //         999,
    //         700,
    //         -400,
    //         true,
    //         address(0x456),
    //         "Nonexistent Update",
    //         keccak256("fail hash")
    //     );
    // }

    // TODO: Review this test
    // function testFailToGetNonExistentStruct() public {
    //     vm.expectRevert(DummyContract.DummyStructDoesNotExist.selector);
    //     dummyContract.getDummyStruct(999);
    // }
}
