#!/bin/bash

# Verifica se o nmap está instalado
if ! command -v nmap &> /dev/null; then
    echo "O nmap não está instalado. Instale-o e tente novamente."
    exit 1
fi

# Verifica se o usuário forneceu um argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <IP ou nome do host>"
    exit 1
fi

HOST="$1"

# Executa a varredura com nmap
echo "Escaneando o host $HOST..."
nmap -T4 -F "$HOST" | tee /dev/tty

# Verifica o status do host (baseado na saída do nmap)
if grep -q "Host is up" <<< "$(nmap -T4 -F "$HOST")"; then
    echo "O host $HOST está ativo."
else
    echo "O host $HOST está inativo ou não foi possível determinar o estado."
fi
