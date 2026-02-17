from fastapi import FastAPI
from database import get_connection
from schemas import UsuarioCreate

app = FastAPI()

@app.get("/")
def home():
    return {"msg": "Padawan API rodando"}

@app.post("/usuarios")
def criar_usuario(usuario: UsuarioCreate):
    conn = get_connection()
    cursor = conn.cursor()

    query = """
    INSERT INTO usuarios (nome,email,senha,tipo)
    VALUES (%s,%s,%s,%s)
    """

    cursor.execute(query, (
        usuario.nome,
        usuario.email,
        usuario.senha,
        usuario.tipo
    ))

    conn.commit()
    cursor.close()
    conn.close()

    return {"msg": "Usuário criado"}
