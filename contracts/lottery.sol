pragma solidity ^0.4.18;

import "./lotteryBasic.sol";

contract MyLottery is LuckyLottery {

  bool isEnable;
  address owner;
  uint currentJoined = 0;

  mapping (address => bool) public blacklist; // 黑名单
  
  modifier canBuy() {
    require(isEnable);
    _;
  }

  modifier onlyWhitelist() {
    require(blacklist[msg.sender] == false);
      _;
  }
  // 1e15, 5 (0.001 ether, five per bet)
  function MyLottery( uint _minValue, uint _maxJoined) public {
    owner = msg.sender;
    LuckyLottery.maxJoined = _maxJoined;
    LuckyLottery.minValue = _minValue;
  }
  
    // fallback function to buy a ticket
  function () external payable {  
    _buyLottery();
    _checkWinner();
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