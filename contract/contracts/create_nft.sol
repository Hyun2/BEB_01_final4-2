// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./multiOwner.sol";
import "./trade.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GGanbuCollection is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    event burnNft(uint256 tokenId);
    mapping(uint256 => bool) private auction;
    string private collectionURI;

    event sell(address indexed contractAddr, address collection, uint256 tokenId, uint256 price);
    event cancel(address indexed contractAddr, address collection, uint256 tokenId);

    constructor(string memory collectionName, string memory collectionSymbol, string memory _collectionURI) ERC721(collectionName, collectionSymbol) {
       collectionURI = _collectionURI;
    }
    
    function mintNFT(string memory tokenURI) public onlyOwner returns (uint256) {    
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId,tokenURI);
        return newItemId;
    }

    function burn(uint256 tokenId) public onlyOwner returns (bool){     
        require(msg.sender == ownerOf(tokenId),"Collection: This address is not owner");//해당 nft의 owner만 삭제 할 수 있다.  
        ERC721URIStorage._burn(tokenId);
        emit burnNft(tokenId);
        return true;
    }

    function sell(uint256 tokenId, uint256 price) public returns(address){
        require(msg.sender == ownerOf(tokenId),"Collection: This address is not owner");//해당 nft의 owner만 판매등록 할 수 있다.
        require(!auction[tokenId],"Collection: Can not sell this NFT");//이미 판매중인지 검사
        auction[tokenId] = true;        
        address tradeContract = address(new trade(msg.sender,address(this),tokenId,price));//trade contract 생성
        _approve(tradeContract, tokenId);//tradeContract에서 transferFrom 사용할 수 있게 함
        //addOwnership(tradeContract);//거래 이후 nft 받는 사람에게 collection 접근 권한 주기위함. 거래완료 이후 삭ㅇ제예정
        emit sell(tradeContract,address(this),tokenId,price);//event 발생
        return tradeContract;
    }

    function cancel(address contractAddr) public onlyOwner returns(bool){
        require(!auction[tokenId],"Collection: Can not sell this NFT");//판매중인지 검사
        //trade 호출
        //취소
        auction[tokenId] = false;
        //trade contract 비활성화
        emit cancel(tradeContract,address(this),tokenId);//event 발생
    }
   
   function getIsSelling(uint256 tokenId)public view returns(bool){
       return auction[tokenId] ;
   }
        
}