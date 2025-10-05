// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Pizzaria {
    address public dono;
    uint256 public precoPizza = 0.01 ether;
    uint256 public pedidoCount;

    enum Status { Nenhum, PedidoRealizado, Confirmado, Entregue }

    struct Pedido {
        address cliente;
        string sabor;
        Status status;
    }

    mapping(uint256 => Pedido) public pedidos;

    event PedidoFeito(uint256 id, address cliente, string sabor);
    event PedidoConfirmado(uint256 id);
    event PedidoEntregue(uint256 id);

    constructor() {
        dono = msg.sender;
    }

    function fazerPedido(string calldata sabor) external payable {
        require(msg.value == precoPizza, "Valor incorreto da pizza");

        pedidoCount++;
        pedidos[pedidoCount] = Pedido(msg.sender, sabor, Status.PedidoRealizado);
        emit PedidoFeito(pedidoCount, msg.sender, sabor);
    }

    function confirmarPedido(uint256 id) external {
        require(msg.sender == dono, "Apenas o dono pode confirmar");
        require(pedidos[id].status == Status.PedidoRealizado, "Pedido invalido");
        pedidos[id].status = Status.Confirmado;
        emit PedidoConfirmado(id);
    }

    function entregarPedido(uint256 id) external {
        require(msg.sender == dono, "Apenas o dono pode entregar");
        require(pedidos[id].status == Status.Confirmado, "Pedido nao confirmado");
        pedidos[id].status = Status.Entregue;
        emit PedidoEntregue(id);
    }

    function consultarStatus(uint256 id) external view returns (Status) {
        return pedidos[id].status;
    }

    function sacar() external {
        require(msg.sender == dono, "Apenas o dono pode sacar");
        payable(dono).transfer(address(this).balance);
    }
}
