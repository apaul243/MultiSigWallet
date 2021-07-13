// We require the Hardhat Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile 
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const wallet = await hre.ethers.getContractFactory("MultiSigWallet");
  const accounts =  ["0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199","0xdd2fd4581271e230360230f9337d5c0430bf44c0","0xbda5747bfd65f08deb54cb465eb87d40e51b197e","0x2546bcd3c84621e976d8185a91a922ae77ecec30"];
  const confirmations =3;
  const Wallet = await wallet.deploy(accounts,confirmations);
  await Wallet.deployed();
  console.log("Wallet deployed to:", Wallet.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
