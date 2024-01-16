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


  //params
  const eventTime = Math.floor(Date.now() / 1000) + 60 * 60 * 24 * 7; // 7 days from now
  const price = ethers.parseEther("2");
  const mintableTicket = 1700;
  
  /////-------------------Interaction--------------------------------//
   //deploy Clone function
  const FactoryContract = await ethers.getContractAt("MinimalProxyFactory", Factory.target);
  const EventiiClone = await FactoryContract.deployClone(_implementationContract.target, member1.address, "EthDenver Hackathon", "EH", eventTime, price, mintableTicket );
  await EventiiClone.wait();
  console.log(EventiiClone.value.toString());
  

  // get user Proxies 
  const userProxies = await FactoryContract.getuserProxies(member1.address);
  console.log("userProxies", userProxies);


  //Interact with the clone
  const Eventii = await ethers.getContractAt("Eventii", userProxies[0]);

  //get event name
  const eventName = await Eventii.eventName();
  console.log("eventName", eventName);

  //get event symbol
  const eventSymbol = await Eventii.symbol();
  console.log("eventSymbol", eventSymbol);

  //set setContractTokenURI
  const setContractTokenURI = await Eventii.connect(member1).setContractTokenURI("https://ipfs.io/ipfs/QmR4J9bQ4Rq8ZDQ6Xa3Y4yKgX8xXtjG7qJY3qYzK6s2X3U");
  await setContractTokenURI.wait();
  console.log("setContractTokenURI", setContractTokenURI);

  //get contractTokenURI
  const contractTokenURI = await Eventii.tokenuri();
  console.log("contractTokenURI", contractTokenURI);












}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
