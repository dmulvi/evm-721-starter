// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Evm721Starter is ERC721, AccessControl {
    using Counters for Counters.Counter;
    using Strings for uint256;

    event Mint(uint256 tokenId);
    event Airdrop(uint256 tokenId);
    event NewURI(string oldURI, string newURI);

    Counters.Counter internal nextId;

    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public price = 0.001 ether;
    string public baseUri = "https://bafkreic6xug4ia6n2ogb5b5vfmjmrvjuhypii6cek4uwaf7wi4mgyupse4.ipfs.nftstorage.link";

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant AIRDROPPER_ROLE = keccak256("AIRDROPPER_ROLE");

    constructor() payable ERC721("EVM 721 Starter", "XMPL") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(AIRDROPPER_ROLE, msg.sender);
    }
        
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // MODIFIERS

    modifier isCorrectPayment(uint256 _quantity) {
        require(msg.value == (price * _quantity), "Incorrect Payment Sent");
        _;
    }

    modifier isAvailable(uint256 _quantity) {
        require(nextId.current() + _quantity <= MAX_SUPPLY, "Not enough tokens left for quantity");
        _;
    }

    // PUBLIC

    function mint(address _to, uint256 _quantity) 
        external  
        payable
        isCorrectPayment(_quantity)
        isAvailable(_quantity) 
    {
        mintInternal(_to, _quantity);
    }


    // INTERNAL

    function mintInternal(address _to, uint256 _quantity) internal {
        for (uint256 i = 0; i < _quantity; i++) {
            uint256 tokenId = nextId.current();
            nextId.increment();

            _safeMint(_to, tokenId);

            emit Mint(tokenId);
        }
    }   

    // ADMIN

    function airdrop(address _to, uint256 _quantity)
        external 
        onlyRole(AIRDROPPER_ROLE)
    {
        mintInternal(_to, _quantity);
    }

    function setPrice(uint256 _newPrice) external onlyRole(DEFAULT_ADMIN_ROLE) {
        price = _newPrice;
    }

    function setUri(string calldata _newUri) external onlyRole(DEFAULT_ADMIN_ROLE) {
        emit NewURI(baseUri, _newUri);
        baseUri = _newUri;
    }

    function withdraw() public onlyRole(DEFAULT_ADMIN_ROLE) {
        payable(msg.sender).transfer(address(this).balance);
    }

    // VIEW

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        // same uri for all NFTs, logic looks wrong but is intended to use the _tokenId
        // argument to avoid compiler warnings about it not being used
        // for a standard 721 where each NFT is unique this function will def need to be changed
        return
            bytes(baseUri).length > 0
                ? baseUri // this will always be the intended return
                : string(abi.encodePacked(baseUri, _tokenId.toString(), ".json")); 
    }
}