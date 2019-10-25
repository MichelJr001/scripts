# -*- coding: utf-8 -*-
# Versao: 0.2
# Desenvolvido por Michel Anderson
# AllRisk Soluções  © 2019

from Modulos.Manipulador import *
import os

Arquivos = os.listdir('Arquivos/')
os.system('cls')

def processar(NomeArquivo):
    TextoPDF = PegarTexto('Arquivos\\{}'.format(NomeArquivo))
    for Paginas in TextoPDF:
        processado = open('Resultado\\'+NomeArquivo+'.txt', 'a')
        # Decomentar somente quando querer os dados em um só arquivo
        #processado = open('Resultado\\Resultado.txt', 'a')
        processado.write(str(NomeArquivo)+str(Paginas))
        processado.close()
def processarFotos(NomeArquivo):
    ExtrairImagens('Arquivos\\{}'.format(NomeArquivo))
       
for Arquivo in Arquivos:
    processar(Arquivo)
    print('Processando... {}'.format(Arquivo))
    processarFotos(Arquivo)
    print('Processando fotos... {}'.format(Arquivo))
print('Fim!')
