/* global artifacts */

const RegistryFactory = artifacts.require('./RegistryFactory');
const DLL = artifacts.require('../../PLCRVoting/contracts/DLL');
const AttributeStore = artifacts.require('../../PLCRVoting/contracts/AttributeStore');
const ParameterizerFactory = artifacts.require('./ParameterizerFactory');

module.exports = (deployer) => {
  // link libraries
  deployer.link(DLL, RegistryFactory);
  deployer.link(AttributeStore, RegistryFactory);

  return deployer.deploy(RegistryFactory, ParameterizerFactory.address);
};
