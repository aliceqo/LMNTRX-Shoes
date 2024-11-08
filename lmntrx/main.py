from flask import Flask
from routes import main as main_routes
from db import iniciar_conexao  # Importando a função iniciar_conexao
from conexao import fechar_conexao

app = Flask(__name__)
app.register_blueprint(main_routes)

if __name__ == '__main__':
    con = iniciar_conexao()  # Chama a função para conectar ao banco de dados
    if not con:
        print("Erro ao conectar ao banco de dados")
    try:
        app.run(port=5500, debug=True)
    finally:
        if con:
            fechar_conexao(con)  # Fecha a conexão quando o servidor parar
