pragma solidity ^0.4.24;

import "./ERC721Token.sol";

contract JTCRETToken is ERC721Token {

    function () public {
        //if ether is sent to this address, send it back.
        revert();
    }

    struct Owner {
        string name;
        string email;
        address walletAddress;
    }

    struct PropertyTransferInfo {
        Owner owner;
        string deedURL;
        uint256 tokenId;
    }

    string public name;
    string public symbol;
    mapping(string => PropertyTransferInfo[]) propertyTransferDetails;

    event PropertyTokenCreated(address indexed _to, string propertyAddress);
    event PropertyTokenTransferred(address indexed _to, string propertyAddress);

    constructor (address _owner, string _tokenName, string _tokenSymbol) public ERC721Token(_tokenName, _tokenSymbol) {
    }

    function createProperty(address _to, string _propertyAddress, string _ownerName, string _ownerEmailAddress) public returns (bool success) {
        // all tokens is a array of token ids created by the contract
        uint256 _tokenId = allTokens.length + 1;
        // _mint function is use to create new ERC-721 tokens
        super._mint(_to, _tokenId);
        // setTokenURI function is used to set a token's URI data
        super._setTokenURI(_tokenId, _propertyAddress);
        // storing property owner details in token's metadata
        propertyTransferDetails[_propertyAddress].push(PropertyTransferInfo(Owner(_ownerName, _ownerEmailAddress, _to), "", _tokenId));
        // emiting PropertyTokenCreated event once a token is created and transfered to owner's account
        emit PropertyTokenCreated(_to, _propertyAddress);
        return true;
    }

    function getPropertyOwnerDetails(string _propertyAddress, uint index) public constant returns (string ownerName, string ownerEmail, address ownerWalletAddress, string deedURL, bool _previousIndexExist, bool _nextIndexExist) {
        // fetching total number of property owners
        uint256 length = propertyTransferDetails[_propertyAddress].length;
        // checking if there is any property token history
        require(length > 0);
        require(length >= index);
        PropertyTransferInfo storage propertyTransferDetail = propertyTransferDetails[_propertyAddress][length - index];
        bool previousIndexExist = false;
        bool nextIndexExist = false;
        if (length >= (index + 1) && (index + 1) > 0) {
            previousIndexExist = true;
        }
        if (length >= (index - 1) && (index - 1) > 0) {
            nextIndexExist = true;
        }
        return (propertyTransferDetail.owner.name,
        propertyTransferDetail.owner.email,
        propertyTransferDetail.owner.walletAddress,
        propertyTransferDetail.deedURL, previousIndexExist, nextIndexExist);
    }

    function transferProperty(address _to, string _propertyAddress, string _ownerName, string _ownerEmailAddress, string _deedURL) public returns (bool success) {
        // checking the address to which we are transfering property token is not (0x00000000...00)
        require(_to != address(0));
        // checking if property token exists or not
        require(propertyTransferDetails[_propertyAddress].length > 0);
        // fetching the wallet address which holds the property address token
        address _from = msg.sender;
        uint currentOwnerIndex = propertyTransferDetails[_propertyAddress].length - 1;
        // deedURL is required field to transfer any property token
        require(bytes(_deedURL).length > 0);
        uint256 _tokenId = propertyTransferDetails[_propertyAddress][currentOwnerIndex].tokenId;

        address owner = ownerOf(_tokenId);
        require(_to != owner);
        require(_from == owner || isApprovedForAll(owner, _from));
        tokenApprovals[_tokenId] = _to;
        propertyTransferDetails[_propertyAddress].push(PropertyTransferInfo(Owner(_ownerName, _ownerEmailAddress, _to), _deedURL, _tokenId));
        // removeTokenFrom function removes the property token from previous owner's account
        removeTokenFrom(_from, _tokenId);
        // addTokenTo function adds property token to new owner's account
        addTokenTo(_to, _tokenId);
        // Once the property is transfered to new owner's account PropertyTokenTransferred event is emitted
        emit PropertyTokenTransferred(_to, _propertyAddress);
        return true;
    }

    function getRecentlyCreatedPropertyAddress() public constant returns (uint, string, string, string) {
        string memory propertyAddress1 = '';
        string memory propertyAddress2 = '';
        string memory propertyAddress3 = '';
        if (allTokens.length >= 1) {
            propertyAddress1 = tokenURIs[allTokens.length];
            if (allTokens.length >= 2) {
                propertyAddress2 = tokenURIs[allTokens.length - 1];
                if (allTokens.length >= 3) {
                    propertyAddress3 = tokenURIs[allTokens.length - 2];
                }
            }
        }
        return (allTokens.length, propertyAddress1, propertyAddress2, propertyAddress3);
    }
}
