from pydantic import BaseModel

class User(BaseModel):
    name: str
    email: str
    tipo: str
    senha: str

