// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./../../utils/Ownable.sol";

abstract contract ARC721 is Ownable {
    mapping(uint256 => string) private tokenURIs;
    string private _name;
    string private _symbol;
    uint256 private _tokenIdCounter;
    string private _tokenuri;
    mapping(uint256 => address) private _tokenOwners;
    mapping(address => uint256) private _tokenBalances;

    constructor(string memory name_, string memory symbol_, string memory baseURI_){
        _name = name_;
        _symbol = symbol_;
        _tokenIdCounter = 0;
        _tokenuri = baseURI_;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function balanceOf(address owner) external view returns (uint256) {
        return _tokenBalances[owner];
    }

    function totalSupply() external view returns (uint256) {
        return _tokenIdCounter;
    }

    function mintToken(address to) external {
        uint256 tokenId = _tokenIdCounter;
        _tokenOwners[tokenId] = to;
        _tokenBalances[to]++;
        _tokenIdCounter++;
    }

    function tokenMetadata(
        uint256 tokenId
    ) external view returns (string memory) {
        return _tokenuri;
    }
}
