import { ethers } from "hardhat";

async function main() {
  const [deployer, member1] = await ethers.getSigners();

  ////0. Deploy Factory Contract
  const Factory = await ethers.deployContract("MinimalProxyFactory");
  await Factory.waitForDeployment();
  console.log(`Factory deployed to ${Factory.target}` );

  ////// 1. Deploy _implementationContract Contract
  const _implementationContract = await ethers.deployContract("Eventii");
  await _implementationContract.waitForDeployment();
  console.log(`_implementationContract deployed to ${_implementationContract.target}` );

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
