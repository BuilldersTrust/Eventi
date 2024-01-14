# ARC20: Tokens on Areon

- [ARC-20: Tokens on Areon Network](#arc20)
  - [1. Summary](#1--summary)
  - [2. Abstract](#2--abstract)
  - [3. Motivation](#3--motivation)
  - [4. Status](#4--status)
  - [5. Specification](#5--specification)
    - [5.1 Token](#51-token)
      - [5.1.1 Methods](#511-methods)
        - [5.1.1.1 name](#5111-name)
        - [5.1.1.2 symbol](#5112-symbol)
        - [5.1.1.3 decimals](#5113-decimals)
        - [5.1.1.4 totalSupply](#5114-totalsupply)
        - [5.1.1.5 balanceOf](#5115-balanceof)
        - [5.1.1.6 getOwner](#5116-getowner)
        - [5.1.1.7 transfer](#5117-transfer)
        - [5.1.1.8 transferFrom](#5118-transferfrom)
        - [5.1.1.9 approve](#5119-approve)
        - [5.1.1.10 allowance](#51110-allowance)
      - [5.1.2 Events](#512-events)
        - [5.1.2.1 Transfer](#5121-transfer)
        - [5.1.2.2 Approval](#5122-approval)
    - [5.2 Implementation](#52-implementation)
    - [5.3 A sample ARC20 Contract](#53-A-sample-ARC20-Contract)
  - [6. License](#6-license)

## 1.  Summary
This ARC proposes an interface standard to create token contracts on Areon.

## 2.  Abstract
The following standard defines the implementation of APIs for token smart contracts. It is proposed by deriving the ERC20 protocol of Ethereum and provides the basic functionality to transfer tokens, allow tokens to be approved so they can be spent by another on-chain third party, and transfer between Areon.

## 3.  Motivation
A standard interface allows any tokens on Areon to be used by other applications: from wallets to decentralized exchanges in a consistent way. Besides, this standard interface also extends [ERC20](https://eips.ethereum.org/EIPS/eip-20) to facilitate cross chain transfer.

## 4.  Status
This ARC is already implemented.

## 5.  Specification

### 5.1 Token

**NOTES**:
- The following specifications use syntax from Solidity **0.5.16** (or above)
- Callers MUST handle false from returns (bool success). Callers MUST NOT assume that false is never returned!

####  5.1.1 Methods

##### 5.1.1.1 name
```
function name() public view returns (string)
```
- Returns the name of the token - e.g. "MyToken".
- **OPTIONAL** - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

##### 5.1.1.2 symbol
```
function symbol() public view returns (string)
```
- Returns the symbol of the token. E.g. “ARC”.
- This method can be used to improve usability
- **NOTE** - This method is optional in EIP20. In ARC20, this is a required method. Tokens which don’t implement this method will never flow across the Areon.

##### 5.1.1.3 decimals
```
function decimals() public view returns (uint8)
```
- Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation.
- This method can be used to improve usability
- **NOTE** - This method is optional in EIP20. In ARC20, this is a required method. Tokens which don’t implement this method will never flow across the Areon.

##### 5.1.1.4 totalSupply
```
function totalSupply() public view returns (uint256)
```
- Returns the total token supply. 

##### 5.1.1.5 balanceOf
```
function balanceOf(address _owner) public view returns (uint256 balance)
```
- Returns the account balance of another account with address `_owner`.

##### 5.1.1.6 getOwner
```
function getOwner() external view returns (address);
```
- Returns the ARC20 token owner which is necessary for binding with ARC20 token.
- **NOTE** - This is an extended method of EIP20. Tokens which don’t implement this method will never flow across the Areon.

##### 5.1.1.7 transfer
```
function transfer(address _to, uint256 _value) public returns (bool success)
```
- Transfers `_value` amount of tokens to address `_to`, and MUST fire the Transfer event. The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend.
- **NOTE** - Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.

##### 5.1.1.8 transferFrom
```
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
```
- Transfers `_value` amount of tokens from address `_from` to address `_to`, and MUST fire the Transfer event.
- The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf. This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies. The function SHOULD throw unless the `_from` account has deliberately authorized the sender of the message via some mechanism.
- **NOTE** - Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.

##### 5.1.1.9 approve
```
function approve(address _spender, uint256 _value) public returns (bool success)
```
- Allows `_spender` to withdraw from your account multiple times, up to the `_value` amount. If this function is called again it overwrites the current allowance with `_value`.
- **NOTE** - To prevent attack vectors like the one described here and discussed here, clients SHOULD make sure to create user interfaces in such a way that they set the allowance first to 0 before setting it to another value for the same spender. THOUGH The contract itself shouldn’t enforce it, to allow backwards compatibility with contracts deployed before

##### 5.1.1.10 allowance
```
function allowance(address _owner, address _spender) public view returns (uint256 remaining)
```
- Returns the amount which `_spender` is still allowed to withdraw from `_owner`.

#### 5.1.2 Events

##### 5.1.2.1 Transfer
```
event Transfer(address indexed _from, address indexed _to, uint256 _value)
```
- **MUST** trigger when tokens are transferred, including zero value transfers.
- A token contract which creates new tokens SHOULD trigger a Transfer event with the `_from` address set to 0x0 when tokens are created.

##### 5.1.2.2 Approval
```
event Approval(address indexed _owner, address indexed _spender, uint256 _value)
```
**MUST** trigger on any successful call to `approve(address _spender, uint256 _value)`.

### 5.2 Implementation

There are already plenty of ARC20-compliant tokens deployed on the Areon network. Different implementations have been written by various teams that have different trade-offs: from gas saving to improved security.

## 5.3 A sample ARC20 Contract
[ARC20.sol](ARC20.sol)

## 6. License
   
The content is licensed under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

