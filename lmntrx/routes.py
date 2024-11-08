from flask import Blueprint, jsonify, render_template, request
from conexao import fechar_conexao
from db import iniciar_conexao

main = Blueprint('main', __name__)

@main.route('/')
def home():
   return render_template('html/index.html')

@main.route('/carrinho')
def carrinho():
    return render_template('html/carrinho.html')

@main.route('/login')
def login():
    return render_template('html/login.html')

@main.route('/ofertas')
def ofertas():
    return render_template('html/ofertas.html')

@main.route('/automobilismo')
def automobilismo():
    return render_template('html/categorias/automobilismo.html')

@main.route('/aventura')
def aventura():
    return render_template('html/categorias/aventura.html')

@main.route('/basquete')
def basquete():
    return render_template('html/categorias/basquete.html')

@main.route('/caminhada')
def caminhada():
    return render_template('html/categorias/caminhada.html')

@main.route('/corrida')
def corrida():
    return render_template('html/categorias/corrida.html')

@main.route('/esporte-de-quadra')
def esporteDeQuadra():
    return render_template('html/categorias/esporte-de-quadra.html')

@main.route('/streetwar')
def streetwar():
    return render_template('html/categorias/streetwar.html')

@main.route('/tennis-e-squash')
def tennisESquash():
    return render_template('html/categorias/tennis-e-squash.html')

#conexões BD
@main.route('/pesquisar', methods=['GET'])
def pesquisar():
    termo = request.args.get('termo', '')
    con = iniciar_conexao()  # Chama a função para criar a conexão
    if not con:
        return jsonify({"erro": "Erro ao conectar ao banco de dados"}), 500

    cursor = con.cursor()
    
    try:
        query = "SELECT nome FROM produto WHERE nome LIKE %s"
        cursor.execute(query, ('%' + termo + '%',))
        resultados = cursor.fetchall()
        
        nomes = [resultado[0] for resultado in resultados]
        return jsonify(nomes)
    except Exception as e:
        return jsonify({"erro": f"Erro ao realizar a busca: {str(e)}"}), 500
    finally:
        fechar_conexao(con)