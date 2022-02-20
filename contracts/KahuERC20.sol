// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/af7ec04b78c2b5dec330153de90682b13f17a1bb/contracts/token/ERC20/ERC20.sol";

import "./IKahuERC20.sol";

contract KahuERC20 is IKahuERC20, ERC20 { 

    string icon; 

    uint8 tokenDecimals;
    uint256 totalSupplyCap; 
    address saleContractAddress;
    address creatorAddress; 
    bool totalSupplyCapEnabled; 
    bool burnEnabled;
    bool ownershipRenounced; 
    bool mintDisabled; 
    uint256 mintDate; 

    uint256 totalTokensBurnt; 
    uint256 totalTokensIssued; 

    uint256 totalHolders;
	
	mapping(address=>bool) knownByAddress;



    constructor(string memory _icon, 
                string memory _name, 
                string memory _symbol, 
                uint8 _decimals, 
                uint256 _totalSupplyCap, 
                bool _burnEnabled,  
                bool _ownershipRenounced,                                 
                address _saleContractAddress, 
                address _creatorAddress) ERC20(_name, _symbol) {
        icon = _icon; 
        tokenDecimals = _decimals; 
        saleContractAddress = _saleContractAddress; 
        creatorAddress = _creatorAddress; 
        burnEnabled = _burnEnabled;
        ownershipRenounced = _ownershipRenounced; 
        if(_totalSupplyCap > 0)                        {
            totalSupplyCapEnabled = true;
            totalSupplyCap =_totalSupplyCap; 
        }
        mintDate = block.timestamp; 
    }

  function getConfiguration() override view external returns ( string memory _icon, 
                                                                string memory _name, 
                                                                string memory _symbol, 
                                                                uint8 _decimals,                                                                 
                                                                bool _burnEnabled,  
                                                                bool _ownershipRenounced, 
                                                                bool _totalSupplyCapEnabled,
                                                                uint256 _totalSupplyCap,                                
                                                                address _saleContractAddress, 
                                                                address _creatorAddress,
                                                                uint256 _mintDate){
        return (    icon, 
                    super.name(), 
                    super.symbol(), 
                    tokenDecimals,                         
                    burnEnabled, 
                    ownershipRenounced, 
                    totalSupplyCapEnabled, 
                    totalSupplyCap, 
                    saleContractAddress, 
                    creatorAddress, 
                    mintDate);                                                                                  
                                                                                        
    }

    function getStats() override external view returns (uint256 _totalTokensIssued, uint256 _totalTokensBurnt, uint256 _totalHolders, uint256 _totalSupplyCap){
        return (totalTokensIssued, totalTokensBurnt, totalHolders, totalSupplyCap);
    }

    function decimals() public view virtual override returns (uint8) {
        return tokenDecimals;
    }

    function mint(address _to, uint256 _amount) override external returns (uint256 _remainingSupply) {
        require(msg.sender == saleContractAddress, "KAHU ERC20 :: SALE CONTRACT ADDRESS ONLY");
        if(totalSupplyCapEnabled) {
            uint256 newCirculatingSupply = ERC20.totalSupply() + _amount;
            require(newCirculatingSupply <= totalSupplyCap, "KAHU ERC20 :: SUPPLY CAP EXCEEDED");
            totalTokensIssued += _amount;             
            _remainingSupply = totalSupplyCap - totalTokensIssued;
        }
        _mint(_to, _amount);        
        return _remainingSupply;
    }

    function burn(uint256 _amount) override external returns(uint256 _totalTokensBurnt) {
        require(burnEnabled, "KAHU ERC20 :: BURN NOT ENABLED");
        require(balanceOf(msg.sender) >= _amount, "KAHU ERC20 :: INSUFFICIENT FUNDS TO BURN"); 
        _burn(msg.sender, _amount);
        totalTokensBurnt += _amount; 
        return totalTokensBurnt;

    }

    function renounceOwnership() override external returns (bool _ownershipRenounced){
        require(!ownershipRenounced, "KAHU ERC20 :: OWNERSHIP RENOUNCED");
        require(msg.sender == creatorAddress, "KAHU ERC20 :: CONTRACT CREATOR ONLY");
        ownershipRenounced = true; 
        return ownershipRenounced;
    }

    function disableMint() override external returns (bool _mintDisabled){
        require(!ownershipRenounced, "KAHU ERC20 :: OWNERSHIP RENOUNCED");
        require(msg.sender == creatorAddress, "KAHU ERC20 :: CONTRACT CREATOR ONLY");
        mintDisabled = true; 
        return mintDisabled; 
    }

    function enableBurn() override external returns (bool _burnEnabled){
        require(!ownershipRenounced, "KAHU ERC20 :: OWNERSHIP RENOUNCED");
        require(msg.sender == creatorAddress, "KAHU ERC20 :: CONTRACT CREATOR ONLY");
        burnEnabled = true; 
        return burnEnabled; 
    }

    function setSaleContractAddress(address _address) override external returns (bool _set) {
        require(!ownershipRenounced, "KAHU ERC20 :: OWNERSHIP RENOUNCED");
        require(msg.sender == creatorAddress, "KAHU ERC20 :: CONTRACT CREATOR ONLY");
        saleContractAddress = _address; 
        return true; 
    }

    function _afterTokenTransfer(address from, address to, uint256 amount) override internal virtual {
		if(!knownByAddress[to]){
			totalHolders ++;
			knownByAddress[to] = true; 
		}
		
		if(balanceOf(from) == 0) { 
			totalHolders --;
			delete knownByAddress[from];
		}		
	}
}