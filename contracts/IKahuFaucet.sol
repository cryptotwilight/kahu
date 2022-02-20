// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.7.0 <0.9.0;

interface IKahuFaucet { 

    function getMintPrice() view external returns (uint256 _mintPrice);

    function getLatestPageIndex() view external returns(uint256 _pageIndex);

    function mint(uint256 _mintFee,
                    string memory _icon, 
                    string memory _name, 
                    string memory _symbol, 
                    uint8 _decimals, 
                    bool _burnEnabled,  
                    bool _ownershipRenounced,
                    bool _totalSupplyCapEnabled, 
                    uint256 _totalSupplyCap,                                 
                    address _saleContractAddress, 
                    address _creatorAddress ) payable external returns (address _erc20Addresss);

    function getStats() view external returns (uint256 _issuedContractCount, 
                                                uint256 _burnEnabledContractCount, 
                                                uint256 _ownershipRenouncedContractCount, 
                                                uint256 _totalCappedSupplyIssued);
                                                        
    function findToken(string memory _tokenName) view external returns (address [] memory _erc20Tokens);

    function getUserMintedTokens() view external returns (address [] memory _mintedTokens);

    function getLatestTokens(uint256 _page) view external returns ( string [] memory _tokenIcon, 
                                                                    string [] memory _tokenName, 
                                                                    string [] memory _tokenSymbol, 
                                                                    address [] memory _tokenAddress, 
                                                                    uint256 _availablePages);

}