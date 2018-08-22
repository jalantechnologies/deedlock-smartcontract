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
    uint8 public decimals;
    string public symbol;
    mapping(string => PropertyTransferInfo[]) propertyTransferDetails;
    uint256 public propertyTokenCreationLimit = 100000000000000000000000000;

    event PropertyTokenCreated(address indexed _to, string propertyAddress);
    event PropertyTokenTransferred(address indexed _to, string propertyAddress);

    constructor (address _owner, string _tokenName, string _tokenSymbol) public ERC721Token(_tokenName, _tokenSymbol) {
    }

    function createProperty(address _to, string _propertyAddress, string _ownerName, string _ownerEmailAddress) public returns (bool success) {
        require(allTokens.length < propertyTokenCreationLimit);
        uint256 _tokenId = allTokens.length + 1;
        super._mint(_to, _tokenId);
        super._setTokenURI(_tokenId, _propertyAddress);
        allTokensIndex[_tokenId] = allTokens.length;
        allTokens.push(_tokenId);
        propertyTransferDetails[_propertyAddress].push(PropertyTransferInfo(Owner(_ownerName, _ownerEmailAddress, _to), "", _tokenId));
        emit PropertyTokenCreated(_to, _propertyAddress);
        return true;
    }

    function getPropertyOwnerDetails(string _propertyAddress, uint index) constant returns (string ownerName, string ownerEmail, address ownerWalletAddress, string deedURL) {
        uint256 length = propertyTransferDetails[_propertyAddress].length;
        require(length > 0);
        require(length >= index);
        uint256 tokenIndex = propertyTransferDetails[_propertyAddress][length - index].tokenId;
        require(keccak256(tokenURIs[tokenIndex]) == keccak256(_propertyAddress));
        return (propertyTransferDetails[_propertyAddress][length - index].owner.name,
        propertyTransferDetails[_propertyAddress][length - index].owner.email,
        propertyTransferDetails[_propertyAddress][length - index].owner.walletAddress,
        propertyTransferDetails[_propertyAddress][length - index].deedURL);
    }

    function checkPreviousNextIndexExist(string _propertyAddress, uint index) constant returns (bool _previousIndexExist, bool _nextIndexExist) {
        uint256 length = propertyTransferDetails[_propertyAddress].length;
        bool previousIndexExist = false;
        bool nextIndexExist = false;
        if (length >= (index + 1) && (index + 1) > 0) {
            previousIndexExist = true;
        }
        if (length >= (index - 1) && (index - 1) > 0) {
            nextIndexExist = true;
        }
        return (previousIndexExist, nextIndexExist);
    }

    function transferProperty(address _to, string _propertyAddress, string _ownerName, string _ownerEmailAddress, string _deedURL) public returns (bool success) {
        require(_to != address(0));
        require(propertyTransferDetails[_propertyAddress].length > 0);
        address _from = propertyTransferDetails[_propertyAddress][currentOwnerIndex].owner.walletAddress;
        uint currentOwnerIndex = propertyTransferDetails[_propertyAddress].length - 1;
        require(bytes(_deedURL).length > 0);
        uint256 _tokenId = propertyTransferDetails[_propertyAddress][0].tokenId;

        address owner = ownerOf(_tokenId);
        require(_to != owner);
        require(_from == owner || isApprovedForAll(owner, _from));

        if (getApproved(_tokenId) != address(0) || _to != address(0)) {
            tokenApprovals[_tokenId] = _to;
            propertyTransferDetails[_propertyAddress].push(PropertyTransferInfo(Owner(_ownerName, _ownerEmailAddress, _to), _deedURL, _tokenId));
            removeTokenFrom(_from, _tokenId);
            addTokenTo(_to, _tokenId);
            emit PropertyTokenTransferred(_to, _propertyAddress);
            return true;
        } else {
        return false;
    }
}
