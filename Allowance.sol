// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{

    using SafeMath for uint;

     event AllowanceChanged(address indexed _forwho , address indexed _forwhom , uint _oldAmount , uint _newAmount);

     function isOwner()  internal view returns(bool) {
        return owner() == msg.sender;
    }

    mapping (address => uint) public allowance;

    

    function setAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }
    
    function reduceAllowance( address _who , uint _amount)internal ownerOrAllowed(_amount){
        emit AllowanceChanged(_who,msg.sender, allowance[_who], allowance[_who].sub(_amount));
            allowance[_who] = allowance[_who].sub(_amount);

    }
}
