const express = require("express")
const mysql = require("mysql2")
const cors = require("cors")

const app = express()

app.use(cors())
app.use(express.json())

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "projeto_padawan"
})

db.connect(err => {
    if(err){
        console.log("Erro ao conectar no banco")
        return
    }
    console.log("Banco conectado")
})

app.get("/usuarios", (req, res) => {

    const sql = "SELECT id, nome, email, tipo FROM usuarios"

    db.query(sql, (err, result) => {
        if(err){
            res.status(500).send(err)
        } else {
            res.json(result)
        }
    })

})

app.get("/grupos", (req, res) => {

    const sql = "SELECT * FROM grupos"

    db.query(sql, (err, result) => {
        if(err){
            res.status(500).send(err)
        } else {
            res.json(result)
        }
    })

})

app.get("/vinculos", (req, res) => {

    const sql = `
    SELECT 
        m.nome AS mentor,
        c.nome AS calouro
    FROM vinculos v
    JOIN usuarios m ON v.mentor_id = m.id
    JOIN usuarios c ON v.calouro_id = c.id
    `

    db.query(sql, (err, result) => {
        if(err){
            res.status(500).send(err)
        } else {
            res.json(result)
        }
    })

})

app.get("/encontros", (req, res) => {

    const sql = "SELECT * FROM encontros"

    db.query(sql, (err, result) => {
        if(err){
            res.status(500).send(err)
        } else {
            res.json(result)
        }
    })

})

app.listen(3000, () => {
    console.log("Servidor rodando na porta 3000")
})