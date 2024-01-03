//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeployHelpers.s.sol";
import {BasicNft} from "../contracts/BasicNft.sol";
import {BuidlGuidlNft} from "../contracts/BuidlGuidlNft.sol";

contract DeployScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external returns (BasicNft) {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        BasicNft basicNft = new BasicNft();
        console.logString(
            string.concat(
                "basicNft deployed at: ",
                vm.toString(address(basicNft))
            )
        );

        BuidlGuidlNft bgNft = new BuidlGuidlNft();
        console.logString(
            string.concat(
                "bgNft contract deployed at: ",
                vm.toString(address(bgNft))
            )
        );
        vm.stopBroadcast();

        /**
         * This function generates the file containing the contracts Abi definitions.
         * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
         * This function should be called last.
         */
        exportDeployments();

        return basicNft;
    }

    function test() public {}
}

// contract DeployBuidlGuidlNft is ScaffoldETHDeploy {
//     error InvalidPrivateKey(string);

//     function run() external returns (BuidlGuidlNft) {
//         uint256 deployerPrivateKey = setupLocalhostEnv();
//         if (deployerPrivateKey == 0) {
//             revert InvalidPrivateKey(
//                 "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
//             );
//         }
//         vm.startBroadcast(deployerPrivateKey);
//         BuidlGuidlNft bgNft = new BuidlGuidlNft();

//         console.logString(
//             string.concat(
//                 "bgNft contract deployed at: ",
//                 vm.toString(address(bgNft))
//             )
//         );
//         vm.stopBroadcast();

//         /**
//          * This function generates the file containing the contracts Abi definitions.
//          * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
//          * This function should be called last.
//          */
//         exportDeployments();

//         return bgNft;
//     }

//     function test() public {}
// }
