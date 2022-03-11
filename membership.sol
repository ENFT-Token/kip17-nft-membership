pragma solidity ^0.5.6;

import {KIP17Full, Ownable, Counters} from "./KIP17/KIP17Full.sol";

contract Membership is KIP17Full {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() public KIP17Full("Membership", "ENFT") {}

    function ownerByMember() public view returns (address[] memory) {
        return owners[msg.sender];
    }

    function mintNFT(address _target, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();
        owners[msg.sender].push(_target);
        uint256 newItemId = _tokenIds.current();
        _mint(_target, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
