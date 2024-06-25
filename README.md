# PowerPool Agent V2 Keeper Node Docker image

The node monitors on-chain events and executes jobs when required.

## Official PPAgentV2 deployments

- Sepolia test contracts:
  - Sepolia testnet Power Agent V2 Proxy Admin contract - <a href="https://sepolia.etherscan.io/address/0xa084eb73fab2fbdc4e86a3bbf1d29bc18bf6ab55" target="_blank">0xa084eb73fab2fbdc4e86a3bbf1d29bc18bf6ab55</a>. 
  - Sepolia testnet Power Agent V2 Proxy contract - <a href="https://sepolia.etherscan.io/address/0xbdE2Aed54521000DC033B67FB522034e0F93A7e5" target="_blank">0xbdE2Aed54521000DC033B67FB522034e0F93A7e5</a>.
  - Sepolia testnet Power Agent V2 Implementation contract - <a href="https://sepolia.etherscan.io/address/0xaE32C29AfE1eB46B4fCa7E5f77e95217eF987332" target="_blank">0xaE32C29AfE1eB46B4fCa7E5f77e95217eF987332</a>.
  - Sepolia testnet Power Agent V2 Lens contract - <a href="https://sepolia.etherscan.io/address/0x937991108511f1850bd476b9ab56433afde7c92a" target="_blank">0x937991108511f1850bd476b9ab56433afde7c92a</a>.
  - Sepolia testnet Power Agent V2 subgraph - <a href="https://api.studio.thegraph.com/query/48711/ppav2-rd-sepolia-b12-ui/version/latest">api.studio.thegraph.com</a>.

- Gnosis chain test contracts:
  - Gnosis chain test Power Agent V2 Proxy contract - <a href="https://gnosisscan.io/address/0x071412e301C2087A4DAA055CF4aFa2683cE1e499" target="_blank">0x071412e301C2087A4DAA055CF4aFa2683cE1e499</a>.
  - Gnosis chain test Power Agent V2 Implementation contract - <a href="https://gnosisscan.io/address/0xda80ff51aafe84bb9463b09a3fc54f3819324692" target="_blank">0xda80ff51aafe84bb9463b09a3fc54f3819324692</a>.
  - Gnosis chain Power Agent V2 Lens contract - <a href="https://gnosisscan.io/address/0x2b3d29daa9f41c4171416af3d66f5a2ae210616e">0x2b3d29daa9f41c4171416af3d66f5a2ae210616e</a>.
  - Gnosis chain test Power Agent V2 subgraph - <a href="https://api.studio.thegraph.com/query/48711/ppav2-rd-gnosis-b12-ui/version/latest">api.studio.thegraph.com</a>.

- Ethereum mainnet test contracts:
  - Ethereum mainnet test Power Agent V2 Proxy Admin contract - <a href="https://etherscan.io/address/0x96c1AA4E6eD3a0579C78038Da7e4A17A19A72106" target="_blank">0x96c1AA4E6eD3a0579C78038Da7e4A17A19A72106</a>.
  - Ethereum mainnet test Power Agent V2 Proxy contract - <a href="https://etherscan.io/address/0xc9ce4CdA5897707546F3904C0FfCC6e429bC4546" target="_blank">0xc9ce4CdA5897707546F3904C0FfCC6e429bC4546</a>.
  - Ethereum mainnet test Power Agent V2 Implementation contract - <a href="https://etherscan.io/address/0x31779098cf5da5e16e4b74cef8608aeac216eda3" target="_blank">0x31779098cf5da5e16e4b74cef8608aeac216eda3</a>.
  - Ethereum mainnet Power Agent V2 Lens contract - <a href="https://etherscan.io/address/0xbB8dAC006c8B6F67c4bc2563b64ed669Faa54F07" target="_blank">0xbB8dAC006c8B6F67c4bc2563b64ed669Faa54F07</a>.
  - Ethereum mainnet test Power Agent V2 subgraph - <a href="https://api.studio.thegraph.com/query/48711/ppav2-rd-maintest-ui/version/latest">api.studio.thegraph.com</a>.

To see active Power Agent V2 deployments, go to <a href="https://app.powerpool.finance/#/sepolia/ppv2/agents-contracts" target="_blank">app.powerpool.finance</a>.

## Creating a Keeper and setting up a node using docker image

### Signing up as a Keeper

To be a keeper, you need at least two keys. (1) One admin key for management and (2) another one for a worker. The management key function is to assign a worker's address and withdraw compensations or initial deposit. The worker key is needed for transaction signing by a node. 

To sign as a Keeper you need to perform the following actions:

