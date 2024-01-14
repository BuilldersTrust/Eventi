// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// import "../contracts/ARCs/ARC-721";
// import "../contracts/utils/Ownable.sol";

contract Eventii is ERC721Upgradeable, ERC721URIStorageUpgradeable, OwnableUpgradeable {
    uint256 private nextTicketId;
    string public eventName;
    uint256 public eventDate;
    uint256 public eventTime;
    uint256 public price;
    uint256 public mintableTicket;
    string public tokenuri; 
   

    struct Ticket {
        address owner;
        uint256 ticketId;
        uint256 price;
        bool used;
    }

    mapping(uint256 => Ticket) tickets;

    function initialize(address initialOwner, string memory _eventName, uint256 _eventDate, uint256 _price, uint256 _mintableTicket) public initializer {
        __ERC721_init("TicketingSystem", "TS");
        __Ownable_init(initialOwner);
    
        eventName = _eventName;
        eventDate = _eventDate;
        price = _price;
        mintableTicket = _mintableTicket;
    }

    function buyTicket() payable  public {
        require(nextTicketId <= mintableTicket, "No More Available Ticket!!");
        require(msg.value == price, "Invalid amount");
        Ticket memory newTicket = Ticket(msg.sender, nextTicketId, price, false);
        tickets[nextTicketId] = newTicket;
        _mint(msg.sender, nextTicketId);
        nextTicketId++;
    }

     function transferFrom(address from, address to, uint256 tokenId) public override(ERC721Upgradeable, IERC721) {
        require(tickets[tokenId].used == false, "Ticket has already been used");
        super.transferFrom(from, to, tokenId);
    }

    function attend(uint256 ticketId) public {
        require(msg.sender == ownerOf(ticketId), "Not owner");
        tickets[ticketId].used = true;  
    }

    function getTicketPrice(uint256 ticketId) public view returns (uint256) {
        return tickets[ticketId].price;
    }

    function verifyTicketOwnership(uint256 ticketId, address claimant) public view returns (bool) {
        return ownerOf(ticketId) == claimant;
    }

    function getTicketStatus(uint256 ticketId) public view returns (bool){
      return tickets[ticketId].used;
    }

    function setContractTokenURI(string memory _tokenURI) public onlyOwner {
        tokenuri = _tokenURI;
    }

    function tokenURI(uint256) public view override(ERC721Upgradeable, ERC721URIStorageUpgradeable) returns (string memory) {
        return tokenuri;
    }

    function rateEvent() public {
        
    }


    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
 
}




