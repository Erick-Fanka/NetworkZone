#!/bin/bash
# Script para configurar usuários, grupos, diretórios e permissões em um servidor Linux
# Autor: Erick Fanka
# Data: 2024-06-27

# Criação dos grupos
sudo groupadd devs
sudo groupadd gerentes
echo "Grupos criados com sucesso."

# Criação dos usuários
sudo useradd -m -s /bin/bash ana
sudo useradd -m -s /bin/bash bruno
sudo useradd -m -s /bin/bash carla
echo "Usuários criados com sucesso."

# Atualizando a senhas dos usuários
sudo chpasswd <<EOF
ana:1234
bruno:1234
carla:1234
EOF
echo "Senhas atualizadas com sucesso."

# Adicionar os usuários aos grupos
sudo usermod -aG devs ana
sudo usermod -aG devs bruno
sudo usermod -aG gerentes carla
echo "Usuários adicionados aos grupos com sucesso."

# Criação dos diretórios
sudo mkdir -p /srv/projetos/{projeto_alpha,projeto_beta}/{codigo,documentos}
echo "Diretórios criados com sucesso."

# Definir a posse de propriedade dos diretórios
sudo chown -R root:devs /srv/projetos 
echo "Propriedade dos diretórios definida com sucesso."

# Aplicar permissões base
sudo chmod -R 770 /srv/projetos
echo "Permissões base aplicadas com sucesso."

# Instalar o ACL (se não estiver instalado)
sudo apt update 
sudo apt install -y acl 
echo "ACL instalado com sucesso."

# Configurar ACLs para os diretórios
# r: read (leitura)
# w: write (escrita)
# x: execute (execução/acesso a diretório)

# Aplicar ACLs para pastas de codigo
sudo setfacl -R -m g:gerentes:r-x /srv/projetos/projeto_alpha/codigo 
sudo setfacl -R -m g:gerentes:r-x /srv/projetos/projeto_beta/codigo

#Para pastas de documentos
sudo setfacl -R -m g:gerentes:rwx /srv/projetos/projeto_alpha/documentos 
sudo setfacl -R -m g:gerentes:rwx /srv/projetos/projeto_beta/documentos
echo "ACLs configuradas com sucesso."