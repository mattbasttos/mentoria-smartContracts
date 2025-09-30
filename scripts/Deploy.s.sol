// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Ingressos} from "../src/Ingressos.sol";

contract Deploy is Script {
    Ingressos public ingressos;

    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        ingressos = new Ingressos(100);
        vm.stopBroadcast();
    }
}
// --broadcast
// --fork-url
