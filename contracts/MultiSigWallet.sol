pragma solidity ^0.4.21;

/*
Creates a multi signature wallet where multiple
users can create proposals to send ether to an
address

The payment must be approved by a specified majority
of the signers.

Once the payment is finalized (approved), it will be processed and allocated
to the given user
*/
contract MultiSigWallet {
    using StringConversion for StringConversion;

    event onSign(uint indexed proposalIndex, address indexed signer, bool signed);
    event onCreateProposal(bytes32 indexed title, address indexed to, uint indexed amount);

    struct Proposal {
        bytes32 title; // the title of the proposal (in hex)
        address to; // who it's going to
        uint amount; // amount to be sent
        mapping(address => bool) signed; // list of who signed
        bool finalized; // whether the proposal has been finalized
    }

    // a list of current proposals
    Proposal[] public proposals;

    // an address of signers
    address[] public signers;

    // keeps track of who can sign
    mapping(address => bool) public canSign;

    // fall back function that allows this contract to receive ether
    function () public payable {

    }

    // on creation of the contract
    constructor(address[] initSigners) public {
        signers = initSigners;
        for(uint i = 0; i < initSigners.length; i++) {
            canSign[initSigners[i]] = true;
        }
    }

    // gets the current balance of the contract
    function getCurrentBalance() isSigner(msg.sender) public view returns (uint) {
        return address(this).balance;
    }

    // checks to see if the msg sender (address) is part of signers
    modifier isSigner(address user) {
        require(canSign[user] == true);
        _; // continues the process
    }

    // submits a formal proposal only if the sender is can send one
    function submitProposal(string title, uint amount, address to) isSigner(msg.sender) public {
        proposals.push(Proposal({ // adds the new proposal to the list
            title: StringConversion.stringToBytes32(title),
            to: to,
            amount: amount,
            finalized: false
        }));
        emit onCreateProposal(StringConversion.stringToBytes32(title), to, amount); // emits the creation of the proposal with an amount and who it is for
    }

    // allows a signer to revise the amount proposed to a specific user
    function reviseProposalAmount(uint proposalIndex, uint newAmount) isSigner(msg.sender) public {
        require(proposals[proposalIndex].finalized == false); // requires that the proposal isn't already processed
        require(getCurrentBalance() >= newAmount); // requires that our contract still has enough funds for the new amount
        proposals[proposalIndex].amount = newAmount; // sets the proposal's new amount
    }


    // checks to see if the proposal exists
    modifier proposalExists(uint proposalIndex) {
        require(proposalIndex >= 0); // whether the index is even a valid index
        require(proposalIndex < proposals.length); // whether the index is within the length of the proposals array
        _;
    }

    // lets a signer sign a proposal if it exists
    function sign(uint proposalIndex) isSigner(msg.sender) proposalExists(proposalIndex) public {
        proposals[proposalIndex].signed[msg.sender] = true; // sets the signer for that proposal as true
        emit onSign(proposalIndex, msg.sender, proposals[proposalIndex].signed[msg.sender]); // emits when one of the signers approves a proposal
    }

    // returns whether a proposal has been fully approved by all other signers
    function isSendable(uint proposalIndex) proposalExists(proposalIndex) public view returns (bool) {
        bool status = true; // by default, approval for a proposal will be true
        for(uint i = 0; i < signers.length; i++) {
            if(!isSigned(proposalIndex, signers[i])) { // if one of the signers hasn't signed it
                status = false; // sets status to false
            }
        }
        return status; // returns current status
    }

    // checks whether a specific signer has signed it
    function isSigned(uint proposalIndex, address signer) private view returns (bool) {
        return proposals[proposalIndex].signed[signer];
    }

    // a modifier check to see if a certain proposal is sendable/ready
    modifier isReady(uint proposalIndex) {
        require(isSendable(proposalIndex));
        _;
    }

    // finalizes the proposal once it is sendable, the contract has enough balance to send, and the proposal hasn't been finalized already
    function finalizeProposal(uint proposalIndex) isReady(proposalIndex) isSigner(msg.sender) public {
        require(address(this).balance >= proposals[proposalIndex].amount); // requires our balance to have the amount we need
        require(!proposals[proposalIndex].finalized); // requires that the proposal hasn't been finalized
        proposals[proposalIndex].finalized = true; // finalizes the proposal
        proposals[proposalIndex].to.transfer(proposals[proposalIndex].amount); // pays out the amount to the specified user
    }

}

library StringConversion {
    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }
}
