const PostQuantumPermissioning = artifacts.require('PostQuantumPermissioning');
const RelayHub = artifacts.require('RelayHub');
const Ingress = artifacts.require('Ingress');

const RULES_CONTRACT_NAME = '0x72756c6573000000000000000000000000000000000000000000000000000000'; // "rules"

module.exports = function (deployer, network, accounts) {
  return deployer.deploy(RelayHub)
    .then((deployedRelayHub) => deployer.deploy(PostQuantumPermissioning, deployedRelayHub.address)
      .then((deployedPostQuantumPermissioning) => Ingress.at('0x0000000000000000000000000000000000008888')
        .then((deployedIngress) => deployedIngress.setContractAddress(RULES_CONTRACT_NAME, deployedPostQuantumPermissioning.address, {from: accounts[0]}))
      )
    );
};