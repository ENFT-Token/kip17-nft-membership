pragma solidity ^0.5.6;
pragma experimental ABIEncoderV2;

import {KIP17Full, Counters} from "./KIP17/KIP17Full.sol";

contract Membership is KIP17Full {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(address => address[]) private owners;

    constructor() public KIP17Full("Membership", "ENFT") {}

    function setOwnerByMemeber(address _adminTarget, address _from, address _to) internal
        returns (bool){
        bool flag = false;
        for (uint i = 0; i < owners[_adminTarget].length; i++) {
            if(owners[_adminTarget][i] == _from) {
                owners[_adminTarget][i] = _to;
                flag = true;
                break;
            }
        }
        return flag;
    }

    function transferNFT(
        address _adminTarget,
        address from,
        address to,
        uint256 tokenId
    ) public returns (uint256){
        setOwnerByMemeber(_adminTarget, from, to);
        _transferFrom(from,to, tokenId);
    }

    // 헬스장에서 소유하고 있는 회원 지갑 주소
    function ownerByMember(address _adminTarget) public view returns (address[] memory) {
        return owners[_adminTarget];
    }

    // myNFT 내가 소유한 NFT > 유저 측 사용
    // 지갑에서 보유한 NFT 찾기
    // balanceOf 개수 찾기 for
    // tokenOfOwnerByIndex로 실제 인덱스 찾기
    // tokenURI로 가져오기
    function mintNFT(address _adminTarget,address _target, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        bool flag = false;
        for (uint i = 0; i < owners[_adminTarget].length; i++) {
            if(owners[_adminTarget][i] == _target) {
                flag = true;
                break;
            }
        }
        if(!flag) {
            owners[_adminTarget].push(_target);
        }
        uint256 newItemId = _tokenIds.current();
        _mint(_target, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
}