#### 1. Open Power Agent dApp
Go to <a href="https://app.powerpool.finance/#/sepolia/ppv2/agents-contracts" target="_blank">app.powerpool.finance</a>. Here, you can see all available Power Agent contracts for the selected network and click the `Create Keeper` button.
<img width="1713" alt="Screenshot 2023-10-10 at 13 38 21" src="https://github.com/powerpool-finance/powerpool-agent-v2-node/assets/69249251/0cb6b280-85a2-475c-9953-69cd0d4cba49">
#### 2. Create your Keeper
In the pop-up modal window, the Admin address will be set automatically to the connected wallet. Manually fill in the Worker address and the CVP stake amount, ensuring it's above the minimum level. Your CVP stake determines the compensation the Keeper receives and their ability to be assigned a job. Sign the approval transaction and then create a Keeper.
<img width="1715" alt="Screenshot 2023-10-10 at 13 39 45" src="https://github.com/powerpool-finance/powerpool-agent-v2-node/assets/69249251/3d454889-3915-4ad7-9757-163e50c2e886">
#### 3. Check My Keepers
You will see all your created keepers in the My Keepers section. 
⚠️ Attention! You have created a Keeper that is not active. Please do not activate it now.
<img width="1712" alt="Screenshot 2023-10-10 at 13 18 27" src="https://github.com/powerpool-finance/powerpool-agent-v2-node/assets/69249251/3c025888-e04b-4bc5-b146-fe87b3afb152">
### Setting up a Power Agent node using docker image

* Install Docker if it hasn't been installed yet. For example, you can find the instructions for Ubuntu here: https://docs.docker.com/engine/install/ubuntu/.
* Clone this repository:
```sh
git clone https://github.com/powerpool-finance/powerpool-agent-v2-compose
cd powerpool-agent-v2-compose
```
* Place a JSON file containing your worker key into the `./keys` folder. You can choose any filename. If you don't yet have a JSON key file, you can use the JSON key generator from this repository. To convert your raw private key to the JSON V3 format, use the following syntax:

  ```sh
  # node jsongen.js <your-private-key> <your-pass>
  yarn
  node jsongen.js 0x0c38f1fb1b2d49ea6c6d255a6e50edf0a7a7fa217639281fe1b24a96efc16995 myPass
  ```

* Copy the main config template:

```sh
cp config/main.template.yaml main.yaml
```
* Edit `main.yaml` using nano, vim or any other editor. 
* You can edit `main.yaml` file and add as many networks and agents as you need. However, at the current stage, it's highly recommended to use only one Network and Power Agent contract.
* Enter your WebSockets RPC node URI in `networks->details->{network_name}->rpc`. The example config might include some RPC nodes, either public ones or those maintained by PowerPool. However, we cannot guarantee that they will operate flawlessly with excellent uptime. To achieve better uptime, it is highly recommended to use your own personal RPC.

* For each Agent contract address (`networks->details->{network_name}->agents->{agent_address}`):
    * Choose  `pga` executor.
    * Put your Keeper worker address into `keeper_address`.
    * Put your Keeper worker json key password into `key_pass`.
    * If you wish to accrue rewards on your balance in the Power Agent contract (which could save a small amount of gas), set `accrue_reward` to `true`. If set to `false`, the compensation will be sent to the worker's address after each job execution. The default value is `false`.
* Please note that you cannot add more than one Keeper for a given agent contract on a single node. If you wish to set up more than one Keeper, we recommend setting up another node, preferably on a different host. Using different RPCs or even different regions are also good options.

* The main.yaml file should look like this example for Sepolia:

```yaml
networks:
  enabled:
    - sepolia
  details:
    sepolia:
      rpc: 'wss://sepolia-1.powerpool.finance'
      agents:
        '0xbdE2Aed54521000DC033B67FB522034e0F93A7e5':
          data_source: subgraph
          subgraph_url: https://api.studio.thegraph.com/query/48711/ppav2-rd-sepolia-b12-ui/version/latest
          executor: pga
          keeper_worker_address: '0x840ccC99c425eDCAfebb0e7ccAC022CD15Fd49Ca'
          key_pass: 'Very%ReliablePassword292'
          accrue_reward: false

```
* The main.yaml file should look like this example for Gnosis chain:

```yaml
networks:
  enabled:
    - gnosis
  details:
    gnosis:
      rpc: 'wss://gnosis-1.powerpool.finance'
      agents:
        '0x071412e301C2087A4DAA055CF4aFa2683cE1e499':
          data_source: subgraph
          subgraph_url: https://api.studio.thegraph.com/query/48711/ppav2-rd-gnosis-b12-ui/version/latest
          executor: pga
          keeper_worker_address: '0x840ccC99c425eDCAfebb0e7ccAC022CD15Fd49Ca'
          key_pass: 'Very%ReliablePassword292'
          accrue_reward: false

```
* The main.yaml file should look like this example for Ethereum mainnet:

