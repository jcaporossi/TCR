/* global artifacts */

const PLCRFactory = artifacts.require('./PLCRVoting/contracts/PLCRFactory');
const DLL = artifacts.require('../PLCRVoting/contracts/DLL');
const AttributeStore = artifacts.require('./PLCRVoting/contracts/AttributeStore');

module.exports = (deployer) => {
  // deploy libraries
  deployer.deploy(DLL);
  deployer.deploy(AttributeStore);

  // link libraries
  deployer.link(DLL, PLCRFactory);
  deployer.link(AttributeStore, PLCRFactory);

  /*if (network === 'mainnet') {
    return deployer;
  }*/

  deployer.deploy(PLCRFactory);
};