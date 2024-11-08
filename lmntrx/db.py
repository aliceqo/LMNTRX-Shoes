from conexao import criar_conexao


def iniciar_conexao():
    try:
        con = criar_conexao("localhost", "root", "1234", "lmntrx")
        return con
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None
