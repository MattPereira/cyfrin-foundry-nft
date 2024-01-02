// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../contracts/BasicNft.sol";
import "./DeployHelpers.s.sol";

/**
 * Use cyfrin/foundry-devops to get the most recently deployed BasicNft contract and mint an NFT on it.
 */
contract MintBasicNft is Script {
    string public constant FOX =
        "ipfs://bafybeiexgaqxnqxocgwlfryh2mxdqr2imxsfctsjljljyosmekw3w3scne";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );

        console.log("MOST RECENTLY DEPLOYED", mostRecentlyDeployed);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(FOX);
        vm.stopBroadcast();
    }
}
