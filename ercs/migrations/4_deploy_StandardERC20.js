const StandardERC20 =artifacts.require("StandardERC20");

module.exports = function (deployer){
    deployer.deploy(StandardERC20);
};