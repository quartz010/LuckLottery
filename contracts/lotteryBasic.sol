pragma solidity ^0.4.18;

import "./randNum.sol";

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

    function clear(uint a) internal pure returns (uint) {
      a = 0;
      return a;
    }
}

contract LuckyLottery {
  using SafeMath for uint; // to use the library above, to extend the function of uint Class

  address owner;
  uint currentJoined = 0;
  uint maxJoined = 0;
  uint minValue;
  address winner;
  RandNum randNum;

  mapping (address => uint) balances;
  mapping (uint => address) joinedQueue;
  mapping (address => mapping (address => uint256)) allowed;


  modifier onlyOwner() {
    require(msg.sender == owner);
      _;
  }

  function LuckyLottery(uint _minValue, uint _maxJoined) public {
    address owner = msg.sender;
    maxJoined = _maxJoined;
    minValue = _minValue;


  }

  function buyLottery() payable public {
    uint wager = msg.value;
    require(wager > 0);
    uint buyNum = wager.div(minValue);
    
    for (uint index = 0; index < buyNum; index++) {
      joinedQueue[currentJoined + index] = msg.sender;   
    }
    
    
  }

  // fallback function to buy a ticket
  function () payable external {  
    buyLottery();
    
    if (currentJoined == maxJoined) {
      _luckyDraw();

      currentJoined.clear();
    }
  }

  function _sendPrize(address _winner, uint _prizeValue) internal {
    
  }


  function _luckyDraw() internal returns(address) {
   uint luckyNum = randNum.getRand(maxJoined);
   winner = joinedQueue[luckyNum];
   return winner;
  }


}