// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.7.0 <0.9.0;


interface IKahuERC20 { 

    function getConfiguration() view external returns (string memory _icon, 
                                                       string memory _name, 
                                                       string memory _symbol, 
                                                       uint8 _decimals,                                                                      
                                                       bool _burnEnabled,  
                                                       bool _ownershipRenounced, 
                                                       bool _totalSupplyCapEnabled,
                                                       uint256 _totalSupplyCap,                                 
                                                       address _saleContractAddress, 
                                                       address _creatorAddress,
                                                       uint256 _mintDate);
    function getStats() external returns(uint256 _tokensIssued, uint256 _tokensBurnt, uint256 _totalHolders, uint256 _totalSupplyCap);

    function mint(address _to, uint256 _amount) external returns (uint256 _totalTokensIssued);

    function burn(uint256 _amount) external returns(uint256 _totalTokensBurnt);

    function renounceOwnership() external returns (bool _ownershipRenounced);

    function disableMint() external returns (bool _mintDisabled);

    function enableBurn() external returns (bool _burnEnabled);

    function setSaleContractAddress(address _address) external returns (bool _set);
}
