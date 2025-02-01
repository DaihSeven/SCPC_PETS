CREATE database mp_scpc_pets;

CREATE TABLE Tutor (
    CPF VARCHAR(11) PRIMARY KEY NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    RG VARCHAR(20) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Endereco VARCHAR(200) NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Animal (
    RGA INT PRIMARY KEY NOT NULL,
    Nome VARCHAR(50),
    Especie ENUM('Cão', 'Gato') NOT NULL,
    Raca VARCHAR(50),
    Sexo ENUM('Macho', 'Fêmea') NOT NULL,
    Idade INT NOT NULL,
    Peso DECIMAL(5,2),
    Foto BLOB,
    Status_Raiva ENUM('Vacinado', 'Não Vacinado'),
    fk_CPF_Tutor VARCHAR(11),
    FOREIGN KEY (fk_CPF_Tutor) REFERENCES Tutor(CPF)
);

CREATE TABLE Termo_Encaminhamento (
    ID_Codigo_Termo INT PRIMARY KEY NOT NULL auto_increment,
    Data_Emissao DATETIME NOT NULL,
    Tipo_Solicitacao ENUM('Presencial', 'Online') NOT NULL,
    Status_Termo ENUM('Pendente', 'Aprovado', 'Aguardando Agendamento', 'Cancelado') NOT NULL,
    fk_CPF_Tutor VARCHAR(11),
    fk_RGA_Animal INT,
    Comprovante_Residencia BLOB,
    Documento_Identificacao BLOB,
    Carteira_Vacinacao BLOB,
    Observacoes TEXT,
    Protocolo_Identificacao VARCHAR(50),
    FOREIGN KEY (fk_CPF_Tutor) REFERENCES Tutor(CPF),
    FOREIGN KEY (fk_RGA_Animal) REFERENCES Animal(RGA)
);

CREATE TABLE Veterinario (
    CRM_CRMV VARCHAR(20) PRIMARY KEY NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Especialidade VARCHAR(50),
    Telefone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Agendamento (
    ID_Codigo_Agendamento INT PRIMARY KEY NOT NULL auto_increment,
    fk_ID_Codigo_Termo INT,
    Data_Agendamento DATE NOT NULL,
    Data_Cirurgia DATE NOT NULL,
    Status ENUM('Confirmado', 'Pendente', 'Realizado') NOT NULL,
    fk_CPF_Tutor VARCHAR(11),
    fk_RGA_Animal INT,
    fk_CRM_Veterinario VARCHAR(20),
    FOREIGN KEY (fk_ID_Codigo_Termo) REFERENCES Termo_Encaminhamento(ID_Codigo_Termo),
    FOREIGN KEY (fk_CPF_Tutor) REFERENCES Tutor(CPF),
    FOREIGN KEY (fk_RGA_Animal) REFERENCES Animal(RGA),
    FOREIGN KEY (fk_CRM_Veterinario) REFERENCES Veterinario(CRM_CRMV)
);

CREATE TABLE Procedimento_Cirurgico (
    ID_Codigo_Procedimento INT PRIMARY KEY NOT NULL auto_increment,
    Tipo_Cirurgia VARCHAR(50) NOT NULL,
    Data_Realizacao DATE NOT NULL,
    Observacoes TEXT,
    fk_RGA_Animal INT,
    fk_CRM_Veterinario VARCHAR(20),
    FOREIGN KEY (fk_RGA_Animal) REFERENCES Animal(RGA),
    FOREIGN KEY (fk_CRM_Veterinario) REFERENCES Veterinario(CRM_CRMV)
);

