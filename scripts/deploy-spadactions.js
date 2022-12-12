const { ethers, upgrades } = require('hardhat');

async function main () {
  const SPADActions = await ethers.getContractFactory('SPADActions');
  console.log('Deploying SPADActions...');
  const spadActions = await upgrades.deployProxy(SPADActions, ["0xc7C3Cd4A0727DD38F8C619c080aB72358795b230"], { initializer: 'initialize' });
  await spadActions.deployed();
  console.log('SPADActions deployed to:', spadActions.address);
}

main();

// Address : 0xe701078B649464499256a196B901e3A698b08BE0