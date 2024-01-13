import { ethers } from "hardhat";

async function main() {
  const [deployer, member1] = await ethers.getSigners();
  const eventTime = Math.floor(Date.now() / 1000) + 60 * 60 * 24 * 7; // 7 days from now
  const price = ethers.parseEther("2");
  const mintableTicket = 1700;

  const Eventii = await ethers.deployContract("Eventii", [deployer.address, "EthDenver Hackathon", eventTime, price, mintableTicket]);

  await Eventii.waitForDeployment();

  console.log(`Eventii deployed to ${Eventii.target}` );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
