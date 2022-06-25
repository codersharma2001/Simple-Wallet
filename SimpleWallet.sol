// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "./Allowance.sol";
contract SharedWallet is Allowance{


    event MoneySent(address indexed _beneficiary , uint _amount);
    event MoneyRecieved(address indexed _from , uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance , "There are not enough funds ");
        if(!isOwner()){
            reduceAllowance( msg.sender , _amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }

     function renounceOwnership() public  override onlyOwner{
        revert("Can't renouce ownership here");
    }

    receive() external payable {
       emit MoneyRecieved(msg.sender, msg.value);
    }
}
