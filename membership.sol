pragma solidity ^0.5.6;
pragma experimental ABIEncoderV2;

import {KIP17Full, Counters} from "./KIP17/KIP17Full.sol";

contract Membership is KIP17Full {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(address => address[]) private owners;

    constructor() public KIP17Full("Membership", "ENFT") {}

    // 헬스장에서 소유하고 있는 회원 지갑 주소
    function ownerByMember() public view returns (address[] memory) {
        return owners[msg.sender];
    }

    // myNFT 내가 소유한 NFT > 유저 측 사용
    // 지갑에서 보유한 NFT 찾기
    // balanceOf 개수 찾기 for
    // tokenOfOwnerByIndex로 실제 인덱스 찾기
    // tokenURI로 가져오기

    function mintNFT(address _target, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();
        owners[msg.sender].push(_target); // TODO: 중복체크 기능필요. 전송 기능 만들 때 유저 지갑 간 재연결 필요.
        uint256 newItemId = _tokenIds.current();
        _mint(_target, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
