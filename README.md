# Deedlock  Dapp

decentralised application built for Ethereum providing following features:

1. Create property token
2. Get property details using property address


### Truffle - Compile & Migrate contracts to the blockchain

```
sudo npm install -g truffle
```

### Contract compile and migrate

```
truffle compile
```

```
truffle migrate
```

### Token: PRT (Property Token)
### Contract address: 0xb869e7f000fdefaa407fdf61f113bee12520b392

### ABI JSON Code:

```[
     {
       "constant": true,
       "inputs": [
         {
           "name": "_interfaceId",
           "type": "bytes4"
         }
       ],
       "name": "supportsInterface",
       "outputs": [
         {
           "name": "",
           "type": "bool"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [],
       "name": "name",
       "outputs": [
         {
           "name": "",
           "type": "string"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "getApproved",
       "outputs": [
         {
           "name": "",
           "type": "address"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": false,
       "inputs": [
         {
           "name": "_to",
           "type": "address"
         },
         {
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "approve",
       "outputs": [],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "function"
     },
     {
       "constant": false,
       "inputs": [
         {
           "name": "_to",
           "type": "address"
         },
         {
           "name": "_propertyAddress",
           "type": "string"
         },
         {
           "name": "_ownerName",
           "type": "string"
         },
         {
           "name": "_ownerEmailAddress",
           "type": "string"
         },
         {
           "name": "_deedURL",
           "type": "string"
         }
       ],
       "name": "transferProperty",
       "outputs": [
         {
           "name": "success",
           "type": "bool"
         }
       ],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [],
       "name": "totalSupply",
       "outputs": [
         {
           "name": "",
           "type": "uint256"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [],
       "name": "InterfaceId_ERC165",
       "outputs": [
         {
           "name": "",
           "type": "bytes4"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": false,
       "inputs": [
         {
           "name": "_from",
           "type": "address"
         },
         {
           "name": "_to",
           "type": "address"
         },
         {
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "transferFrom",
       "outputs": [],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "function"
     },
     {
       "constant": false,
       "inputs": [
         {
           "name": "_to",
           "type": "address"
         },
         {
           "name": "_propertyAddress",
           "type": "string"
         },
         {
           "name": "_ownerName",
           "type": "string"
         },
         {
           "name": "_ownerEmailAddress",
           "type": "string"
         }
       ],
       "name": "createProperty",
       "outputs": [
         {
           "name": "success",
           "type": "bool"
         }
       ],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_owner",
           "type": "address"
         },
         {
           "name": "_index",
           "type": "uint256"
         }
       ],
       "name": "tokenOfOwnerByIndex",
       "outputs": [
         {
           "name": "",
           "type": "uint256"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": false,
       "inputs": [
         {
           "name": "_from",
           "type": "address"
         },
         {
           "name": "_to",
           "type": "address"
         },
         {
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "safeTransferFrom",
       "outputs": [],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "exists",
       "outputs": [
         {
           "name": "",
           "type": "bool"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_index",
           "type": "uint256"
         }
       ],
       "name": "tokenByIndex",
       "outputs": [
         {
           "name": "",
           "type": "uint256"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "ownerOf",
       "outputs": [
         {
           "name": "",
           "type": "address"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_owner",
           "type": "address"
         }
       ],
       "name": "balanceOf",
       "outputs": [
         {
           "name": "",
           "type": "uint256"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_propertyAddress",
           "type": "string"
         },
         {
           "name": "index",
           "type": "uint256"
         }
       ],
       "name": "getPropertyOwnerDetails",
       "outputs": [
         {
           "name": "ownerName",
           "type": "string"
         },
         {
           "name": "ownerEmail",
           "type": "string"
         },
         {
           "name": "ownerWalletAddress",
           "type": "address"
         },
         {
           "name": "deedURL",
           "type": "string"
         },
         {
           "name": "_previousIndexExist",
           "type": "bool"
         },
         {
           "name": "_nextIndexExist",
           "type": "bool"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [],
       "name": "symbol",
       "outputs": [
         {
           "name": "",
           "type": "string"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": false,
       "inputs": [
         {
           "name": "_to",
           "type": "address"
         },
         {
           "name": "_approved",
           "type": "bool"
         }
       ],
       "name": "setApprovalForAll",
       "outputs": [],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "function"
     },
     {
       "constant": false,
       "inputs": [
         {
           "name": "_from",
           "type": "address"
         },
         {
           "name": "_to",
           "type": "address"
         },
         {
           "name": "_tokenId",
           "type": "uint256"
         },
         {
           "name": "_data",
           "type": "bytes"
         }
       ],
       "name": "safeTransferFrom",
       "outputs": [],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "tokenURI",
       "outputs": [
         {
           "name": "",
           "type": "string"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "constant": true,
       "inputs": [
         {
           "name": "_owner",
           "type": "address"
         },
         {
           "name": "_operator",
           "type": "address"
         }
       ],
       "name": "isApprovedForAll",
       "outputs": [
         {
           "name": "",
           "type": "bool"
         }
       ],
       "payable": false,
       "stateMutability": "view",
       "type": "function"
     },
     {
       "inputs": [
         {
           "name": "_owner",
           "type": "address"
         },
         {
           "name": "_tokenName",
           "type": "string"
         },
         {
           "name": "_tokenSymbol",
           "type": "string"
         }
       ],
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "constructor"
     },
     {
       "payable": false,
       "stateMutability": "nonpayable",
       "type": "fallback"
     },
     {
       "anonymous": false,
       "inputs": [
         {
           "indexed": true,
           "name": "_to",
           "type": "address"
         },
         {
           "indexed": false,
           "name": "propertyAddress",
           "type": "string"
         }
       ],
       "name": "PropertyTokenCreated",
       "type": "event"
     },
     {
       "anonymous": false,
       "inputs": [
         {
           "indexed": true,
           "name": "_to",
           "type": "address"
         },
         {
           "indexed": false,
           "name": "propertyAddress",
           "type": "string"
         }
       ],
       "name": "PropertyTokenTransferred",
       "type": "event"
     },
     {
       "anonymous": false,
       "inputs": [
         {
           "indexed": true,
           "name": "_from",
           "type": "address"
         },
         {
           "indexed": true,
           "name": "_to",
           "type": "address"
         },
         {
           "indexed": true,
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "Transfer",
       "type": "event"
     },
     {
       "anonymous": false,
       "inputs": [
         {
           "indexed": true,
           "name": "_owner",
           "type": "address"
         },
         {
           "indexed": true,
           "name": "_approved",
           "type": "address"
         },
         {
           "indexed": true,
           "name": "_tokenId",
           "type": "uint256"
         }
       ],
       "name": "Approval",
       "type": "event"
     },
     {
       "anonymous": false,
       "inputs": [
         {
           "indexed": true,
           "name": "_owner",
           "type": "address"
         },
         {
           "indexed": true,
           "name": "_operator",
           "type": "address"
         },
         {
           "indexed": false,
           "name": "_approved",
           "type": "bool"
         }
       ],
       "name": "ApprovalForAll",
       "type": "event"
     }
   ]
```

