# Instruction: Setup for the PowerPool Agent V2 Keeper.

## Requirements

* CVP (PowerPool native token) for a deposit. Each Agent contract has its own `min keeper deposit` value.
* An RPC node with WebSockets enabled. Note that at the current stage of development, the bot is tested only with standalone nodes and doesn't support RPC endpoints from cloud providers like QuickNode, Alchemy, Infura, etc., due to requests per second limits.
* A server, available 24/7. Minimal requirements are 1CPU/512MB RAM/1G HDD. This bot script works fine at a DigitalOcean 1CPU/1GB/25SSD instance, which costs only $6 at the time of writing.


## Getting Started

### Signing up as a keeper

To be a keeper, you need at least two keys. (1) One admin key for management and (2) another one for a worker. The management key function is to assign a worker's address and withdraw compensations or initial deposit. The worker key is needed for transaction signing by a bot. If you use flashbots executor, you also need a flashbot key.

To sign as a Keeper you need to perform the following actions:

* Approve at least  minKeeperCvp  amount of CVP token from your keeper admin account to the agent's address. You can find the `minKeeperCvp` value by calling `agent.getConfig()` view method.
* Execute `agent.registerAsKeeper(address worker_, uint256 initialDepositAmount_)` from your keeper admin account. After execution you will receive a keeperID (uint256). KeeperID is used to get your keeper info with `agent.getKeeper(youKeeperId)` and isn't used for further configuration steps .

### Setting up a bot
* Install docker if it isn't installed yet. For ex. for Ubuntu you can find the instructions here https://docs.docker.com/engine/install/ubuntu/.

* Clone and cd into a repo with Docker Compose file:

```sh
git clone https://github.com/polipaul/powerpool-agent-v2-compose
cd powerpool-agent-v2-compose
```

* Put a json file containing your worker key into `./keys` folder. The file name doesn't matter, and you can choose it freely. If you don't have a json key file yet, you can use the json key generator from the compose repository. The generator is written in JavaScript, so you need to have node.js installed to use it. Don't forget to install npm dependencies using `npm i'. Use the following syntax to convert your raw private key to json V3 format:
  ```sh
  # node jsongen.js <your-private-key> <your-pass>
  node jsongen.js 0x0c38f1fb1b2d49ea6c6d255a6e50edf0a7a7fa217639281fe1b24a96efc16995 myPass
  ```
* Cd into `config` folder and copy the main config template:

```sh
cd config && cp main.template.yaml main.yaml
```

* You can configure as many networks and agents as you need. The official PPAgentV2 list will be published later.
* Put you WebSockets RPC node URI to `networks->details->{network_name}->rpc`. The example config could contain some RPC nodes, either public ones or maintained by PowerPool, but we don't give any guarantee they will work properly with excellent uptime.
* For each agent:
    * Choose either `pga` or `flashbots` executor. At the moment `flashbots` executor is supported only for `goerli` and `mainnet` networks.
    * Put your keeper worker address into `keeper_address`
    * Put your keeper worker json key pass into `key_pass`
    * If you want to accrue rewards on your balance at the PPAgentV2 contract (this could save small amount of gas), set `accrue_reward` to `true`. If set to `false` the compensation will be sent to the worker's address each time after job execution. The default value is `false`.
    * Some jobs could have a limit for the current network `base_fee`. It could happen if a job owner is not ready to provide compensation when the gas price exceeds the initial limit. For ex. the current network `base_fee` is 15 and the job's `maxBaseFee` is 10. If you send a tx for the job execution with an `accept_max_base_fee_limit` set to false and a gas value of 16, it will revert. But if you set `accept_max_base_fee_limit` to true, the tx won't revert, but your compensation will be calculated using `min(jobMaxBaseFee, neworkFee) = min(10,15) = 10`.
* Cd back to the bot folder and run a docker container:
```sh
cd ..
```

```sh
docker compose up -d
```
