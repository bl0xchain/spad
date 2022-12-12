const API_KEY = process.env.API_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const CONTRACT_ADDRESS = "0xc7C3Cd4A0727DD38F8C619c080aB72358795b230";

const contract = require("../artifacts/contracts/SPADFactory.sol/SPADFactory.json");

// Provider
const alchemyProvider = new ethers.providers.AlchemyProvider(network="goerli", API_KEY);
// Signer
const signer = new ethers.Wallet(PRIVATE_KEY, alchemyProvider);
// Contract
const spadFactoryContract = new ethers.Contract(CONTRACT_ADDRESS, contract.abi, signer);

async function main() {
    console.log("Updating the SpadActionAddress...");
    const tx = await spadFactoryContract.setSpadActionAddress("0xe701078B649464499256a196B901e3A698b08BE0");
    await tx.wait();
    console.log("Updated the SpadActionAddress...");
}
main();
