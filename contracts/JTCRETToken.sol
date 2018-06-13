pragma solidity ^0.4.4;
pragma experimental ABIEncoderV2;

import "./StandardToken.sol";

contract JTCRETToken is StandardToken {

    function () public {
        //if ether is sent to this address, send it back.
        revert();
    }

    string public name;
    uint8 public decimals;
    string public symbol;

    struct Property {
        uint id;
        string propertyAddress;
        address[] ownerDetails;
    }

    struct OwnerDetails {
        string ownerName;
        string ownerEmail;
        string deedURL;
        address propertyAddress;
    }
    mapping (uint => Property) public property;
    mapping (address => OwnerDetails) public ownerDetails;
    uint totalProperties;

    function JTCRETToken(address _owner, string _tokenName, string _tokenSymbol) public {
        balances[_owner] = 100000000000000000000000000;
        totalSupply = 100000000000000000000000000;
        name = _tokenName;
        symbol = _tokenSymbol;
        decimals = 0;
    }

    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);

        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        if(!_spender.call(bytes4(bytes32(keccak256("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { revert(); }
        return true;
    }

    function createProperty(address _to, uint256 _value, string _propertyAddress, string _ownerName, string _ownerEmail, string _deedURL) public returns (bool success) {
        //Default assumes totalSupply can't be over max (2^256 - 1).
        //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
        //Replace the if with this one instead.
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            totalProperties++;
            property[totalProperties].id = totalProperties;
            property[totalProperties].propertyAddress = _propertyAddress;
            ownerDetails[_to].ownerName = _ownerName;
            ownerDetails[_to].ownerEmail = _ownerEmail;
            ownerDetails[_to].deedURL = _deedURL;
            property[totalProperties].ownerDetails.push(_to);
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }

    function getPropertyIds() public constant returns (uint[] _propertyId) {
        // we check whether there is at least one property
        require(totalProperties > 0);
        uint[] memory allPropertyIds = new uint[](totalProperties);
        uint numberOfProperties = 0;
        for (uint i = 1; i <= totalProperties; i++) {
            allPropertyIds[numberOfProperties] = i;
            numberOfProperties ++;
        }
        return allPropertyIds;
    }

    function getPropertyOwnerDetails(uint _propertyId) public constant returns (
        string _propertyAddress,
        string[] _ownerName,
        string[] _ownerEmail,
        string[] _deedURL) {
        Property memory _property = property[_propertyId];
        string[] memory ownersNames = new string[](_property.ownerDetails.length);
        string[] memory ownersEmails = new string[](_property.ownerDetails.length);
        string[] memory deedURLS = new string[](_property.ownerDetails.length);
        for (uint i = 0; i < _property.ownerDetails.length; i++) {
            OwnerDetails memory ownerDetail = ownerDetails[_property.ownerDetails[i]];
            ownersNames[i] = ownerDetail.ownerName;
            ownersEmails[i] = ownerDetail.ownerEmail;
            deedURLS[i] = ownerDetail.deedURL;
        }
        return (_property.propertyAddress, ownersNames, ownersEmails, deedURLS);
    }
}
