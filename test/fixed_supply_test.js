var fixedSupplyToken = artifacts.require("./FixedSupplyToken.sol");

contract('MyToken', function(accounts) {
  it("first account should own all the tokens", function() {
    var _totalSupply;
    var myTokenInstance;
    return fixedSupplyToken.deployed().then(function(instance) {
      myTokenInstance = instance;
      return myTokenInstance.totalSupply.call();
    }).then(function(totalSupply) {
      _totalSupply = totalSupply;
      return myTokenInstance.balanceOf(accounts[0]);
    }).then(function(balanceAccountOwner) {
      assert.equal(balanceAccountOwner.toNumber(), _totalSupply.toNumber(), "total amount of tokens is owned by first account");
    });
  });
});
