require("@nomicfoundation/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: {
    version: "0.8.24",
    settings: {
      evmVersion: "paris",
      optimizer: { enabled: true, runs: 200 }
    }
  },
  networks: {
    etherlinkShadownet: {
      url: "https://node.shadownet.etherlink.com",
      chainId: 127823,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};