pragma solidity^0.4.24;

contract Accountability {

    address user;
    address[] guardians;
    mapping(address => bool) canApprove;

    uint8 approvalsNeeded;

    struct Request {
        bool sent;
        address to;
        bytes32 title;
        uint amount;
        mapping(address => bool) signeeStatus;
    }

    Request[] requests;

    function () public payable { }

    constructor(address u, address[] glist, uint8 approvalNumber) public {
        user = u;
        approvalsNeeded = approvalNumber;
        guardians = glist;

        for(uint i = 0; i < glist.length; i++) {
            canApprove[glist[i]] = true;
        }
    }

    function proposeRequest(bytes32 title, address to, uint amount) public isUser() {
        require(amount <= address(this).balance);

        requests.push(Request({
            to: to,
            title: title,
            amount: amount,
            sent: false
        }));
    }

    function approveRequest(uint index) public isValidRequest(index) isGuardian() {
        requests[index].signeeStatus[msg.sender] = true;
    }

    function rejectRequest(uint index) public isValidRequest(index) isGuardian() {
        requests[index].signeeStatus[msg.sender] = false;
    }

    function finalizeRequest(uint index) public isValidRequest(index) isUser() {
        if(canFinalize(index)) {
            requests[index].to.transfer(requests[index].amount);
            requests[index].sent = true;
        }
    }

    function canFinalize(uint index) public view returns (bool) {
        uint8 count = 0;

        for(uint i = 0; i < guardians.length; i++) {
            if(isApproved(index, guardians[i])) {
                count++;
            }
        }

        if(count >= approvalsNeeded) {
            return true;
        }else{
            return false;
        }
    }

    function isApproved(uint index, address guardian) public view returns (bool)  {
        return requests[index].signeeStatus[guardian];
    }

    modifier isValidRequest(uint i) {
        require(i >= 0);
        require(i < requests.length);
        require(requests[i].sent == false);
        _;
    }

    modifier isGuardian() {
        require(canApprove[msg.sender] == true);
        _;
    }

    modifier isUser() {
        require(msg.sender == user);
        _;
    }

}
