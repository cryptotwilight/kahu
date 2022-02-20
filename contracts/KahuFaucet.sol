// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.7.0 <0.9.0;

import "./IKahuFaucet.sol";
import "./KahuERC20.sol";

contract KahuFaucet is IKahuFaucet { 

    uint256 issuedContractCount; 
    uint256 burnEnabledContractCount; 
    uint256 ownershipRenouncedContractCount; 
    uint256 totalCappedSupplyIssued; 

    address [] kERC20List; 

    string [] tokenNames; 
    mapping(string=>kERC20MintData) mintDataByTokenName; 
    mapping(address=>kERC20MintData[]) mintDataByCreatorAddress; 

    uint256 pageIndex = 1;
    uint256 pageSize = 20;  
    mapping(uint256=>kERC20MintData[]) mintDataByPage; 

    address payable faucetAdmin; 
    address self; 
    uint256 standardMintPrice; 

    struct kERC20MintData{
                uint256 mintFee;
                string icon;
                string name; 
                string symbol; 
                uint8 decimals;                
                bool burnEnabled;  
                bool ownershipRenounced; 
                bool totalSupplyCapEnabled;  
                uint256 totalSupplyCap;                                
                address saleContractAddress; 
                address creatorAddress;
                address kerc20Address; 
                uint256 mintDate; 
    }

    constructor(address payable _faucetAdmin) {
        faucetAdmin = _faucetAdmin;
        self = address(this);  
    }

    function getMintPrice() override view external returns (uint256 _mintPrice){
        return standardMintPrice; 
    }

    function getLatestPageIndex() override view external returns( uint256 _pageIndex){
        return pageIndex; 
    }

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
                address _creatorAddress ) override payable external returns (address _erc20Address){
                
                require(msg.value == _mintFee, "KAHU FAUCET :: INSUFFICIENT MINT FEE TRANSMITTED ");
                require(_mintFee >= standardMintPrice, "KAHU FAUCET :: INSUFFICIENT MINT FEE ");
                KahuERC20 erc20_ = new KahuERC20(_icon, _name, _symbol, _decimals, _totalSupplyCap, _burnEnabled, _ownershipRenounced, _saleContractAddress, _creatorAddress);
                _erc20Address = address(erc20_);
                kERC20List.push(_erc20Address);
                tokenNames.push(_name);
                kERC20MintData memory mintData_ = kERC20MintData({
                           mintFee : _mintFee,
                           icon : _icon,
                           name : _name,  
                           symbol : _symbol,  
                           decimals : _decimals, 
                           totalSupplyCap : _totalSupplyCap,  
                           burnEnabled : _burnEnabled,   
                           ownershipRenounced : _ownershipRenounced,  
                           totalSupplyCapEnabled : _totalSupplyCapEnabled,                                 
                           saleContractAddress : _saleContractAddress, 
                           creatorAddress : _creatorAddress, 
                           kerc20Address :  _erc20Address, 
                           mintDate : block.timestamp 
                });
                 mintDataByTokenName[_name] = mintData_; 
                 mintDataByCreatorAddress[_creatorAddress].push(mintData_); 
                 if(mintDataByPage[pageIndex].length >= pageSize){
                     pageIndex++; 
                     mintDataByPage[pageIndex].push(mintData_);
                 }
                 else {
                     mintDataByPage[pageIndex].push(mintData_);
                 }
                if(_ownershipRenounced){
                    ownershipRenouncedContractCount++;
                }
                if(_burnEnabled) {
                    burnEnabledContractCount++;
                }
                issuedContractCount++;
                totalCappedSupplyIssued += _totalSupplyCap;

                 return _erc20Address; 
    }

    function getStats() override view external returns (uint256 _issuedContractCount, 
                                                        uint256 _burnEnabledContractCount, 
                                                        uint256 _ownershipRenouncedContractCount, 
                                                        uint256 _totalCappedSupplyIssued){
         return (issuedContractCount, burnEnabledContractCount, ownershipRenouncedContractCount, totalCappedSupplyIssued);
    }
                                                        
    function findToken(string memory _tokenName) override view external returns (address [] memory _erc20Tokens){
        _erc20Tokens = new address[](0);
        for(uint256 x =0; x < tokenNames.length; x++ ){
            string memory tokenName_ = tokenNames[x];
            if(contains(_tokenName, tokenName_)){
                _erc20Tokens = append(mintDataByTokenName[_tokenName].kerc20Address, _erc20Tokens);
            }
        }
        return _erc20Tokens; 
    }

    function getUserMintedTokens() override view external returns (address [] memory _mintedTokens){
        kERC20MintData [] memory mintData = mintDataByCreatorAddress[msg.sender];
        _mintedTokens = new address[](mintData.length);
        for(uint256 x = 0; x < _mintedTokens.length; x++){
            _mintedTokens[x] = mintData[x].kerc20Address;
        }
        return _mintedTokens; 
    }

    function getLatestTokens(uint256 _page) override view external returns (string [] memory _tokenIcon,
                                                                            string [] memory _tokenName, 
                                                                            string [] memory _tokenSymbol,                                                                           
                                                                            address [] memory _tokenAddress, 
                                                                            uint256 _availablePages){
        kERC20MintData [] memory mintData_ = mintDataByPage[_page]; 
        uint256 size_ = mintData_.length; 
        _tokenIcon = new string[](size_);
        _tokenName = new string[](size_); 
        _tokenSymbol = new string[](size_);        
        _tokenAddress = new address[](size_);
        for(uint256 x = 0; x < mintData_.length; x++){
            kERC20MintData memory mintData = mintData_[x];
            _tokenIcon[x] =  mintData.icon;
            _tokenName[x]  =  mintData.name; 
            _tokenSymbol[x]  = mintData.symbol;  
            _tokenAddress[x]  = mintData.kerc20Address;
            
        }
        return (_tokenIcon, _tokenName,  _tokenSymbol, _tokenAddress,pageIndex);
    }



    function setStandardMintPrice(uint256 _mintPrice) external returns (bool _set){
        require(msg.sender == faucetAdmin, "KAHU FAUCET :: FAUCET ADMIN ONLY");
        standardMintPrice = _mintPrice; 
        return true; 
    }

    function withdrawTakings() external returns(uint256 _takingsReturned){
        _takingsReturned = self.balance; 
        faucetAdmin.transfer(_takingsReturned);
        return _takingsReturned; 
    }

    /////============================= INTERNAL ==========================

    function append(address _a, address [] memory _b) pure internal returns (address [] memory _c){        
        _c = new address[](_b.length+1);
        for(uint256 x = 0; x < _c.length; x++){
            if(x < _b.length){
                _c[x] = _b[x];
            }
            else { 
                _c[x] = _a; 
            }
        } 
        return _c; 
    }

    function append(string memory _a, string [] memory _b) pure internal returns (string [] memory _c){        
        _c = new string[](_b.length+1);
        for(uint256 x = 0; x < _c.length; x++){
            if(x < _b.length){
                _c[x] = _b[x];
            }
            else { 
                _c[x] = _a; 
            }
        } 
        return _c; 
    }

    function contains (string memory what, string memory where) pure internal returns (bool _found) {
        bytes memory whatBytes = bytes (what);
        bytes memory whereBytes = bytes (where);

        require(whereBytes.length >= whatBytes.length);

        _found = false;
        for (uint i = 0; i <= whereBytes.length - whatBytes.length; i++) {
            bool flag = true;
            for (uint j = 0; j < whatBytes.length; j++)
                if (whereBytes [i + j] != whatBytes [j]) {
                    flag = false;
                    break;
                }
            if (flag) {
                _found = true;
                break;
            }
        }
        return (_found);
    }

}