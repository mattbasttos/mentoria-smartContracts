// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Ingressos} from "../src/Ingressos.sol";

contract IngressosTest is Test {
    Ingressos public ingressos;

    address private constant SENDER = 0x0A3bF3197EF42b596460C6678983A7ef62cf5207;

    function setUp() public {
        ingressos = new Ingressos();
    }

    function test_mint() public {
        vm.startPrank(SENDER);
        uint256 nft = 1;

        vm.expectRevert();
        ingressos.ownerOf(nft);

        ingressos.mint(1);
        assertEq(ingressos.ownerOf(nft), SENDER);
    }
}
