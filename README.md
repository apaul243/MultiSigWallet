# MultiSigWallet

Multisigwallet provides a higher level of security as compared to regular wallets. 'N' number of owners have to agree on a transaction before it can be executed on the network. It provides security against any unilateral action which can be taken by just one owner. This application has been created using the Hardhat develpoment environment with two major Solidity contracts that have been tested using the Truffle framework and finally integrated with a React-based frontend. 

(NOTE : Latest versions of MultiSigWallet perform transaction initiation and transaction confirmation offchain. Only operation that takes place on-chain is the execution. This version has been created for understanding Solidity and creating a working, end-to-end application)

<b>INSTALLATION</b> 

<b>SETTING UP HARDHAT ENVIRONMENT</b> 

1. Clone the GitHub repo using : git clone {repo-url} ( enter the repository url without the curly braces) 
2. Inside the repo folder, open terminal and run the following command : npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers
3. Compile your smart contracts: npx hardhat compile
4. Run your tests: npx hardhat test
5. Fire up your local hardhat instance : npx hardhat node ( This will automatically create a blockchain and provide you with 20 account addresses used to deploy and test your smart contracts. Each account is also loaded up with 10,000 fake Ether.)
6. Finally, deploy the smart contracts on your local hardhat instance : npx hardhat run scripts/deploy.js --network localhost

<b>SETTING UP REACT APP</b> 

1. Run the following command to create the react-app: npx create-react-app react-dapp
2. npm start
3. Go to localhost:3000 to use the multisig wallet application

<b>HOW DOES THE WALLET WORK ? </b>

● Wallet can be initiated by passing a list of owners and the minimum no of confirmations 'N' required to execute a transaction. \
● Any of the owners can initiate a transaction which will emit the "SubmitTransaction" event on the network. \
● Owners can confirm the indexed transaction by passing the appropriate index number which will emit the "ConfirmTransaction" event. \
● Any of the owners can execute the transaction if sufficient number of confirmations have been gathered, the transaction will be executed. \
● There are other available methods to check the state of the smart contract like: getOwners(), getTransaction(uint index),getTransactionList() 

<b> TECH OVERVIEW </b>

● Application has been created with HardHat framework with HardHat providing automatic compiling of smart contracts stored inside /contracts and running tests  inside /test. Any other deployement scripts are stored in the /scripts folder. \
● Smart contracts have been tested using Truffle framework \
● An interactive react-based frontend has been created which can be used as follows: \
--> Connect to Metamask wallet with the network set to Ropsten (or LocalHost if you are just testing it on your Local hardhat environment) \
--> Create a new wallet by passing the owner addresses and minimum number of confirmations required \
--> Create a transaction by passing the following fields on the UI : To, Value and Data \
--> Confirm the transaction from N wallet owners ( by switching Metamask account) \
--> Finally click on 'Execute Transaction' to complete it. \
● You can also use the application without the UI, by simply changing the account numbers in deploy.js \




