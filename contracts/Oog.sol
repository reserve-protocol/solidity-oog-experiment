// SPDX-License-Identifier: BlueOak-1.0.0
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Callee {
    uint[] private store;
    // Run out of gas.
    function loop() public {
        uint i = 0;
        while (true) {
            store.push(i);
            i++;
        }
    }

    function panic(uint i) public returns (uint) {
        return 100 / i;
    }

    function justRevert() public {
        revert();
    }
}

contract Caller {
    function messAround() public {
        console.log("(before try/catch)");

        Callee callee = new Callee();

        try callee.loop() {
            console.log("Call successfully completed. (?!)");
        } catch Error(string memory s) {
            console.log("Caught Error(", s, ")");
        } catch Panic(uint code) {
            console.log("Caught Panic(", code, ")");
        } catch (bytes memory data) {
            console.log("Caught unspecialized error:");
            console.log("  string(data):", string(data));
            console.log("  data.length:", data.length);
        }

        console.log("(after try/catch)");
    }
}
