**EVM ERC-721 Starter Contract**

This is an example project to quickly get an NFT contract started. It is only a sample. You will very likely need to modify it to fit your needs. No warranty or guarantee of any sort is included with this ***SAMPLE*** software package.

**Getting Started**

Clone (or fork) this repository

`git clone git@github.com:Crossmint/evm-721-starter.git`

Install the dependencies

`yarn install`

Copy the .env file template

`cp sample.env .env`

Add required environment variables

```env
GOERLI_RPC_URL=
ETHERSCAN_KEY=
PUBLIC_KEY=
PRIVATE_KEY=
```

1. You can get RPC urls from providers such as https://infura.io/, https://www.alchemy.com/, etc. 

2. Get an Etherscan key (to verify your contract)
https://info.etherscan.com/etherscan-developer-api-key/

3. Save your public key address to the .env file

4. Export private key from metamask or another wallet. You should not use the same wallet that you store mainnet assets in. Create a new development only metamask account to minimize the risk of storing your private key in plaintext files. 

---
**Initial adjustments**
1. You'll probably want to rename the contract. Change the filename in `/contracts/Evm721Starter.sol` to a name of your choosing. Then open that file and change the name there to. For example:

`contract Evm721Starter is ERC721, AccessControl` 
changes to

`contract MyNewName is ERC721, AccessControl`

2. Then you'll also need to update the `/scripts/deploy.js` to reference this new file name. Select all instances of `Evm721Starter` and change to `MyNewName` (or whatever you set the name to).

3. You will probably want to change the deployed name to by updating the arguments in the constructor on line 26. 

**Deploy the contract to a testnet**

`npx hardhat run --network goerli scripts/deploy.js`

Wait about a minute and then verify the Contract. (You'll need an etherscan API key)

`npx hardhat verify --network goerli "0x__CONTRACT_ADDR_FROM_PREVIOUS_STEP__"`

---

Now you have a test contract deployed!

Next steps:

* interact with the contract via etherscan by navigating to the writeContract tab on goerli.etherscan.com. Maybe try updating the baseUri?
* add crossmint support! It's super easy! https://docs.crossmint.io/docs
* you'll also need to deploy the actual metadata to IPFS 