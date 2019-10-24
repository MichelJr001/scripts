# -*- coding: utf-8 -*-
# Versao: 0.1
# Desenvolvido por Michel Anderson
# Erno Soluções © 2019


from Modulos.pypdf import PdfFileWriter, PdfFileReader
from tkinter import *

# Local do arquivo
local_arquivo = 'Arquivos/Dados.pdf'

class Manipulador():
        def __init__():
                pass
        def LerPdf():
                with open(local_arquivo, mode='rb') as f:
                        # Ler o pdf
                        Leitor = PdfFileReader(f)
        
                        # Pegar o numero de paginas
                        Leitor.getNumPages()
        
                        # Trazer conteudo da pagina 1
                        Pagina = Leitor.getPage(0)
        
                        # Extrai o texto da pagina
                        TextoPagina = Pagina.extractText()
                        print(TextoPagina)

        def EscreverPdf():
                pass

if __name__ == '__main__':
        Manipulador()
