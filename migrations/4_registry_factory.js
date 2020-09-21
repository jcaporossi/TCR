/* global artifacts */

const RegistryFactory = artifacts.require('./RegistryFactory.sol');
const DLL = artifacts.require('../PLCRVoting/contracts/DLL');
const AttributeStore = artifacts.require('../PLCRVoting/contracts/AttributeStore');
const ParameterizerFactory = artifacts.require('./ParameterizerFactory.sol');

module.exports = (deployer) => {
  // link libraries
  deployer.link(DLL, RegistryFactory);
  deployer.link(AttributeStore, RegistryFactory);

  return deployer.deploy(RegistryFactory, ParameterizerFactory.address);
};
