#!/bin/bash
# Script para gerenciar servidor Minecraft Bedrock
# ================================================

SERVER_PATH=~/minecraft_server/bedrock-server
SERVER_EXEC="$SERVER_PATH/bedrock_server"
PID_FILE="$SERVER_PATH/server.pid"

function start_server() {
    if [ -f "$PID_FILE" ]; then
        echo "Servidor já está rodando!"
        return
    fi
    echo "Iniciando servidor..."
    box64 "$SERVER_EXEC" & echo $! > "$PID_FILE"
    echo "Servidor iniciado com PID $(cat $PID_FILE)"
}

function stop_server() {
    if [ ! -f "$PID_FILE" ]; then
        echo "Servidor não está rodando!"
        return
    fi
    echo "Desligando servidor..."
    kill $(cat "$PID_FILE") && rm "$PID_FILE"
    echo "Servidor desligado!"
}

function status_server() {
    if [ -f "$PID_FILE" ]; then
        echo "Servidor rodando com PID $(cat "$PID_FILE")"
    else
        echo "Servidor não está rodando."
    fi
}

# Menu simples
echo "=============================="
echo "Gerenciador Minecraft Bedrock"
echo "1) Start"
echo "2) Stop"
echo "3) Status"
echo "4) Sair"
echo "=============================="
read -p "Escolha uma opção: " opt

case $opt in
    1) start_server ;;
    2) stop_server ;;
    3) status_server ;;
    4) exit ;;
    *) echo "Opção inválida!" ;;
esac
