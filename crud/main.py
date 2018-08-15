#!/usr/bin/env python3

import sqlite3

con = sqlite3.connect('database.db')
c = con.cursor()

class painel():
    def cadastro(self, nome, sobrenome, nascimento, sexo, cpf):
        self.nome = nome
        self.sobrenome = sobrenome
        self.nascimento = nascimento
        self.sexo = sexo
        self.cpf = cpf

        c.execute("INSERT INTO clientes (nome, sobrenome, nascimento, sexo, cpf) VALUES ('{}', '{}', '{}', '{}', '{}'".format(nome, sobrenome, nascimento, sexo, cpf))
        con.commit()

    def mostra(self):
        pass

painel.cadastro('Michel', 'Anderson', '2001-05-19', 'M', 50267358865, '@@@')

