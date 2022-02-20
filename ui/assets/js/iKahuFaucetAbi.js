iKahuFaucetAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_tokenName",
				"type": "string"
			}
		],
		"name": "findToken",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_erc20Tokens",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLatestPageIndex",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_pageIndex",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_page",
				"type": "uint256"
			}
		],
		"name": "getLatestTokens",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "_tokenIcon",
				"type": "string[]"
			},
			{
				"internalType": "string[]",
				"name": "_tokenName",
				"type": "string[]"
			},
			{
				"internalType": "string[]",
				"name": "_tokenSymbol",
				"type": "string[]"
			},
			{
				"internalType": "address[]",
				"name": "_tokenAddress",
				"type": "address[]"
			},
			{
				"internalType": "uint256",
				"name": "_availablePages",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMintPrice",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_mintPrice",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getStats",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_issuedContractCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_burnEnabledContractCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_ownershipRenouncedContractCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_totalCappedSupplyIssued",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getUserMintedTokens",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_mintedTokens",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_mintFee",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_icon",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_symbol",
				"type": "string"
			},
			{
				"internalType": "uint8",
				"name": "_decimals",
				"type": "uint8"
			},
			{
				"internalType": "bool",
				"name": "_burnEnabled",
				"type": "bool"
			},
			{
				"internalType": "bool",
				"name": "_ownershipRenounced",
				"type": "bool"
			},
			{
				"internalType": "bool",
				"name": "_totalSupplyCapEnabled",
				"type": "bool"
			},
			{
				"internalType": "uint256",
				"name": "_totalSupplyCap",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_saleContractAddress",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "_creatorAddress",
				"type": "address"
			}
		],
		"name": "mint",
		"outputs": [
			{
				"internalType": "address",
				"name": "_erc20Addresss",
				"type": "address"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	}
]