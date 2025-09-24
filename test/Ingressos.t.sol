// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Ingressos} from "../src/Ingressos.sol";

contract IngressosTest is Test {
    Ingressos public ingressos;

    address private constant SENDER = 0x0A3bF3197EF42b596460C6678983A7ef62cf5207;
    uint256 private constant MAX_TICKETS = 100;
    uint256 private constant NFT_PRICE = 0.1 ether;

    function setUp() external {
        vm.deal(SENDER, 100 ether);
        ingressos = new Ingressos(MAX_TICKETS);
    }

    function test_mint() external {
        vm.startPrank(SENDER);
        uint256 nft = 1;

        assertEq(address(ingressos).balance, 0);
        vm.expectRevert();
        ingressos.ownerOf(nft);

        ingressos.mint{value: NFT_PRICE}(nft);
        assertEq(ingressos.ownerOf(nft), SENDER);
        assertEq(address(ingressos).balance, NFT_PRICE);
    }

    function test_listTokens() external {
        vm.startPrank(SENDER);
        uint256[] memory nfts = new uint256[](10);

        assertEq(ingressos.balanceOf(SENDER), 0);
        for (uint256 i = 0; i < nfts.length; i++) {
            nfts[i] = i + 1;
            ingressos.mint{value: NFT_PRICE}(nfts[i]);
        }
        uint256 balance = ingressos.balanceOf(SENDER);
        assertEq(balance, 10);

        for (uint256 i = 0; i < balance; i++) {
            assertEq(ingressos.tokenOfOwnerByIndex(SENDER, i), nfts[i]);
        }
    }
}
