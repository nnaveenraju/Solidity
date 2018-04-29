pragma solidity ^0.4.23;

//library to hold the math functions..
library SafeMath{
    
     function mul(uint256 a, uint256 b) internal pure returns (uint256 value) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert( c/a == b);
        return c;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256 value) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a + b;
        assert( c - a == b);
        return c;
    }
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256 value) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a - b;
        assert( c + a == b);
        return c;
    }
    
}

contract NaveenToken {

  //using the SafeMath library above. This is like include the library in the contract..
  
    using SafeMath for uint256;
    
    
    uint256 public totalSupply;
    
    //Is the mapping of key value pair to balances..
    
    mapping (address => uint256) public balances;
    mapping (address=> mapping(address=>uint256) ) public allowances;
    
    string public name;
    string public symbol;
    uint8 public decimals;
    string public version;
    
    //events that will be exposed from this contract..
    event Transfer (address indexed _from, address indexed _to, uint256 _value);
    event Approval (address indexed _owner, address indexed _spender, uint256 _value);
    
    
    
    constructor() public
    {
        //constructor .. 
        name = "Naveen Token";
        symbol = "NTR";
        decimals = 18;
        version = "0.1";
        
        //total token +number of '0' as the decimals..
        
        totalSupply = 1000000000000000000000000;
        
        balances[msg.sender]= totalSupply;
        
    }
 
    //view is read only..
    function totalSupply() public view returns (uint256)
    {
        return totalSupply;
    }
    
    
    function transfer(address _to, uint256 _value)public returns (bool) {
        
        require(_to != address(0));
        require( _value <= balances[msg.sender]);
        
        balances[msg.sender]= balances[msg.sender].sub(_value);
        balances[_to]=balances[_to].add(_value);
        
        //to expose the events.. use the emit keyword.
        emit Transfer(msg.sender, _to,_value);
        return true;
        
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance) {
        
        return balances[_owner];
        
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowances[_from][msg.sender]);
        
        balances[_from] =balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        
        allowances[_from][msg.sender] = allowances[_from][msg.sender].sub(_value);
        emit Transfer(_from,_to, _value);
        
        return true;
    }
    
    
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        
        return true;
    }
    
}
