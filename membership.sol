pragma solidity ^0.5.6;

import {KIP17Full, Ownable, Counters} from "./KIP17/KIP17Full.sol";

contract Membership is KIP17Full, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() public KIP17Full("Membership", "ENFT") {}

    function mintNFT(string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
