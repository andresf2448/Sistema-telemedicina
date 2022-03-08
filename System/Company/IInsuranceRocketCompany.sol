// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

interface InterfaceRocket {
    //---------------------------------------Structs---------------------------------------
    //Servicios ofrecidos (precio y estado)
    struct Service {
        uint priceService;
        bool statusService;
    }

    function rechargeTokens(uint _amount) external;

    function showActivedServices() external returns(string[] memory);

    function showService(string memory _name) external returns(Service memory);

    function createService(string memory _name, uint price) external;

    function changeStatusService(string memory _name) external;

    function tokenToEthers(uint _quantity) external view returns(uint);
}

