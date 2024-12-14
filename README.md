Introdução:
Este script Bash foi criado com o objetivo de facilitar a criação de links simbólicos e físicos sem a necessidade de usar o terminal diretamente.

Versão do Programa:
Para verificar a versão atual do programa, você pode usar o seguinte comando:
./nome_do_programa --version
Isso exibirá uma janela com as informações da versão e das novidades adicionadas.

Instalação do Zenity:
O zenity é necessário para a execução do script. Se ele não estiver instalado, o programa tentará instalar automaticamente usando o gerenciador de pacotes apt caso o programa tenha sido executado como root. Caso contrário, você precisará instalar manualmente o zenity:
sudo apt install -y zenity

Escolha do Tipo de Link:
O script pergunta se você deseja criar um link simbólico ou físico. Para escolher a opção desejada:
Simbólico: Cria um link que aponta para o arquivo ou diretório original, mas não move-o.
Físico (Link Real): Cria uma cópia exata do arquivo no local especificado.

Seleção de Arquivo ou Diretório:
Se você escolher criar um link simbólico, será solicitada a seleção de um arquivo ou diretório. Para isso, clique em "Arquivo" para selecionar um arquivo individual ou "Pasta" para selecionar um diretório inteiro.

Escolha da Pasta Destino:
Após selecionar o arquivo ou diretório e especificar o tipo de link, será necessário escolher a pasta onde deseja salvar o link simbólico ou físico. Clique em "Selecione a pasta!" para abrir uma janela que permita a seleção da pasta desejada.

Verificação do Zenity Instalado:
Antes de executar o script, ele verificará se o zenity está instalado. Se não estiver, ele exibirá uma mensagem informando que o zenity deve ser instalado e sairá com código de erro 1.

Erros e Problemas:
Zenity não instalado: Se o zenity não for instalado, o script tentará instalar automaticamente. Caso contrário, você precisará instalar manualmente.
Permissões insuficientes: Certifique-se de que você tem as permissões necessárias para criar links nos diretórios especificados.

Conclusão:
Este script é uma ferramenta útil para quem deseja criar links simbólicos e físicos rapidamente, sem a necessidade de usar comandos avançados do terminal. Com apenas algumas etapas, você poderá salvar tempo e facilitar o acesso aos seus arquivos e diretórios.

Espero que este documento ajude você a entender como usar o programa adequadamente!
