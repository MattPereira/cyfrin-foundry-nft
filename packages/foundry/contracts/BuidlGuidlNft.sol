// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

/**
 * Basic setup for dynamic svg nft project
 * Values are hardcoded since this doesn't use chainlink functions
 */
contract BuidlGuidlNft is ERC721 {
    uint256 private s_tokenCounter;
    string private constant base64EncodedSvgPrefix =
        "data:image/svg+xml;base64,";

    mapping(uint256 => address) public tokenIdToMemberAddress;
    mapping(address => string) public memberToEnsName;
    mapping(address => string) public memberToBuildCount;

    constructor() ERC721("BuidlGuidl NFT", "BG") {
        s_tokenCounter = 0;

        // Temporary simulation of chainlink function
        memberToEnsName[msg.sender] = "matthu.eth";
        memberToBuildCount[msg.sender] = "5";
    }

    function getSvgHeader() public pure returns (string memory) {}

    function svgToImageURI(
        address memberAddr
    ) public view returns (string memory) {
        string memory ensName = memberToEnsName[memberAddr];
        string memory buildCount = memberToBuildCount[memberAddr];
        string memory svgBase64Encoded = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '<svg width="216" height="180" viewBox="0 0 216 180" xmlns="http://www.w3.org/2000/svg">',
                        '<rect width="216" height="180" fill="white"/>',
                        '<g transform="translate(15, 15)">',
                        '<path fill-rule="evenodd" clip-rule="evenodd" d="M14.8867 10.1643V19.4598H17.2209V24.8329H22.9973V19.4598H27.0062V30.206L20.7013 42.0233L13.5031 41.9146L6.30486 42.0233L0 30.206V19.4598H3.99065V24.8329H9.78528V19.4598H12.3588V1.26395C12.3588 0.565889 12.9247 0 13.6228 0C14.1263 0 14.561 0.2944 14.7642 0.72045C15.4031 0.965338 16.0466 1.61238 16.7119 2.28137C17.5022 3.07602 18.3232 3.90163 19.2039 4.12095C20.0931 4.34242 20.7524 4.10563 21.4951 3.83887C22.2743 3.559 23.1453 3.24616 24.4701 3.39486C25.4635 3.51174 25.9901 4.16046 26.5791 4.88586C27.3621 5.85033 28.2552 6.95035 30.5016 7.11611L30.4874 7.12612C29.0491 8.14179 27.084 9.5295 24.0327 9.2581C23.0785 9.17577 22.4062 8.86812 21.7616 8.57316C20.8429 8.15279 19.9805 7.75817 18.4385 8.07819C16.7695 8.41302 15.9262 9.20317 15.2849 9.80403C15.1447 9.9354 15.0141 10.0577 14.8867 10.1643Z" fill="#283549"/>',
                        "</g>",
                        '<text x="50" y="55" font-family="Verdana" font-size="30" fill="#283549">BuidlGuidl</text>',
                        '<rect x="0" y="75" width="216" height="30" fill="#283549"/>',
                        '<text x="108" y="97" font-family="Verdana" font-size="18" fill="white" text-anchor="middle">',
                        ensName,
                        "</text>",
                        '<text x="20" y="152" font-family="Verdana" font-size="18"  fill="#283549">Builds Shipped</text>',
                        '<circle cx="180" cy="145" r="15" fill="#283549"/>',
                        '<text  x="180" y="152" font-family="Verdana" font-size="18" fill="white" text-anchor="middle">',
                        buildCount,
                        "</text>",
                        "</svg>"
                    )
                )
            )
        );
        return
            string(abi.encodePacked(base64EncodedSvgPrefix, svgBase64Encoded));
    }

    /** MINTING NEW NFT
     * 1. send chainlink function request to get member data
     * 2. update state variable mappings with member data
     * 3. mint new NFT
     *
     */
    function minNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        tokenIdToMemberAddress[s_tokenCounter] = msg.sender;
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        require(tokenId < s_tokenCounter, "Token id does not exist.");
        address memberAddress = tokenIdToMemberAddress[tokenId];
        string memory imageURI = svgToImageURI(memberAddress);

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "Dynamic SVG NFT for Buidl Guidl members only", "attributes": [{"trait_type": "coolness", "value": "100"}], "image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}