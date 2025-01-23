# Task
Basic Blockchain Simulation 
This is a simple Blockchain smart contract implemented in Solidity. It simulates the basic functionality of a blockchain, including block creation, validation, and tampering detection.

Features :
Genesis block creation.
Adding new blocks with transaction data.
Computing the hash for each block.
Validating the integrity of the entire blockchain.
Tampering a block for demonstration purposes.
Retrieving details of a specific block.


Blockchain Structure
 Each block contains:

Index: Position in the chain.
Timestamp: Time of block creation.
Transactions: String containing transaction data.
Previous Hash: Hash of the preceding block.
Hash: Current block’s computed hash.

Blockchain Validation :
The chain is considered valid if all blocks have valid hashes and the previousHash matches the hash of the preceding block.

Functions :
 1.Genesis Block Creation
     createGenesisBlock():  
		 Initializes the chain with a genesis block.
 2.Add Block
     addBlock(string memory _transactions):
     Adds a new block to the chain with custom transaction data.
 3.Hash Computation
     computeHash(...):
     Generates a unique hash for a block using its properties.
 4.Chain Validation
      isChainValid():
			Returns true if the blockchain is intact and valid; otherwise, false.
 5.Tamper Block
      tamperBlock(uint256 _index, string memory _newTransactions):
			Simulates tampering by altering a block’s transactions and recalculating its hash.
 6.Retrieve Block
      getBlock(uint256 _index):
      Fetches and returns details of a specific block.
