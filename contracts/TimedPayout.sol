pragma solidity ^0.4.24;

import "./SafeMath.sol";

contract TimedPayout {

    using SafeMath for uint;

    address public owner;
    address public beneficiary;
    uint public amountToSend;
    uint public endTime;
    bool sent = false;

    // sets the payout information on creation
    constructor(address to, uint amount, uint time) public {
       owner = msg.sender;
       beneficiary = to;
       amountToSend = amount.mul(1 ether);
       endTime = now.add(time.mul(1 seconds));
    }

    // allows this contract to receive money
    function () public payable { }

    // checks if the sender is the owner
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    // if the payout hasn't been finalized, it is over or at the end time, and there is money to send
    modifier canTransfer() {
        require(sent == false, "Payout already sent.");
        require(now > endTime, "Unable to transfer funds. Not the time yet.");
        require(address(this).balance >= amountToSend);
        _;
    }

    // allows the owner to add more to the payout
    function addToPayout() isOwner() public payable {
        require(msg.value > 0);
        amountToSend.add(msg.value.mul(1 ether));
    }

    // finalizes the payout by sending the payment
    // and setting this payout to unusable
    function finalize() canTransfer() public {
        beneficiary.transfer(amountToSend);
        sent = true;
    }

     // gets the current balance of the contract
    function getCurrentBalance() public view returns (uint) {
        return address(this).balance;
    }

}
