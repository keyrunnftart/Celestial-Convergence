const hre = require("hardhat");

async function main() {
  console.log("Deploying Celestial Convergence to Etherlink Shadownet...");
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deployer:", deployer.address);
  console.log("Balance:", hre.ethers.formatEther(
    await hre.ethers.provider.getBalance(deployer.address)
  ), "XTZ");

  const CC = await hre.ethers.getContractFactory("CelestialConvergence");
  const cc = await CC.deploy();
  await cc.waitForDeployment();
  const addr = await cc.getAddress();
  console.log("✅ CelestialConvergence deployed to:", addr);
  console.log("Update CONTRACT_ADDRESS in .env with:", addr);
}

main().catch((e) => { console.error(e); process.exit(1); });