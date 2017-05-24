pragma solidity ^0.4.11;
contract Message {
    string public message;
    
    // function Message () {
    	
    // }

    event LogMessage(address accountAddress, string message);
    
    function submit (string _value) returns (bool success) {
        // do some eval
        // if (_value) {
            LogMessage(msg.sender, _value);
            return true;
        // }
    }
}