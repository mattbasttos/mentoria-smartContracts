// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Ingressos is ERC721 {
    uint256 public number;

    constructor() ERC721("Ingressos", "ING") {}

    function mint(uint256 tokenId) public {
        _mint(msg.sender, tokenId);
    }
}
