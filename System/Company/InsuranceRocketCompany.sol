// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;
import "../Token/ERC20.sol";
import "./IInsuranceRocketCompany.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "hardhat/console.sol";

contract InsuranceRocketCompany is InterfaceRocket{
    //Utilizamos la  libreria SafeMath para los tipos de datos uint
    using SafeMath for uint;

    //Token
    ERC20Rocket token;
    address private owner;
    address public addressContract;

    constructor() {
        token = new ERC20Rocket("MedicineRocket", "MR");
        token.mint(10000);

        owner = msg.sender;
        addressContract = address(this);
    }

    //---------------------------------------Modifiers---------------------------------------
    modifier onlyOwner {
        require(msg.sender == owner, "No tienes los permisos necesarios para ejecutar esta funcion");
        _;
    }

    //---------------------------------------Events---------------------------------------
    //Evento para notificar una recarga de tokens al contrato
    event rechargeTokensEvent(uint);
    //Evento para notificar el cambio de estado de un servicio
    event changeStatusServiceEvent(string);
    //Evento para notificar un servicio creado
    event createServiceEvent(string);

    //---------------------------------------Mappings---------------------------------------
    //Mapping para relacionar el nombre de un servicio con su estructura de datos
    mapping(string => Service) public Services;

    //---------------------------------------Arrays---------------------------------------
    //Array para almacenar el listado de los servicios
    string[] private listServices;

    //---------------------------------------Funciones para contrato principal---------------------------------------

    //Funcion para recargar tokens al contrato
    function rechargeTokens(uint _amount) public override onlyOwner {
        token.mint(_amount);

        emit rechargeTokensEvent(_amount);
    }

    //Funcion para ver el listado de servicios activos
    function showActivedServices() public override returns(string[] memory){
        string[] memory activedServices = new string[] (listServices.length);
        uint counter = 0;

        for(uint i = 0; i < listServices.length; i++){
            if(Services[listServices[i]].statusService = true){
                activedServices[counter] = listServices[i];
                counter++;
            }
        }

        return activedServices;       
    }

    //Funcion para mostrar un servicio por su nombre
    function showService(string memory _name) public view override returns(Service memory){
        return Services[_name];
    }

    //Funcion para agregar servicios
    function createService(string memory _name, uint _price) public override onlyOwner{
        Services[_name] = Service(_price, true);
        listServices.push(_name);
        emit createServiceEvent("Se ha creado un nuevo servicio.");
    }

    //Funcion para desactivar servicios
    function changeStatusService(string memory _name) public override onlyOwner{
        Services[_name].statusService = !Services[_name].statusService;

        emit changeStatusServiceEvent("Se ha cambiado el estado del servicio correctamente.");
    }

    //Funcion para convertir el precio de tokens a ethers
    function tokenToEthers(uint _quantity) private view override returns(uint){
        return _quantity * (1 ether);
    }

    //Funcion para pagar 
    
    //Funcion para solicitar una suscripcion
    //Funcion para habilitar un usuario
    //Funcion para solicitar si el usuario está habilitado para crear su contrato con la compania



    //---------------------------------------Contrato clientes---------------------------------------
    //funcion para crear contrato para asegurados
    //funcion para devolver ether cuando un usuario se da de baja


    //---------------------------------------Contratos laboratorios---------------------------------------
    //funcion para crear contrato de laboratorios
    


}

contract Client{
    //Funcion para comprar tokens
    function buyTokens(uint _quantity) public payable override{
        uint cost = tokenToEthers(_quantity);

        require(msg.value >= cost, "Necesitas mas ethers para comprar esta cantidad de tokens.");

        uint returnValue = msg.value - cost;
        payable(msg.sender).transfer(returnValue);

        token.transfer(msg.sender, _quantity);
    }
}