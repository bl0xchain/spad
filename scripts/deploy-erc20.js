const { ethers, upgrades } = require('hardhat');

async function main () {
  const SPADERC20 = await ethers.getContractFactory('SPADERC20');
  console.log('Deploying SPADERC20...');
  const erc20 = await upgrades.deployProxy(SPADERC20, ["Shashank", "SHA", 1000, 18], { initializer: 'initialize' });
  await erc20.deployed();
  console.log('SPADERC20 deployed to:', erc20.address);
}

main();

// Address : 0x404F8A0B7066402F2a6210d4b3A94B810E794AFD