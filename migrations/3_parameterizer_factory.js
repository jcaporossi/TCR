/* global artifacts */

const ParameterizerFactory = artifacts.require('./ParameterizerFactory');
const DLL = artifacts.require('../PLCRVoting/contracts/DLL');
const AttributeStore = artifacts.require('../PLCRVoting/contracts/AttributeStore');
const PLCRFactory = artifacts.require('../PLCRVoting/contracts/PLCRFactory.sol');

module.exports = (deployer, network) => {
  // link libraries
  deployer.link(DLL, ParameterizerFactory);
  deployer.link(AttributeStore, ParameterizerFactory);

  if (network === 'mainnet') {
    return deployer.deploy(ParameterizerFactory, '0xdf9c10e2e9bb8968b908261d38860b1a038cc2ef');
  }

  return deployer.deploy(ParameterizerFactory, PLCRFactory.address);
};
