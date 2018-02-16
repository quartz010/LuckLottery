pragma solidity ^0.4.18;

// Based on https://github.com/OpenZeppelin/zeppelin-solidity

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract LuckyLottery {
  using SafeMath for uint256; // to use the library above, to extend the function of uint Class

  address owner;
  bool public isEnable = true;

  mapping (address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;
  mapping (address => bool) public blacklist; // 黑名单

  modifier canBuy() {
    require(isEnable);
    _;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
      _;
  }

  modifier onlyWhitelist() {
    require(blacklist[msg.sender] == false);
      _;
  }

  function LuckyLottery() public {
    address owner = msg.sender;

  }

  function saleCtl(bool _ctl) onlyOwner public {
    isEnable = _ctl;
  }

  function buyLottery() payable canBuy onlyWhitelist public {
    uint wager = msg.value;
    
  }
  // fallback function to buy a ticket
  function () payable external {  
    buyLottery();
  }


  function _addBlacklist(address _banedUser) internal {
    blacklist[_banedUser] = true;
  }

  function disableUser(address _banedUser) public onlyOwner {
    _addBlacklist(_banedUser);
  }
}