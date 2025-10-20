from web3 import Web3
import json
import os
from dotenv import load_dotenv

load_dotenv()

# Conexão com a blockchain local (Anvil)
RPC_URL = "http://127.0.0.1:8545"
PRIVATE_KEY = os.getenv("PRIVATE_KEY")
ACCOUNT_ADDRESS = os.getenv("ACCOUNT_ADDRESS")
CONTRACT_ADDRESS = os.getenv("CONTRACT_ADDRESS")

w3 = Web3(Web3.HTTPProvider(RPC_URL))
assert w3.is_connected(), "Falha ao conectar à blockchain"

# ABI do contrato compilado (você pode gerar com `forge build`)
abi = json.loads('''[
    {"inputs":[],"stateMutability":"nonpayable","type":"constructor"},
    {"inputs":[],"name":"precoPizza","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},
    {"inputs":[{"internalType":"string","name":"sabor","type":"string"}],"name":"fazerPedido","outputs":[],"stateMutability":"payable","type":"function"},
    {"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"entregarPedido","outputs":[],"stateMutability":"nonpayable","type":"function"},
    {"inputs":[],"name":"totalPedidos","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}
]''')

contract = w3.eth.contract(address=CONTRACT_ADDRESS, abi=abi)

def fazer_pedido(sabor):
    preco = contract.functions.precoPizza().call()
    nonce = w3.eth.get_transaction_count(ACCOUNT_ADDRESS)
    tx = contract.functions.fazerPedido(sabor).build_transaction({
        "from": ACCOUNT_ADDRESS,
        "value": preco,
        "gas": 300000,
        "gasPrice": w3.eth.gas_price,
        "nonce": nonce
    })

    signed_tx = w3.eth.account.sign_transaction(tx, PRIVATE_KEY)
    tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
    receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    print(f"🍕 Pedido '{sabor}' enviado! Hash: {tx_hash.hex()}")

if __name__ == "__main__":
    print("🤖 Agente autônomo conectado!")
    fazer_pedido("mussarela")
