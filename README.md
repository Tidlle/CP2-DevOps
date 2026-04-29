# CP2 Docker - DimDim

Projeto desenvolvido para o checkpoint de Docker e Cloud Computing.

A solução possui dois containers Docker:

- API REST em Java com Spring Boot
- Banco de dados MySQL 8

Os containers se comunicam por uma rede Docker chamada `dimdim-network`, e o banco utiliza um volume nomeado chamado `mysql-dimdim-volume` para persistência.

---

## Tecnologias utilizadas

- Azure VM
- Linux
- Docker
- Docker Network
- Docker Volume
- Java 17
- Spring Boot
- Spring Data JPA
- Maven
- MySQL 8

---

## Estrutura do projeto

```txt
cp2-completo/
├── api-dimdim/
│   ├── pom.xml
│   └── src/
│       └── main/
│           ├── java/br/com/dimdim/api/
│           │   ├── ApiDimdimApplication.java
│           │   ├── Cliente.java
│           │   ├── ClienteController.java
│           │   └── ClienteRepository.java
│           └── resources/
│               └── application.properties
├── scripts/
│   ├── criar.sh
│   └── remover.sh
└── README.md
```

---

# How To - Como implementar a solução no Docker

## 1. Pré-requisitos

A VM Linux precisa ter Docker instalado.

Verifique com:

```bash
docker --version
```

Caso precise instalar no Ubuntu:

```bash
sudo apt update -y
sudo apt install -y docker.io git nano curl
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

Depois saia da VM e entre novamente para aplicar a permissão do Docker.

---

## 2. Clonar o repositório

```bash
git clone https://github.com/Tidlle/CP2-DevOps.git
cd api-dimdim
```

---

## 3. Dar permissão aos scripts

```bash
chmod +x scripts/criar.sh
chmod +x scripts/remover.sh
```

---

## 4. Criar os containers

```bash
./scripts/criar.sh
```

Esse script cria:

- Rede Docker `dimdim-network`
- Volume Docker `mysql-dimdim-volume`
- Container MySQL `mysql-dimdim-RM562259`
- Container da API `api-dimdim-RM562259`

---

## 5. Verificar containers em execução

```bash
docker ps
```

Devem aparecer dois containers:

```txt
mysql-dimdim-RM562259
api-dimdim-RM562259
```

---

## 6. Testar a API

```bash
curl http://localhost:8080/clientes
```

Retorno esperado inicialmente:

```json
[]
```

---

# CRUD da API

## INSERT

```bash
curl -X POST http://localhost:8080/clientes \
-H "Content-Type: application/json" \
-d '{"nome":"Joao Silva","email":"joao@email.com"}'
```

## SELECT pela API

```bash
curl http://localhost:8080/clientes
```

## UPDATE

```bash
curl -X PUT http://localhost:8080/clientes/1 \
-H "Content-Type: application/json" \
-d '{"nome":"Joao Atualizado","email":"joao.atualizado@email.com"}'
```

## DELETE

```bash
curl -X DELETE http://localhost:8080/clientes/1
```

## SELECT final pela API

```bash
curl http://localhost:8080/clientes
```

---

# Conferir dados diretamente no banco

Entrar no MySQL:

```bash
docker exec -it mysql-dimdim-RM562259 mysql -u user_dimdim -p
```

Senha:

```txt
senha_dimdim
```

Selecionar banco:

```sql
USE db_dimdim;
```

Mostrar tabela:

```sql
SHOW TABLES;
```

Mostrar registros:

```sql
SELECT * FROM cliente;
```

Esse comando deve ser usado após o INSERT, UPDATE e DELETE para evidenciar as alterações diretamente no banco.

---

# Remover ambiente

```bash
./scripts/remover.sh
```
