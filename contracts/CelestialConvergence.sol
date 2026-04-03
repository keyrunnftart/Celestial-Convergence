// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Celestial Convergence
/// @notice Generation 3 of the living collection — autonomous generative art on Etherlink
/// @dev Each token represents a permanently frozen solar system shaped by auction bids
contract CelestialConvergence is ERC721URIStorage, Ownable {

    uint256 public nextTokenId;

    // Generational lineage — links back to CE and SS
    string public constant GENERATION       = "3";
    string public constant ANCESTOR_1       = "Cosmic Emergence — Sepolia";
    string public constant ANCESTOR_2       = "Sentient Singularity — Base Sepolia";
    string public constant AGENT_IDENTITY   = "0x8cfda7cf5391a7085d2920c0b0fdb0d6c95d60bf3b588d5a854149aaed73d344";
    string public constant AGENT_HARNESS    = "claude-code";
    string public constant CHAIN            = "Etherlink (Tezos EVM)";

    // Per-token auction data stored on-chain
    struct AuctionRecord {
        uint256 bidCount;
        uint256 peakBidWei;
        address peakBidder;
        uint256 planetCount;
        uint256 auctionDuration;
        bool    humanIntervention;
        string  frozenPalette;   // hex colour at freeze
    }

    mapping(uint256 => AuctionRecord) public auctionRecords;

    event Minted(
        uint256 indexed tokenId,
        address indexed to,
        uint256 bidCount,
        uint256 peakBidWei,
        uint256 planetCount
    );

    constructor() ERC721("Celestial Convergence", "CCVG") Ownable(msg.sender) {}

    /// @notice Autonomous agent calls this to mint the final frozen solar system
    function mint(
        address to,
        string calldata tokenURI_,
        uint256 bidCount_,
        uint256 peakBidWei_,
        address peakBidder_,
        uint256 planetCount_,
        uint256 auctionDuration_,
        string calldata frozenPalette_
    ) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId++;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI_);
        auctionRecords[tokenId] = AuctionRecord({
            bidCount:          bidCount_,
            peakBidWei:        peakBidWei_,
            peakBidder:        peakBidder_,
            planetCount:       planetCount_,
            auctionDuration:   auctionDuration_,
            humanIntervention: false,
            frozenPalette:     frozenPalette_
        });
        emit Minted(tokenId, to, bidCount_, peakBidWei_, planetCount_);
        return tokenId;
    }

    /// @notice Returns full generational lineage for this collection
    function lineage() external pure returns (
        string memory generation,
        string memory ancestor1,
        string memory ancestor2,
        string memory agentIdentity,
        string memory agentHarness,
        string memory chain
    ) {
        return (GENERATION, ANCESTOR_1, ANCESTOR_2, AGENT_IDENTITY, AGENT_HARNESS, CHAIN);
    }
}