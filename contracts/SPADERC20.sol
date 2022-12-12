// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.17;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract SPADERC20 is OwnableUpgradeable, ERC20Upgradeable {
    uint8 private decimal;

    function initialize(string memory name, string memory symbol, uint _totalSupply, uint8 _decimal) public initializer {
        __ERC20_init(name, symbol);
        __Ownable_init();
        decimal = _decimal;
        _mint(msg.sender, _totalSupply);
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external onlyOwner {
        _burn(account, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return decimal;
    }
}