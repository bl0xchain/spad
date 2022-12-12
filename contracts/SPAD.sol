// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
// import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
// import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./SPADERC20.sol";

contract SPAD {
    SPADERC20 public spadToken;
    address tokenImplementation;
    uint public target;
    // uint public currentInvestment;
    uint public minInvestment;
    uint public maxInvestment;
    address public spadInitiator;
    uint8 public status; // 1:PENDING, 2:LIVE, 3:EXPIRED, 4:CLOSED, 5:ACQUIRED
    string private passKey;
    bool public isPrivate;
    address spadActionController;
    uint public created;
    address public currencyAddress;
    // bool private initiazlied = false;

    event StatusUpdated(uint8 status);
    // event SpadActionControllerUpdated(address spadActionController);
    // event CurrentInvestmentUpdated(uint investment);
    // event PassKeyUpdated(string passKey);

    function initialize(string memory _name, string memory _symbol, uint _totalSupply, address _spadInitiator, uint _target, uint _minInvestment, uint _maxInvestment, string memory _passKey, address _currencyAddress, address _spadActionController) public {
        // require(initiazlied == false, "already initialized");
        uint8 digits = 18;
        target = _target;
        minInvestment = _minInvestment;
        maxInvestment = _maxInvestment;
        spadInitiator = _spadInitiator;
        if(_currencyAddress != address(0)) {
            digits = IERC20MetadataUpgradeable(_currencyAddress).decimals();
        }
        // spadToken = new SPADERC20();
        tokenImplementation = address(new SPADERC20());
        ERC1967Proxy proxy = new ERC1967Proxy(
            tokenImplementation,
            abi.encodeWithSelector(SPADERC20(tokenImplementation).initialize.selector, _name, _symbol, _totalSupply, digits)
        );
        // spadToken.initialize(_name, _symbol, _totalSupply, digits);
        spadToken = SPADERC20(address(proxy));
        spadToken.transfer(_spadActionController, _totalSupply);
        passKey = _passKey;
        spadActionController = _spadActionController;
        if(keccak256(abi.encodePacked(_passKey)) != keccak256(abi.encodePacked(""))) {
            isPrivate = true;
        }
        currencyAddress = _currencyAddress;
        status = 1;
        created = block.timestamp;
        // initiazlied = true;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {}

    function checkPassKey(string memory _passKey) public view returns (bool) {
        return (keccak256(abi.encodePacked(_passKey)) == keccak256(abi.encodePacked(passKey)));
    }

    function isController() internal view {
        require(msg.sender == spadActionController, "not allowed");
    }

    function updateStatus(uint8 _status) public {
        isController();
        status = _status;
        emit StatusUpdated(_status);
    }

    // function updateSpadActionController(address _actionController) public {
    //     isController();
    //     spadActionController = _actionController;
    //     emit SpadActionControllerUpdated(spadActionController);

    // }

    // function updateCurrentInvestment(uint _currentInvestment) public {
    //     isController();
    //     currentInvestment = _currentInvestment;
    //     emit CurrentInvestmentUpdated(currentInvestment);
    // }

    // function updatePassKey(string memory _passKey) public {
    //     isController();
    //     passKey = _passKey;
    //     emit PassKeyUpdated(passKey);
    // }
}