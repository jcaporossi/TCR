pragma solidity ^0.8.0;

import "../../PLCRVoting/contracts/PLCRFactory.sol";
import "../../PLCRVoting/contracts/PLCRVoting.sol";
import "./Parameterizer.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ParameterizerFactory {

    event NewParameterizer(address creator, address token, address plcr, Parameterizer parameterizer);

    PLCRFactory public plcrFactory;
    ProxyFactory public proxyFactory;
    Parameterizer public canonizedParameterizer;

    /// @dev constructor deploys a new canonical Parameterizer contract and a proxyFactory.
    constructor(PLCRFactory _plcrFactory) {
        plcrFactory = _plcrFactory;
        proxyFactory = plcrFactory.proxyFactory();
        canonizedParameterizer = new Parameterizer();
    }

    /*
    @dev deploys and initializes a new Parameterizer contract that consumes a token at an address
    supplied by the user.
    @param _token             an EIP20 token to be consumed by the new Parameterizer contract
    @param _plcr              a PLCR voting contract to be consumed by the new Parameterizer contract
    @param _parameters        array of canonical parameters
    */
    function newParameterizerBYOToken(
        address _token,
        uint[] memory _parameters
    ) public returns (Parameterizer) {
        PLCRVoting plcr = plcrFactory.newPLCRBYOToken(_token);
        Parameterizer parameterizer = Parameterizer(proxyFactory.createProxy(address(canonizedParameterizer), ""));

        parameterizer.init(
            _token,
            address(plcr),
            _parameters
        );
        emit NewParameterizer(msg.sender, _token, address(plcr), parameterizer);
        return parameterizer;
    }

    /*
    @dev deploys and initializes new EIP20, PLCRVoting, and Parameterizer contracts
    @param _supply            the total number of tokens to mint in the EIP20 contract
    @param _name              the name of the new EIP20 token
    @param _decimals          the decimal precision to be used in rendering balances in the EIP20 token
    @param _symbol            the symbol of the new EIP20 token
    @param _parameters        array of canonical parameters
    */
    function newParameterizerWithToken(
        uint _supply,
        string memory _name,
        //uint8 _decimals,
        string memory _symbol,
        uint[] memory _parameters
    ) public returns (Parameterizer) {
        // Creates a new EIP20 token & transfers the supply to creator (msg.sender)
        // Deploys & initializes a new PLCRVoting contract
        PLCRVoting plcr = plcrFactory.newPLCRWithToken(_supply, _name, _symbol);
        IERC20 token = IERC20(plcr.token());
        token.transfer(msg.sender, _supply);

        // Create & initialize a new Parameterizer contract
        Parameterizer parameterizer = Parameterizer(proxyFactory.createProxy(address(canonizedParameterizer), ""));
        parameterizer.init(
            address(token),
            address(plcr),
            _parameters
        );

        emit NewParameterizer(msg.sender, address(token), address(plcr), parameterizer);
        return parameterizer;
    }
}

