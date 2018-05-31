pragma solidity ^0.4.21;
import './ERC20.sol';

contract JTCRET is ERC20 {
  address public owner;
  string public propertyAddress;
  struct OwnerDetails {
    string email;
    string deedHash;
  }
  OwnerDetails[] public ownerDetails;

  function JTCRET() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
  function generateJTCRETToken(string _propertyAddress) public returns(bool success) {
      require(bytes(_propertyAddress).length > 0);
      return true;
  }
  function transferFrom(address _from, address _to, uint _value) public  returns (bool success) {
      return true;
  }
  function approve(address _spender, uint _value) public returns (bool success) {
      return true;
  }
}