```yaml
networks:
  enabled:
    - mainnet
  details:
    mainnet:
      rpc: 'wss://mainnet-1.powerpool.finance'
      agents:
        '0xc9ce4CdA5897707546F3904C0FfCC6e429bC4546':
          data_source: subgraph
          subgraph_url: https://api.studio.thegraph.com/query/48711/ppav2-rd-gnosis-b12-ui/version/latest
          executor: pga
          keeper_worker_address: '0x840ccC99c425eDCAfebb0e7ccAC022CD15Fd49Ca'
          key_pass: 'Very%ReliablePassword292'
          accrue_reward: false
```

* Go back and run a docker container:
```sh
cd ..
docker compose --profile latest up -d
```
<img width="1097" alt="Screenshot 2023-10-10 at 15 29 11" src="https://github.com/powerpool-finance/powerpool-agent-v2-compose/assets/69249251/cb6cd4b2-3732-4f67-bc76-3ab361af03a9">

* Get container ID:
```sh
ubuntu@home:~/powerpool-agent-v2-compose$ docker compose ps

NAME                                            IMAGE                                           COMMAND                  SERVICE            CREATED        STATUS        PORTS
powerpool-agent-v2-compose-agent-latest-1       powerpool/power-agent-node:latest               "./docker-entrypoint…"   agent-latest       21 hours ago   Up 21 hours   0.0.0.0:8199->8199/tcp, :::8199->8199/tcp
powerpool-agent-v2-compose-offchain-service-1   powerpool/power-agent-offchain-service:latest   "docker-entrypoint.s…"   offchain-service   21 hours ago   Up 21 hours   3423/tcp, 0.0.0.0:3424->3424/tcp, :::3424->3424/tcp
```
* Check logs (use SERVICE name):
```sh
docker compose logs agent-latest -f
```
Eventually, you will see the following logs in the console. Pay attention: your keeper is still disabled, so you cannot execute jobs.
<img width="1094" alt="Screenshot 2023-10-10 at 15 28 47" src="https://github.com/powerpool-finance/powerpool-agent-v2-compose/assets/69249251/a3f11c07-98b3-4d22-bd6b-9143017533f1">


### Activate Keeper
Go back to https://app.powerpool.finance/#/sepolia/ppv2/my-keepers, click the 'Complete' button, and then sign the transaction.
<img width="1716" alt="Screenshot 2023-10-10 at 13 29 22" src="https://github.com/powerpool-finance/powerpool-agent-v2-node/assets/69249251/b673c84d-5350-433e-ac57-c22d586f425a">
In the console, you will see that the Keeper was successfully activated. Congratulations!
<img width="1094" alt="Screenshot 2023-10-10 at 15 41 57" src="https://github.com/powerpool-finance/powerpool-agent-v2-compose/assets/69249251/72c455c5-90e1-4196-8913-98fe162bde7e">


## App exit codes

0. Not an actual error, but some condition when it's better to restart an entire app. Used for some event handlers.
1. Critical errors. Should stop the app. For ex. worker address not found, can't resolve RPC, etc.
2. Non-critical errors. Should restart the app. For ex. hanged WS endpoint connection.

## Privacy
The Power Agent node sends basic, anonymous data about transactions to the backend for debugging.

## Updating your Power Agent node

```sh
docker compose --profile latest down
git pull && docker compose pull
docker compose --profile latest up -d
```

## Migrating your keeper to a new Power Agent contract

* Register as a keeper at the new contract.
* Update the contract address in the corresponding config section.
* If you want to use a different address for the keeper worker, update the corresponding fields in the config.
* Update your Power Agent node (see the instructions above).

## Watching Power Agent Node Logs
⚠️ Attention! Don't forget to change container id.
* `docker logs -fn100 e8651565f365` to follow the contanter logs starting from 100 lines behind.
* `docker logs e8651565f365 > out.txt` to save all the container logs to `out.txt` file.

## Run Keeper in Dev Mode with Additional Logging Levels
Run Keeper in development mode with enhanced logging or specific api ports:
```sh
NODE_ENV=dev NODE_API_PORT=8199 OFFCHAIN_API_PORT=3424 docker compose --profile latest up -d
```
This sets the environment to development, increasing log detail, and runs the container in the background.
## Run the Power Agent Node Container with the 'dev' Tag
Run the Power Agent Node with the 'dev' tag for development and testing. This version includes the latest updates not in the stable release.
```sh
docker compose pull
NODE_ENV=dev docker compose --profile dev up -d
```