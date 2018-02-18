pragma solidity ^0.4.18;

import "./lotteryBasic.sol";

contract MyLottery is LuckyLottery {
  
  mapping (address => bool) public blacklist; // 黑名单
  
  modifier canBuy() {
    require(isEnable);
    _;
  }

  modifier onlyWhitelist() {
    require(blacklist[msg.sender] == false);
      _;
  }

  function withdraw() onlyOwner public {  // 跑路函数
    uint256 etherBalance = this.balance;
    owner.transfer(etherBalance);
  }

  function _addBlacklist(address _banedUser) internal {
    blacklist[_banedUser] = true;
  }

  function disableUser(address _banedUser) public onlyOwner {
    _addBlacklist(_banedUser);
  }

}