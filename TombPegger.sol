pragma solidity >=0.5.0;
pragma experimental ABIEncoderV2;
import "./Ownable.sol";

 interface IUniswapV2Router01 {
   function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}
library SafeMath {
  
    function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x + y) >= x, "ds-math-add-overflow");
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x, "ds-math-sub-underflow");
    }

    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x, "ds-math-mul-overflow");
    }
}
library UniswapV2Library {
    using SafeMath for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(
        address factory,
        address tokenA,
        address tokenB
    ) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(
            uint256(
                keccak256(
                    abi.encodePacked(
                        hex"ff",
                        factory,
                        keccak256(abi.encodePacked(token0, token1)),
                        hex"0bbca9af0511ad1a1da383135cf3a8d2ac620e549ef9f6ae3a4c33c2fed0af91"
                    )
                )
            )
        );
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn > 0, 'UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(998);
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(1000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(1000);
        uint denominator = reserveOut.sub(amountOut).mul(998);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i = path.length - 1; i > 0; i--) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}


library TransferHelper {
    function safeApprove(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
    }

    function safeTransfer(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }

    function safeTransferFrom(address token, address from, address to, uint value) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
    }

    function safeTransferETH(address to, uint value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
}
interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

interface PeggerRewards {
    function depositRewards(address user,uint256 amount) external;
}
contract TombPegger is Ownable{
    uint256 minimumDeposit;
    uint256 profitRate;
    uint256 tombPrice;
    uint256 pegThreshold;
    address dexRouter;
    address dexFactory;
    address tombAdress;
    address wFTMAdress;
    address peggerRewardsContract;
    enum RoundStatus{bought,underpeg,initiated,completed,completedSell}
    struct Round{
      uint256 buyPrice;
      uint256 sellPrice;
      uint256 quantity;
      uint256 ftmValue;
      address user;
      RoundStatus status;
    }
    struct Holder{
        address user;
    }
    event Status(RoundStatus _status,uint256 ftmValue);
    struct User{
      Round[] rounds;
      uint256 depositedAmount;
    }
    
   Round[] public rounds;
   Holder[] public holders;
   mapping(address=>User) public users;
    constructor(address _peggerRewards,uint256 _minimumDeposit,uint256 _profitRate,uint256 _feeRate,uint256 _pegThreshold,address _dexRouter,address _dexFactory,address _tombAddress,address _wftm) public{
      dexRouter = _dexRouter;
      dexFactory = _dexFactory;
      tombAdress = _tombAddress;
      wFTMAdress = _wftm;
      profitRate = _profitRate;
      pegThreshold =_pegThreshold;
      minimumDeposit = _minimumDeposit;
      peggerRewardsContract = _peggerRewards;
      IERC20(wFTMAdress).approve(peggerRewardsContract,115792089237316195423570985008687907853269984665640564039457584007913129639935);
      IERC20(wFTMAdress).approve(dexRouter,115792089237316195423570985008687907853269984665640564039457584007913129639935);
      IERC20(tombAdress).approve(dexRouter,115792089237316195423570985008687907853269984665640564039457584007913129639935);
    }

    function depositFTM() public payable {
      require(msg.value>=minimumDeposit,'msg.value is below minimum deposit');
      if(getTombPrice()<pegThreshold){
         //TODO BUY TOMB IF THRESHOLD PRICE COME.
         uint256 balance = IERC20(wFTMAdress).balanceOf(address(this));
         uint256 __amount = msg.value;
         IWETH(wFTMAdress).deposit{value: __amount}();
         uint balancenew = IERC20(wFTMAdress).balanceOf(address(this));
         uint256 swapAmount = balancenew-balance;
         uint[] memory amountIn = makeSwap(swapAmount,1);
         users[msg.sender].depositedAmount += msg.value;
         users[msg.sender].rounds.push(Round( 
          getTombPrice(),
          0,
          amountIn[1],
          msg.value,
          msg.sender,
          RoundStatus.bought
      ));
      }
      else if (pegThreshold<getTombPrice()){
        //Waiting Peg for Buy.
        users[msg.sender].rounds.push(Round(
          0,
          0,
          0,
          msg.value,
          msg.sender,
          RoundStatus.underpeg
      ));
      }
      else{ 
        users[msg.sender].rounds.push(Round(
          0,
          0,
          0,
          msg.value,
          msg.sender,
          RoundStatus.underpeg
      ));
      }
      holders.push(Holder(
          msg.sender
      ));
      emit Status(users[msg.sender].rounds[users[msg.sender].rounds.length-1].status,users[msg.sender].rounds[users[msg.sender].rounds.length-1].ftmValue);

      

    }


   function getTombPrice() internal returns(uint256 _price){
    uint amount = 1;
    address pair =  IUniswapV2Factory(dexFactory).getPair(tombAdress,wFTMAdress);
    address token1 = IUniswapV2Pair(pair).token1();
    (uint priceA,uint priceB,) = IUniswapV2Pair(pair).getReserves();
    uint newPrice = priceA*(10**IERC20(token1).decimals());
    return((amount*newPrice)/priceB);
   }   
   function initiateWithdraw() public{
       for(uint i=0;i<users[msg.sender].rounds.length;i++){
           if(users[msg.sender].rounds[i].status!=RoundStatus.completed){
               users[msg.sender].rounds[i].status = RoundStatus.initiated;
           }
           
       }
   }

   function execute() public{
       uint currentTombPrice = getTombPrice();
       for(uint i=0;i<holders.length;i++){
           address user = holders[i].user;
           for(uint i=0;i<users[user].rounds.length;i++){
               if(users[user].rounds[i].status==RoundStatus.bought){
                  uint256 userboughtTombPrice = users[user].rounds[i].buyPrice;
                  uint256 userprofitrate = calculateProfitRate(userboughtTombPrice,currentTombPrice);
                  if(userprofitrate>=profitRate){
                       uint[] memory amountIn = makeSwap(users[user].rounds[i].quantity,0);
                       users[user].rounds[i].status = RoundStatus.completedSell;
                       users[user].rounds[i].sellPrice = currentTombPrice;
                       PeggerRewards(peggerRewardsContract).depositRewards(user,amountIn[1]-users[user].rounds[i].ftmValue);
                       if(getTombPrice()<pegThreshold){ 
         uint[] memory amountIn = makeSwap(users[user].rounds[i].ftmValue,1);
         users[user].rounds.push(Round( 
          getTombPrice(),
          0,
          amountIn[1],
          users[user].rounds[i].ftmValue,
          user,
          RoundStatus.bought
      ));
      }
      else if (pegThreshold<getTombPrice()){
        //Waiting Peg for Buy.
        users[user].rounds.push(Round(
          0,
          0,
          0,
          users[user].rounds[i].ftmValue,
          user,
          RoundStatus.underpeg
      ));
      }
      else{ 
        users[user].rounds.push(Round(
          0,
          0,
          0,
          users[user].rounds[i].ftmValue,
          user,
          RoundStatus.underpeg
      ));
      }
      _burn(user,i);
                       emit Status(users[user].rounds[i].status,users[user].rounds[i].quantity);
                  }
               }
               else if(users[user].rounds[i].status==RoundStatus.initiated){
                   if(users[user].rounds[i].buyPrice==0){
                       users[user].rounds[i].status = RoundStatus.completed;
                       IWETH(wFTMAdress).withdraw(users[user].rounds[i].ftmValue);
                       user.call{value:users[user].rounds[i].ftmValue}('');
                   }
                   else{
                        uint256 userboughtTombPrice = users[user].rounds[i].buyPrice;
                   uint256 userprofitrate = calculateProfitRate(userboughtTombPrice,currentTombPrice);
                   if(userprofitrate>=10050){   
                       uint[] memory amountIn = makeSwap(users[user].rounds[i].quantity,0);
                       users[user].rounds[i].status = RoundStatus.completed;
                       users[user].rounds[i].sellPrice = currentTombPrice;
                       PeggerRewards(peggerRewardsContract).depositRewards(user,amountIn[1]-users[user].rounds[i].ftmValue);
                       IWETH(wFTMAdress).withdraw(users[user].rounds[i].ftmValue);
                       user.call{value:users[user].rounds[i].ftmValue}('');
                       emit Status(users[user].rounds[i].status,users[user].rounds[i].quantity);
                   }
                   }

                   
               }
               else if(users[user].rounds[i].status==RoundStatus.underpeg){
                   if(currentTombPrice<pegThreshold){
                       uint[] memory amountIn = makeSwap(users[user].rounds[i].ftmValue,1);
                       users[user].rounds[i].quantity = amountIn[1];
                       users[user].rounds[i].buyPrice = currentTombPrice;
                       users[user].rounds[i].status = RoundStatus.bought;
                       emit Status(users[user].rounds[i].status,users[user].rounds[i].quantity);
                   }
               }
               else if (users[user].rounds[i].status==RoundStatus.completedSell){
                   if(getTombPrice()<pegThreshold){
         
         uint[] memory amountIn = makeSwap(users[user].rounds[i].ftmValue,1);
         users[user].rounds.push(Round( 
          getTombPrice(),
          0,
          amountIn[1],
          users[user].rounds[i].ftmValue,
          user,
          RoundStatus.bought
      ));
      }
      else if (pegThreshold<getTombPrice()){
        //Waiting Peg for Buy.
        users[user].rounds.push(Round(
          0,
          0,
          0,
          users[user].rounds[i].ftmValue,
          user,
          RoundStatus.underpeg
      ));
      }
      else{ 
        users[user].rounds.push(Round(
          0,
          0,
          0,
          users[user].rounds[i].ftmValue,
          user,
          RoundStatus.underpeg
      ));
      }
      _burn(user,i);
               }
           }
       }
   }

    function _burn(address addr,uint index) internal {
  require(index < users[addr].rounds.length);
  users[addr].rounds[index] = users[addr].rounds[users[addr].rounds.length-1];
  users[addr].rounds.pop();
}
   function calculateProfitRate(uint amountA,uint amountB) internal returns(uint256 _percentage){
       uint256 percentage = amountB*10000/amountA;
       return percentage;
   }

   

   function getRounds(address addr) public  view returns (  Round[] memory __rounds){
       return users[addr].rounds;
   }
   //_type;
   //0 = TOMB TO FTM
   //1 = FTM TO TOMB
   function makeSwap(uint256 _amount,uint _type) internal returns (uint[] memory amnts){
     uint[] memory amounts;
     
     if(_type==0){
       address[] memory path = new address[](2);
       path[0] = address(tombAdress);
       path[1] = wFTMAdress;
      amounts=IUniswapV2Router02(dexRouter).swapExactTokensForTokens(
        _amount,
        0,
        path,
        address(this),
        6641648059904
      );
     }
     else{
       address[] memory path = new address[](2);
       path[0] = address(wFTMAdress);
       path[1] = tombAdress;
       amounts =IUniswapV2Router02(dexRouter).swapExactTokensForTokens(
        _amount,
        0,
        path,
        address(this),
        6641648059904
      );
     }
     return amounts;
     //TODO Do Swap operations.
   }

   function emergencyWithdraw(uint256 amount,address _contract) public onlyOwner{
       IERC20(_contract).transfer(msg.sender,amount);
   }

   function changeExpectedProfitRate(uint256 rate) public onlyOwner{
       require(rate!=0,'invalid input');
       profitRate = rate;
   }

   function changeThreshold(uint256 threshold) public onlyOwner{
       require(threshold!=0,'invalid input');
       pegThreshold = threshold;
   }

   function changeMinDeposit(uint256 _deposit) public onlyOwner{
       _deposit = minimumDeposit;
   }
   receive() external payable {
      
    }


}