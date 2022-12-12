const { ethers, upgrades } = require('hardhat');

async function main () {
  const SPADFactory = await ethers.getContractFactory('SPADFactory');
  console.log('Deploying SPADFactory...');
  const factory = await upgrades.deployProxy(SPADFactory, [], { initializer: 'initialize' });
  await factory.deployed();
  console.log('SPADFactory deployed to:', factory.address);
}

main();

// Address : 0xc7C3Cd4A0727DD38F8C619c080aB72358795b230