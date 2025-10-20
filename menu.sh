#!/bin/bash
# menu.sh - Menu interativo para o servidor Minecraft Bedrock

SERVER_DIR="$(dirname "$0")"
SERVER_EXEC="$SERVER_DIR/bedrock_server"
PID_FILE="$SERVER_DIR/server.pid"

function start_server() {
    if [ -f "$PID_FILE" ]; then
        echo "Servidor já está rodando!"
        return
    fi
    echo "Iniciando servidor..."
    "$SERVER_EXEC" > "$SERVER_DIR/server.log" 2>&1 &
    echo $! > "$PID_FILE"
    echo "Servidor iniciado com PID $(cat $PID_FILE)"
}

function stop_server() {
    if [ ! -f "$PID_FILE" ]; then
        echo "Servidor não está rodando!"
        return
    fi
    PID=$(cat "$PID_FILE")
    echo "Parando servidor com PID $PID..."
    kill "$PID"
    rm "$PID_FILE"
    echo "Servidor parado."
}

function status_server() {
    if [ -f "$PID_FILE" ]; then
        echo "Servidor rodando com PID $(cat $PID_FILE)"
    else
        echo "Servidor não está rodando."
    fi
}

while true; do
    clear
    echo "===== Menu Servidor Minecraft Bedrock ====="
    echo "1) Start"
    echo "2) Stop"
    echo "3) Status"
    echo "4) Sair"
    echo "=========================================="
    read -p "Escolha uma opção: " opt

    case "$opt" in
        1) start_server ;;
        2) stop_server ;;
        3) status_server ;;
        4) exit ;;
        *) echo "Opção inválida! Pressione Enter..." ; read ;;
    esac

    echo "Pressione Enter para voltar ao menu..."
    read
done
