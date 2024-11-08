import mysql.connector
from mysql.connector import Error

def criar_conexao(host, usuario, senha, banco):
    try:
        con = mysql.connector.connect(
            host=host,
            user=usuario,
            password=senha,
            database=banco
        )
        if con.is_connected():
            print("Conexão com o banco de dados bem-sucedida")
        return con
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

    
def fechar_conexao(con):
    return con.close()
