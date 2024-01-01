// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/Deploy.s.sol";
import {BasicNft} from "../contracts/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant FOX =
        "ipfs://bafybeiexgaqxnqxocgwlfryh2mxdqr2imxsfctsjljljyosmekw3w3scne";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    /**
     * Can't compare strings in solidity, can only compare primitive types
     * i.e. uint256, bool, address, bytes32, etc.
     * 1. convert string to bytes
     * 2. hash bytes to bytes32
     * 3. compare hashes
     */

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // assert(expectedName == actualName); // can't do this
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    /**
     * Compare abi encoded strings to see if match
     */
    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(FOX);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(FOX)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
