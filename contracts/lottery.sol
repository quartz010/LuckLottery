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
  using SafeMath for uint256; //使用上面的库 方便对应uint类的进行计算

  address owner;

  mapping (address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;
  mapping (address => bool) public blacklist; // 黑名单


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


  function _addBlacklist(address _banedUser) internal {
    blacklist[_banedUser] = true;
  }

  function addBlacklist(address _banedUser) public onlyOwner {
    _addBlacklist(_banedUser);
  }
}