### 1. Creating a property token using Web3.

Function name: createProperty

Input fields to create a property:

     Owner wallet address
     Property address
     Owner name
     Owner email address
     
Response:

     success (boolean field): true if token created successfully, else it return false
     
Event emitted:

    PropertyTokenCreated: Once the property token is successfully created and added to owner's wallet address,
    then PropertyTokenCreated event is emitted.
    
    Data returned:
    
        _to: Property owner's wallet address
        propertyAddress

### 2. Getting property details using property address using Web3.

Function name: getPropertyOwnerDetails

Input fields:

     Property address
     Index (You need to pass 1 as default value)
     
Output fields:
     Owner name
     Owner email
     Owner wallet address
     Deed URL

### 3. Get full title history associated with property using the address.

Function name: getPropertyOwnerDetails

Input fields:

     Property address
     Index (To show current owner of property, index = 1)
     
Output fields:

     Owner name
     Owner email
     Owner wallet address
     Deed URL
     Previous index exist (It is the boolean value, which is set to true in the case there is some
     previous owner exists. If previous index exist then the value of index will become index-1 and
     call the same function to get previous owner's details.)
     Next index exist (It is the boolean value, which is set to true in the case there is some
     next owner exists. If next index exist then the value of index will become index+1 and call
     the same function to get next owner's details.)
