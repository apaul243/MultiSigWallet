pragma solidity ^0.8.0;

contract MultiSigWallet{

address[] public holders;
mapping(address => bool) public isHolder;
uint public approvalsRequired;
uint txIndex ;
enum txStatus {
	Started,
	Confirmed,
	Sent,
	Rejected
}

struct txRequest{
	uint index;
	address to;
	uint amount;
	bytes message;
	uint confirmations;
	txStatus status;
	mapping(address => bool) hasHolderVoted;
}

txRequest[] public txs;

constructor(address[] memory _holders, uint _approvalsRequired) {
	require(_holders.length>0, "Atleaast one owner required");
	require(_approvalsRequired>0,"Atleast one approver required");
	require(_approvalsRequired <=_holders.length, " Confirmations required should be less than no of owners");
	txIndex = 0;
	for(uint x=0; x<_holders.length;x++) {
		address holder = _holders[x];
		require(!isHolder[holder],"Duplicate Holder");
		isHolder[holder] = true;
		holders.push(holder);
	}
	approvalsRequired = _approvalsRequired;
}

event SendTransaction(address indexed owner, uint indexed txIndex);

modifier ifHolder()  {
	require(isHolder[msg.sender],"This address is not a holder of the wallet");
	_;
}


modifier notExecuted(uint txNo) {
	require(txs[txNo].status!=txStatus.Sent, "Transaction has already been executed");
 	_;
}

modifier txExists(uint txNo) {
	require(txNo<txs.length,"This transaction does not exist");
	_;
}

function startTransaction(address _to,uint _amount, bytes memory _message) public ifHolder {
	
	txRequest storage req = txs.push();
	req.index = txIndex;
	req.to = _to;
	req.amount = _amount;
	req.message = _message;
	req.confirmations = 1;
	req.status = txStatus.Started;
	txIndex++;
	
}

function confirmTransaction(uint _index) public ifHolder notExecuted(_index) txExists(_index) {
		
		require(!txs[_index].hasHolderVoted[msg.sender], " the holder has already voted");
		txs[_index].hasHolderVoted[msg.sender] = true;
		txs[_index].confirmations++;

}

function sendTransaction(uint _index) public ifHolder notExecuted(_index) txExists(_index){

	require(txs[_index].confirmations >= approvalsRequired, " minimum no of approvals not met");
	txs[_index].status = txStatus.Confirmed;
	(bool success, ) = txs[_index].to.call{value: txs[_index].amount}(txs[_index].message)	;
	require(success, "failed");
	emit SendTransaction(msg.sender, _index);
}

function getHolders() public view returns (address[] memory) {
	return holders;
}

receive() payable external{
	
}

}










