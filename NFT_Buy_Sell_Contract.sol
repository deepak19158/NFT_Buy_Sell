//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
 
contract MNFT is ERC721, Ownable {
    using Counters for Counters.Counter;      
 
    Counters.Counter private _tokenIdCounter;
    constructor() ERC721("mNFT", "MFT") {}          //Constructor for ERC721
 
    mapping(uint=>uint) public idToAmount
 
    function _baseURI() internal pure override returns (string memory) {           
        return "www.nft.com/tokens/";
    }
 
    function safeMint(address to) public payable returns(uint) { 
        require(msg.value> 0.01 ether); 
        uint256 tokenId = _tokenIdCounter.current();
        idToAmount[tokenId] = msg.value; 
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        return tokenId;
    }    
 
    function withdraw(uint tokenId) public payable{  
        require(ownerOf(tokenId) == msg.sender, "Sorry you are not the correct owner");    
        safeTransferFrom(msg.sender, owner(), tokenId);       
        payable(msg.sender).transfer(idToAmount[tokenId]);
        idToAmount[tokenId] = 0;                    
    }
}
 
 
