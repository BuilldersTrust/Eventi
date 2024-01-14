// SPDX-License-Identifier: MI

pragma solidity ^0.8.17;
import "./Eventii.sol";

contract MinimalProxyFactory {
    
    address[] proxies;
    
    mapping(address => address[]) proxiesTracker;
    event NewProxy(address indexed _owner, address indexed proxyAddress);

    function deployClone(address _implementationContract, address _owner, string memory _eventName , uint256 _eventDate, uint256 _price, uint256 _mintableTicket ) external {
        bytes20 implementationContractInBytes = bytes20(_implementationContract);
        //address to assign a cloned proxy
        address proxy;
 
        assembly {

            let clone := mload(0x40)
            // store 32 bytes to memory starting at "clone"
            mstore(
                clone,
                0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000
            )

            mstore(add(clone, 0x14), implementationContractInBytes)

            mstore(
                add(clone, 0x28),
                0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000
            )

            /*
            |                 20 bytes                  |          20 bytes          |           15 bytes          |
            0x3d602d80600a3d3981f3363d3d373d3d3d363d73b<implementationContractInBytes>5af43d82803e903d91602b57fd5bf3 == 45 bytes in total
            */
            
            
            // create a new contract
            // send 0 Ether
            // code starts at the pointer stored in "clone"
            // code size == 0x37 (55 bytes)
            proxy := create(0, clone, 0x37)
        }
       
        // Call initialization
        Eventii(proxy).initialize(_owner, _eventName, _eventDate, _price, _mintableTicket);
        proxies.push(proxy);
        proxiesTracker[_owner].push(proxy);
        emit NewProxy(_owner, proxy);
    }

    function getuserProxies(address _owner) external view returns(address[] memory){
        return proxiesTracker[_owner];
    }

    function allproxies() external view returns(address[] memory){
        return proxies;
    }
}
