iKahuERC20Abi =[
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"name": "burn",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_totalTokensBurnt",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "disableMint",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_mintDisabled",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "enableBurn",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_burnEnabled",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getConfiguration",
		"outputs": [
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
			},
			{
				"internalType": "uint256",
				"name": "_mintDate",
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
				"name": "_tokensIssued",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_tokensBurnt",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_totalHolders",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_totalSupplyCap",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"name": "mint",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_totalTokensIssued",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_ownershipRenounced",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			}
		],
		"name": "setSaleContractAddress",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_set",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]