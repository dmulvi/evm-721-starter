require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
const dotenv = require("dotenv");

dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  defaultNetwork: "goerli",
  networks: {
    goerli: {
      url: process.env.GOERLI_RPC_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
    mumbai: {
      url: process.env.MUMBAI_RPC_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
    matic: {
      url: process.env.MAINNET_RPC_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    ganache: {
      url: "http://127.0.0.1:7545",
      chainId: 5777
    },
    hardhat: {
      chainId: 31337
    },
  },
  etherscan: {
    apiKey: {
        goerli: process.env.ETHERSCAN_KEY,
        polygonMumbai: process.env.POLYGONSCAN_KEY
    }
  }
};
