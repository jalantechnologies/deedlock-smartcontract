pragma solidity ^0.4.4;

import "./StandardToken.sol";

contract JTCRETToken is StandardToken {

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

    event PropertyTokenCreated(address indexed _to, string propertyAddress);

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

    function createProperty(address _to, uint256 _value, string _propertyAddress, string _ownerName, string _ownerEmailAddress) public returns (bool success) {
        //Default assumes totalSupply can't be over max (2^256 - 1).
        //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
        //Replace the if with this one instead.
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            propertyAddress[_to] = _propertyAddress;
            propertyTransferDetails[_propertyAddress].push(PropertyTransferInfo(Owner(_ownerName, _ownerEmailAddress, _to), ""));
            emit PropertyTokenCreated(_to, _propertyAddress);
        return true;
       } else { return false; }
    }

    function getPropertyOwnerDetails(string _propertyAddress, uint index) constant returns (string ownerName, string ownerEmail, address ownerWalletAddress, string deedURL) {
        uint length = propertyTransferDetails[_propertyAddress].length;
        require(length > 0);
        require(length >= index);
        uint requestedIndex = length - index;
        return (propertyTransferDetails[_propertyAddress][requestedIndex].owner.name, propertyTransferDetails[_propertyAddress][requestedIndex].owner.email,
          propertyTransferDetails[_propertyAddress][requestedIndex].owner.walletAddress, propertyTransferDetails[_propertyAddress][requestedIndex].deedURL);
    }
}
