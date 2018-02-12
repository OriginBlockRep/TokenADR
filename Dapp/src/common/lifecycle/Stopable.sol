pragma solidity ^0.4.14;

import "../ownership/Ownable.sol";

/// @title Stopable contract - abstract contract that allows children to implement an emergency stop mechanism.
contract Stopable is Ownable {
  bool public stoped;

  modifier stopInExcess {
    require(!stoped);
    _;
  }

  modifier onlyInExcess {
    require(stoped);
    _;
  }

  /// called by the owner on emergency, triggers stopped state
  function stop() external onlyOwner {
    stoped = true;
  }

  /// called by the owner on end of emergency, returns to normal state
  function resume() external onlyOwner onlyInExcess {
    stoped = false;
  }
}
