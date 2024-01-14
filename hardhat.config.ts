import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';

require('dotenv').config();
const privatekey1 = process.env.PRIVATE_KEY as string;
const privatekey2 = process.env.PRIVATE_KEY2 as string;
const privatekey3 = process.env.PRIVATE_KEY3 as string;


const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.20',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    toronet_testnet: {
      url: "https://testnet-rpc.areon.network/",
      accounts: [privatekey1, privatekey2, privatekey3],
      chainId: 462
      ,
    },
  },
};

export default config;