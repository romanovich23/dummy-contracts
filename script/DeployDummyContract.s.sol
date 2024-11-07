// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/DummyContract.sol";

contract DeployDummyContract is Script {
    function run() external {
        vm.startBroadcast();

        DummyContract dummyContract = new DummyContract();

        vm.stopBroadcast();

        console.log("DummyContract deployed at:", address(dummyContract));
    }
}
