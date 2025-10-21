// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Test.sol";
import "../src/Pizzaria.sol";

contract PizzariaTest is Test {
    Pizzaria public pizzaria;
    address cliente = address(0x123);

    function setUp() public {
        pizzaria = new Pizzaria();
    }

    function testFazerPedido() public {
        vm.deal(cliente, 1 ether); // dá ETH para o cliente

        vm.prank(cliente); // simula cliente chamando função
        pizzaria.fazerPedido{value: 0.01 ether}("Calabresa");

        (address c, string memory sabor,) = pizzaria.pedidos(1);
        assertEq(c, cliente);
        assertEq(sabor, "Calabresa");
    }

    function testConfirmarPedido() public {
        vm.deal(cliente, 1 ether);
        vm.prank(cliente);
        pizzaria.fazerPedido{value: 0.01 ether}("Mussarela");

        pizzaria.confirmarPedido(1);

        assertEq(uint256(pizzaria.consultarStatus(1)), uint256(Pizzaria.Status.Confirmado));
    }

    function testEntregarPedido() public {
        vm.deal(cliente, 1 ether);
        vm.prank(cliente);
        pizzaria.fazerPedido{value: 0.01 ether}("Frango");

        pizzaria.confirmarPedido(1);
        pizzaria.entregarPedido(1);

        assertEq(uint256(pizzaria.consultarStatus(1)), uint256(Pizzaria.Status.Entregue));
    }
}
