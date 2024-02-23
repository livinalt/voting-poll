import { ethers } from "hardhat";

async function main() {
  
  const votingPoll = await ethers.deployContract("VotingPoll");

  await votingPoll.waitForDeployment();

  console.log(
    `VotingPoll has been deployed to ${votingPoll.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
