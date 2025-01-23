// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Blockchain {
        struct Block {                                   // Structure to represent a block in the blockchain                                    
        uint256 index; 
        uint256 timestamp; 
        string transactions;
        bytes32 previousHash; 
        bytes32 hash; 
    }

    Block[] public chain;                                                // Dynamic array to hold the blockchain
    
    constructor() {                                                    // Constructor that initializes the blockchain with the genesis block
        createGenesisBlock();
    }

    function createGenesisBlock() private {                              // Private function to create the genesis block (first block in the chain)
            Block memory genesisBlock = Block({                         // Create the genesis block with default data and no previous hash
            index: 0, 
            timestamp: block.timestamp,
            transactions: "Genesis Block", 
            previousHash: 0x0, 
            hash: computeHash(0, block.timestamp, "Genesis Block", 0x0) 
        });
        chain.push(genesisBlock); 
    }

    function addBlock(string memory _transactions) public {                            // Function to add a new block to the blockchain
        Block memory previousBlock = chain[chain.length - 1];
        Block memory newBlock = Block({
            index: chain.length, 
            timestamp: block.timestamp, 
            transactions: _transactions, 
            previousHash: previousBlock.hash, 
            hash: 0 
        });

        newBlock.hash = computeHash(newBlock.index, newBlock.timestamp, newBlock.transactions, newBlock.previousHash);

        chain.push(newBlock);
    }

    
    function computeHash(                                                            // Function to compute a hash for a block using its data
        uint256 _index,
        uint256 _timestamp,
        string memory _transactions,
        bytes32 _previousHash
    ) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(_index, _timestamp, _transactions, _previousHash));           // Hash the block's index, timestamp, transactions, and previous hash using keccak256
    }

    
    function isChainValid() public view returns (bool) {                                     // Function to verify the validity of the blockchain
        for (uint256 i = 1; i < chain.length; i++) {
            Block memory currentBlock = chain[i]; 
            Block memory previousBlock = chain[i - 1]; 

            if (currentBlock.hash != computeHash(
                currentBlock.index,
                currentBlock.timestamp,
                currentBlock.transactions,
                currentBlock.previousHash
            )) {
                return false; 
            }

            if (currentBlock.previousHash != previousBlock.hash) {                              // Validate the reference to the previous block's hash
                return false; 
            }
        }
        return true;                                                                              // Return true if the entire chain is valid
    }

    
    function tamperBlock(uint256 _index, string memory _newTransactions) public {                 // Function to tamper with a block (for testing purposes)
        if (_index < chain.length) {
            chain[_index].transactions = _newTransactions;

            chain[_index].hash = computeHash(
                chain[_index].index,
                chain[_index].timestamp,
                _newTransactions,
                chain[_index].previousHash
            );
        }
    }

    
    function getBlock(uint256 _index) public view returns (                              // Function to retrieve a block's details by its index
        uint256,
        uint256,
        string memory,
        bytes32,
        bytes32
    ) {
        Block memory blk = chain[_index];                                                 // Retrieve the block from the chain
        return (blk.index, blk.timestamp, blk.transactions, blk.previousHash, blk.hash);
    }
}
