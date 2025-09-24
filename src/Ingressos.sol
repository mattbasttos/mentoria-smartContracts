// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract Ingressos is ERC721Enumerable {
    uint256 private _totalTickets;
    uint256 private immutable MAX_TICKETS;

    constructor(uint256 maxTickets) ERC721("Tickets", "TIC") {
        MAX_TICKETS = maxTickets;
    }

    function mint(uint256 tokenId) external payable {
        require(msg.value == 0.1 ether, "Insufficient funds");
        uint256 totalTickets = _totalTickets + 1;
        require(totalTickets < MAX_TICKETS);
        _totalTickets = totalTickets;
        _mint(msg.sender, tokenId);
    }
}
