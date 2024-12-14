#!/bin/bash

#=============================================================================#
# Script Bash simples que foi escrito com o objetivo de criar links simbólicos
# sem precisar usar o terminal.
#=============================================================================#
## Changelog
# Versão: 1.0
    # versão de origem

# Versão: 1.01
    # Foi adicionado um parâmetro para versionamento.
    # Foi adicionada a opção de criar também link fisíco.

#=============================================================================#
# Copyright (C) <2024>  <aguamole>
#
# This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>
#=============================================================================#
# Parâmetro de versionamento
if [[ "$1" == '--version' ]]
then
    zenity --info --title="Versão!" --text='Versão: 1.01
Foi adicionado um parâmetro para versionamento.
Foi adicionada a opção de criar também link fisíco.'
    exit '0'
fi

# Verifica e instala o zenity se necessario
if [[ ! "$(command -v zenity)" ]]
then
    if [[ "$(command -v apt)" ]]
    then
        if [[ "$(whoami)" == 'root' ]]
        then
            apt install -y zenity &&
            zenity --info --title="Notificação do programa" --text="O zenity \
foi instalado com sucesso!
Continuando..."
            [[ "$?" != '0' ]] && exit '1'
        else
            echo "Falha ao instalar o zenity, você deve ser root, \
tente novamente"
            exit '1'
        fi
    else
        echo "Falha ao instalar o Zenity, instale o Zenity e tente novamente!"
        exit '1'
    fi
fi

# Obtem a resposta se deseja criar link simbólico ou link físico
SIMBOLICO_FISICO=$(zenity --list --radiolist --column="ESCOLHA" --column="" \
    --title="Sombólico ou físico?" --text="Você deseja criar link simbólico \
ou link físico?" \
TRUE "Simbólico" \
FALSE "Físico") || exit '1'

# Obtem a resposta se é para criar link de arquivo ou pasta
if [[ "${SIMBOLICO_FISICO}" == 'Simbólico' ]]
then
    ARQUIVO_PASTA=$(zenity --list --radiolist --column="ESCOLHA" --column="" \
        --title="Arquivo ou diretorio?" --text="Deseja criar link para arquivo ou pasta?" \
TRUE "Arquivo" \
FALSE "Pasta") || exit '1'
fi

# Janela de selecão do arquivo ou da pasta
if [[ "${ARQUIVO_PASTA}" == 'Arquivo' ]]   # Seleção de arquivo
then   # Selecionar o arquivo
    ARQUIVO=$(zenity --file-selection --title="Selecione o arquivo!")
    [[ -z "${ARQUIVO}" ]] && exit '1'
elif [[ -z "${ARQUIVO_PASTA}" ]]; then   # Seleção de arquivo
    ARQUIVO=$(zenity --file-selection --title="Selecione o arquivo!")
    [[ -z "${ARQUIVO}" ]] && exit '1'
elif [[ "${SIMBOLICO_FISICO}" == 'Simbólico' ]]; then   # Seleção de pasta
    if [[ "${ARQUIVO_PASTA}" == 'Pasta' ]]; then # Selecionar a pasta
        DIRETORIO=$(zenity --file-selection \
            --directory --title="Selecione a pasta!")
        [[ -z "${DIRETORIO}" ]] && exit '1'
    fi
fi

# Selecionar a pasta de destino do link simbólico
DIRETORIO_SEGUNDO=$(zenity --file-selection --directory \
    --title="Selecione a pasta!")
[[ -z "${DIRETORIO_SEGUNDO}" ]] && zenity --info --title="Calcelado!" \
    --text="Certo, o programa será fechado!
Saindo..."
[[ -z "${DIRETORIO_SEGUNDO}" ]] && exit '1'

# Cria o link simbólico ou link físico
if [[ "${SIMBOLICO_FISICO}" == 'Simbólico' ]]
then   # Cria o link simbólico
    if [[ "${ARQUIVO_PASTA}" == 'Arquivo' ]]
    then   # Para arquivo
        ln -s "${ARQUIVO}" "${DIRETORIO_SEGUNDO}"
        if [[ "$?" == '0' ]]
        then
            zenity --info --title="Sucesso!" \
                --text="O link simbólico foi criado com sucesso!"
        else
            zenity --info --title="Falha!" \
                --text="Falha ao criar o link simbólico, tente novamente!"
        fi
    else   # Para pasta
        ln -s "${DIRETORIO}" "${DIRETORIO_SEGUNDO}"
        if [[ "$?" == '0' ]]
        then
            zenity --info --title="Sucesso!" \
                --text="O link simbólico foi criado com sucesso!"
        else
            zenity --info --title="Falha!" \
                --text="Falha ao criar o link simbólico, tente novamente!"
        fi
    fi
else   # Cria o link físico
    if [[ "${ARQUIVO_PASTA}" == 'Arquivo' ]]
    then   # Para arquivo
        ln --physical "${ARQUIVO}" "${DIRETORIO_SEGUNDO}"
        if [[ "$?" == '0' ]]
        then
            zenity --info --title="Sucesso!" \
                --text="O link físico foi criado com sucesso!"
        else
            zenity --info --title="Falha!" \
                --text="Falha ao criar o link físico, tente novamente!"
        fi
    fi
fi
