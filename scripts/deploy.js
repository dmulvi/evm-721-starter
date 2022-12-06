const hre = require("hardhat");

async function main() {
  const Evm721StarterNFT = await hre.ethers.getContractFactory("Evm721Starter");
  const Evm721Starter = await Evm721StarterNFT.deploy();

  await Evm721Starter.deployed();

  console.log("Evm721Starter deployed to:", Evm721Starter.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
