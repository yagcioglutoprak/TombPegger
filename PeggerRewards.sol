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
    address feeAddress;
    constructor (address _feeAddress,uint256 _feeRate,address _wftm){
        wftm = _wftm;
        feeRate = _feeRate;
        feeAddress = _feeAddress;
    }

    struct User {
        uint256 rewardAmount;
    }

    mapping(address=>User) public users;

    function depositRewards(address user,uint256 amount) external{
        require(msg.sender==peggerContract,'caller not peggerContract');
        IERC20(wftm).transferFrom(peggerContract,address(this),amount);
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

    function emergencyWithdraw (uint256 amount) public onlyOwner{
        IERC20(wftm).transfer(msg.sender,amount);
    }

    function sendFee(uint256 amount) internal  {
        IERC20(wftm).transfer(feeAddress,amount);

    }

    function calculateFee(uint256 amount) internal returns(uint256 _amount) {
        uint256 fee = amount*feeRate/100;
        return fee;
    }

    function setPeggerContract(address _contract) public onlyOwner {
        peggerContract = _contract;
    }

    




}