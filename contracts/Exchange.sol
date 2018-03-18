pragma solidity ^0.4.19;

import "./owned.sol";
import "./FixedSupplyToken.sol";

contract Exchange is owned{

      struct Offer {
          //our offers have a volume and a person who is actually sending the token so an address
          uint amount;
          address who;

      }

      // he keeps saying order book is a linked list
      struct OrderBook {
          //so our orders books are actually pointing to another order book
          uint higherPrice;
          uint lowerPrice;

          mapping (uint => Offer) offers;

          // our offers is stack which is very easy in solidity
          uint offers_key;
          uint offers_length;
      }

      struct Token {
          address tokenContract;
          string symbolName;

          mapping(uint => OrderBook) buyBook;
          uint curBuyPrice;
          uint lowestBuyPrice;
          uint amountBuyPrice;

          mapping(uint => OrderBook) sellBook;
          uint curSellPrice;
          uint highestSellPrice;
          uint amountSellPrices;

      }

      //we support 255 tokens
      mapping(uint8 => Token) tokens;
      uint8 symbolNameIndex;

      //////BALANCES///////

      mapping(address => mapping(uint8 => uint)) tokenBalanceForAddress;

      mapping(address => uint) balanceEthForAddress;



      //////EVENTS///////



      //////DEPOSIT AND WITHDRAWAL OF ETHER///////



      //////TOKEN MANAGEMENT///////
      // temp removing onlyOwner
      function addToken(string symbolName, address erc20TokenAddress)  {
          /// try it yourself exercise
          // And what you have to do is to increment the index of the tokens.
          // And then, for the new "index" you add the new symbol-name.

          // you missed this, first need to check if the token symbol is already in our system
          require(!hasToken(symbolName));
          symbolNameIndex++; // you got this correct
          //wrong you can't use push because it's not a dynamic array, it's static
          // Token.push()
          // this instead is the proper way to do it, I guess
          // ok makes a little sense, you added onto the symbol index and the one you just added and can access
          // would just be symbolNameIndex
          tokens[symbolNameIndex].symbolName = symbolName;
          tokens[symbolNameIndex].tokenContract = erc20TokenAddress;
      }

      function hasToken(string symbolName) constant returns (bool) {
          // just need to check if it returns index of 0 or literally anything else
          uint8 index = getSymbolIndex(symbolName);
          if (index == 0) {
              return false;
          }
          return true;


      }

      function getSymbolIndex(string symbolName) internal returns (uint8) {
          for (uint8 i = 1; i <= symbolNameIndex; i++) {
              if (stringsEqual(tokens[i].symbolName, symbolName)) {
                  return i;
              }
          }
          return 0;
      }


      //////STRING COMPARISON FUNCTION//////
          // he didn't write this. many people on internet did. the problem is how do we compare the strings from memory and the strings from storage
      function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
          // in this case we have to cast them to a byte. sigh...
          bytes storage a = bytes(_a);
          bytes memory b = bytes(_b);
          if (a.length != b.length)
              return false;
          // TODO: unroll this loop
          for (uint i = 0; i < a.length; i++)
              if (a[i] != b[i])
                  return false;
          return true;
      }



      //////DEPOSIT AND WITHDRAWAL TOKEN///////



}
