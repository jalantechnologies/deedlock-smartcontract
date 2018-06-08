pragma solidity ^0.4.4;

import "./StandardToken.sol";

contract JTCRETToken is StandardToken {

    function () public {
        //if ether is sent to this address, send it back.
        revert();
    }

    string public name;
    uint8 public decimals;
    string public symbol;

    function JTCRETToken() public {
        balances[msg.sender] = 100000000000000000000000000;
        totalSupply = 100000000000000000000000000;
        name = "JTCRET TOKEN";
        decimals = 0;
        symbol = "JTCRET";
    }

    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
}
