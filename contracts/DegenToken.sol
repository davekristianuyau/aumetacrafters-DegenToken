// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

        event TokensRedeemed(address indexed from, uint256 amount);      

        // Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }


        function decimals() override public pure returns (uint8){
            return 0;
        }

        // Checking token balance: Players should be able to check their token balance at any time.
        function getBalance() external view returns (uint256){
            return balanceOf(msg.sender);
        }

        // Transferring tokens: Players should be able to transfer their tokens to others.
        function transferTokens(address _receiver, uint256 _value) external {
            require (balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
            approve(msg.sender, _value);
            transferFrom(msg.sender, _receiver, _value);
        }

        // Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
        function burnTokens (uint256 _value) external {
            require (balanceOf(msg.sender) >= _value, "You do not have enough Degen Token");
            burn(_value);
        }

        // Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
        function redeemTokens (uint256 _value) public returns (bool) {
            require (balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
            _burn(msg.sender, _value);

            // Additional logic for redeeming a t-shirt can be added here, such as updating a user's inventory or triggering an external process.

            // Add an event or return a string to indicate successful redemption.
            emit TokensRedeemed(msg.sender, _value);
            return true;
        }
}
