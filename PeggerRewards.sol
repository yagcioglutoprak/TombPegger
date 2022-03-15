pragma solidity >=0.5.0;

import './Ownable.sol';


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



contract PeggerRewards is Ownable{
    address peggerContract;
    address wftm;
    uint256 feeRate;
    uint256 totalFee;
    constructor (uint256 _feeRate,address _wftm){
        wftm = _wftm;
        feeRate = _feeRate;

    }

    struct User {
        uint256 rewardAmount;
    }

    mapping(address=>User) public users;

    function depositRewards(address user,uint256 amount) external{
        IERC20(wftm).transferFrom(msg.sender,address(this),amount);
        uint256 fee = calculateFee(amount);
        sendFee(fee);
        users[user].rewardAmount += amount-fee;
    }

     function withdrawRewards (uint256 amount) external{
         if(users[msg.sender].rewardAmount>=amount){
             users[msg.sender].rewardAmount -= amount;
             IERC20(wftm).transfer(msg.sender,amount);
         }
    }
    function withdrawAll() external{
          require(IERC20(wftm).transfer(msg.sender,users[msg.sender].rewardAmount),"error in rewardAmount");
          users[msg.sender].rewardAmount = 0;
    }

    function emergencyWithdraw (uint256 amount) public onlyOwner{
        IERC20(wftm).transfer(msg.sender,amount);
    }

    function sendFee(uint256 amount) internal  {
        totalFee += amount;
    }
    function withdrawFee() public onlyOwner  {
        IERC20(wftm).transfer(msg.sender,totalFee);
    }

    function calculateFee(uint256 amount) internal returns(uint256 _amount) {
        uint256 fee = amount*feeRate/100;
        return fee;
    }

    function setPeggerContract(address _contract) public onlyOwner {
        peggerContract = _contract;
    }

    




}