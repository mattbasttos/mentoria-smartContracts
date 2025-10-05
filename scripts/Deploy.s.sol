// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {Pizzaria} from "../src/Pizzaria.sol";

contract Deploy is Script {
    Pizzaria public pizzaria;

    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        pizzaria = new Pizzaria();
        vm.stopBroadcast();
    }
}
// --broadcast
// --fork-url
