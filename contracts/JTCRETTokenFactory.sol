pragma solidity ^0.4.15;
import "./Factory.sol";
import "./JTCRETToken.sol";

contract JTCRETTokenFactory is Factory {

    /*
     * Public functions
     */
    /// @param _owner Owner
    /// @return Returns Token contract address
    function create(address _owner, string _tokenName, string _tokenSymbol)
        public
        returns (address wallet)
    {
        wallet = new JTCRETToken(_owner, _tokenName, _tokenSymbol);
        register(wallet);
    }
}