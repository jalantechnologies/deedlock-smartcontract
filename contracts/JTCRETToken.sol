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
    }

    string public name;
    uint8 public decimals;
    string public symbol;
    mapping(string => PropertyTransferInfo[]) propertyTransferDetails;

    event PropertyTokenCreated(address indexed _to, string propertyAddress, uint tokenId);
    event PropertyTokenTransferred(address indexed _to, string propertyAddress, uint tokenId);

    constructor (address _owner, string _tokenName, string _tokenSymbol) public ERC721Token(_tokenName, _tokenSymbol) {
    }

    function createProperty(address _to, string _propertyAddress, string _ownerName, string _ownerEmailAddress, uint _tokenId) public returns (bool success) {
        super._mint(_to, _tokenId);
        super._setTokenURI(_tokenId, _propertyAddress);
        allTokensIndex[_tokenId] = allTokens.length;
        allTokens.push(_tokenId);
        propertyTransferDetails[_propertyAddress].push(PropertyTransferInfo(Owner(_ownerName, _ownerEmailAddress, _to), ""));
        emit PropertyTokenCreated(_to, _propertyAddress, _tokenId);
        return true;
    }

    function getPropertyOwnerDetails(string _propertyAddress, uint index) constant returns (string ownerName, string ownerEmail, address ownerWalletAddress, string deedURL, bool _previousIndexExist, bool _nextIndexExist) {
        uint length = propertyTransferDetails[_propertyAddress].length;
        require(length > 0);
        require(length >= index);
        uint requestedIndex = length - index;
        bool previousIndexExist = false;
        bool nextIndexExist = false;
        if (length >= (index + 1) && (index + 1) > 0) {
            previousIndexExist = true;
        }
        if (length >= (index - 1) && (index - 1) > 0) {
            nextIndexExist = true;
        }
        return (propertyTransferDetails[_propertyAddress][requestedIndex].owner.name, propertyTransferDetails[_propertyAddress][requestedIndex].owner.email,
          propertyTransferDetails[_propertyAddress][requestedIndex].owner.walletAddress, propertyTransferDetails[_propertyAddress][requestedIndex].deedURL, previousIndexExist, nextIndexExist);
    }

    function transferProperty(address _to, string _propertyAddress, string _ownerName, string _ownerEmailAddress, string _deedURL, uint _tokenId) public returns (bool success) {
        require(propertyTransferDetails[_propertyAddress].length > 0);
        uint currentOwnerIndex = propertyTransferDetails[_propertyAddress].length - 1;
        require(propertyTransferDetails[_propertyAddress][currentOwnerIndex].owner.walletAddress == msg.sender);
        require(bytes(_deedURL).length > 0);
        super._mint(_to, _tokenId);
        propertyTransferDetails[_propertyAddress].push(PropertyTransferInfo(Owner(_ownerName, _ownerEmailAddress, _to), _deedURL));
        emit PropertyTokenTransferred(_to, _propertyAddress, _tokenId);
        return true;
    }
}
