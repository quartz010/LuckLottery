pragma solidity ^0.4.18;


contract RandNum {
  uint randNonce = 0;

  function ganRand(uint _randMax) external returns(uint) {
    
    uint random = uint(keccak256(now, msg.sender, randNonce)) % _randMax;
    randNonce++;
    uint random2 = uint(keccak256(now, msg.sender, randNonce)) % _randMax;

    return (random + random2) / 2;
  }

}