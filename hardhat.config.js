require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
const ALCHEMY_API_KEY = "9c4d37d7dd984bb2b652d085e142ddf5";

const GOERLI_PRIVATE_KEY =
  "0febd531724d95ed9e8a95434eff1574cdcdec9ff896c7189caba809d7fbebd6";

module.exports = {
  solidity: "0.8.9",
  networks: {
    goerli: {
      url: `https://rpc.test.btcs.network`,
      accounts: [GOERLI_PRIVATE_KEY],
      gasLimit: 50000000,
      chainId: 1115,
    },
  },
};
