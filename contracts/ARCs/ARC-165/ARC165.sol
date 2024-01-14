// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IARC165 {
     function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

contract ARC165 is IARC165 {
     mapping(bytes4 => bool) private supportedInterfaces;

     constructor() {
         //To add an example supported interface
         supportedInterfaces[bytes4(keccak256("ARC165"))] = true;
     }

     function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
         return supportedInterfaces[interfaceId];
     }

     // You can add custom functions and other logic here.
}