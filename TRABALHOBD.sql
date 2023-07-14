create database Trabalho_BD;
USE Trabalho_BD;

/* criando as entidades 
primeiro criamos e depois criamos as constraints */

create Table Estudantes(
	IDestudantes INT PRIMARY KEY AUTO_INCREMENT,
	Nome varchar(45) not null,
	CPF char(11) not null,
	Sexo char(1),
	Matrícula varchar(15) not null,
	campus varchar(30) not null,
	curso varchar(40) not null,
	Email varchar(100) not null UNIQUE,
	senha varchar(16) not null,
	Tipo varchar(15) not null
	);

create Table Professores(
	IDprofessores INT PRIMARY KEY AUTO_INCREMENT,
	nome varchar(45) not null,
	tel_celular char(11) not null, /* não criei uma entidade para telefone pois ele pode colocar apenas 1 (fixo e celular) */
	Email varchar(100) not null UNIQUE,
	ID_departamentoP INT not null
);
create Table Departamento(
	IDdepartamento INT PRIMARY KEY,
	Nome varchar(45) not null,
	Responsavel varchar(45) not null,
	Telefone varchar(10) not null,
	Email varchar(100) not null
);
create Table Turma(
	IDturma INT PRIMARY KEY AUTO_INCREMENT,
	Semestre varchar(10) not null,
	Horario varchar(15) not null,
	Local varchar(30),
	ID_disciplinaT varchar(10) not null,
	ID_professorT INT not null
);
create Table Disciplina(
	IDdisciplina varchar(10) PRIMARY KEY,
	Nome varchar(45) not null,
	ID_departamentoD INT not null
);
create Table Avaliações(
	IDavaliações INT PRIMARY KEY AUTO_INCREMENT,
	Avaliação varchar(200) not null,
	Data DATE not null,
	ID_estudanteA INT not null,
	ID_turmaA INT not null
);
create Table denuncias(
	IDdENUNCIA INT PRIMARY KEY AUTO_INCREMENT,
	Tipo varchar(45) not null,
	Data DATE not null,
	ID_estudanteD INT not null,
	ID_avaliaçõesD INT not null,
	ID_admD INT not null
);

ALTER TABLE Professores
ADD CONSTRAINT FK_Professor_Departamento
FOREIGN KEY(ID_departamentoP)
REFERENCES Departamento(IDdepartamento);

ALTER TABLE Turma
ADD CONSTRAINT FK_Turma_disciplina
FOREIGN KEY (ID_disciplinaT)
REFERENCES Disciplina(IDdisciplina);

ALTER TABLE Turma
ADD CONSTRAINT FK_Turma_professor
FOREIGN KEY (ID_professorT)
REFERENCES Professores(IDprofessores);

ALTER TABLE Disciplina
ADD CONSTRAINT FK_disciplina_departamento
FOREIGN KEY(ID_departamentoD)
REFERENCES Departamento(IDdepartamento);

ALTER TABLE Avaliações
ADD CONSTRAINT FK_avaliação_estudante
FOREIGN KEY(ID_estudanteA)
REFERENCES Estudantes(IDestudantes);

ALTER TABLE Avaliações
ADD CONSTRAINT FK_avaliação_turma
FOREIGN KEY(ID_turmaA)
REFERENCES Turma(IDturma);

ALTER TABLE denuncias
ADD CONSTRAINT FK_denuncia_estudante
FOREIGN KEY(ID_estudanteD)
REFERENCES Estudantes(IDestudantes);

ALTER TABLE denuncias
ADD CONSTRAINT FK_denuncia_avaliação
FOREIGN KEY(ID_avaliaçõesD)
REFERENCES Avaliações(IDavaliações);

ALTER TABLE denuncias
ADD CONSTRAINT FK_denuncia_estudante
FOREIGN KEY(ID_admD)
REFERENCES Estudantes(IDestudantes);

# Inserindo alunos
INSERT INTO Estudantes VALUES(NULL,'Lucas','03323273921','M','211029049','Darcy Ribeiro','Estatística','LUCAS@IG.COM','76567587887','ADM');
INSERT INTO Estudantes VALUES(NULL,'João','03323456921','M','210029048','FGA','Ciencia da computação','JOAO@IG.COM','5464553466','Estudante');
INSERT INTO Estudantes VALUES(NULL,'Maria','39123273462','F','211059042','Darcy Ribeiro','História','MARIA@IG.COM','456545678','Estudante');
INSERT INTO Estudantes VALUES(NULL,'Jorge','63256301639','M','171056047','FGA','Ciencia da computação ','JORGE@IG.COM','8756547688','Estudante');
INSERT INTO Estudantes VALUES(NULL,'Celia','046581976','F','211029049','Darcy Ribeiro','Ciencia da computação ','CELIA@IG.COM','5767876889','ADM');

#Inserindo alguns departamentos (com procedure)

DELIMITER #

STATUS

CREATE PROCEDURE CAD_DEPARTAMENTO(D_ID INT,
							D_NOME varchar(45), 
							D_Responsavel varchar(45),
							D_Telefone varchar(10),
							D_Email varchar(100)
							)
BEGIN
		
		INSERT INTO Departamento VALUES(D_ID,D_NOME,D_Responsavel,D_Telefone,D_Email);

END 
#

DELIMITER ;

CALL CAD_DEPARTAMENTO(345,'DEPARTAMENTO DE COMUNICAÇAO ORGANIZACIONAL','GABRIELA PEREIRA DE FREITAS ','6133865332', 'GABRIELAPEREIRA@UNB.BR');
CALL CAD_DEPARTAMENTO(327,'DEPTO ADMINISTRAÇÃO','DIEGO MOTA VIEIRA ','6133054786','DIEGOMOTA@UNB.BR');
CALL CAD_DEPARTAMENTO(514,'DEPTO ESTATÍSTICA','RAUL YUKIHIRO MATSUSHITA','6133567892','RAULYUKIHIRO@UNB.BR');
CALL CAD_DEPARTAMENTO(559,'DEPTO HISTÓRIA','TERESA CRISTINA DE NOVAES MARQUES','6133875438','TERESACRISTINA@UNB.BR');
CALL CAD_DEPARTAMENTO(508,'DEPTO CIÊNCIAS DA COMPUTAÇÃO','CAMILO CHANG DOREA','6133247890', 'CAMILOCHANG@UNB.BR');


#Inserindo alguns professores
INSERT INTO Professores VALUES(NULL,'GABRIELA PEREIRA DE FREITAS','61999865332','GABRIELAPEREIRA@UNB.BR',345);
INSERT INTO Professores VALUES(NULL,'DIEGO MOTA VIEIRA', '61999054786','DIEGOMOTA@UNB.BR',327);
INSERT INTO Professores VALUES(NULL,'RAUL YUKIHIRO MATSUSHITA','61999567892','RAULYUKIHIRO@UNB.BR',514);
INSERT INTO Professores VALUES(NULL,'TERESA CRISTINA DE NOVAES MARQUES','6133875438','TERESACRISTINA@UNB.BR',559);
INSERT INTO Professores VALUES(NULL,'CAMILO CHANG DOREA','61999247890','CAMILOCHANG@UNB.BR',508);


#Inserindo Disciplinas
INSERT INTO Disciplina VALUES('COM0133','METODOLOGIA DE PESQUISA EM COMUNICAÇÃO',345);
INSERT INTO Disciplina VALUES('COM0128','INTRODUÇÃO AO MARKETING',345);
INSERT INTO Disciplina VALUES('COM0152','ASSESSORIA E CONSULTORIA EM COMUNICAÇÃO',345);
INSERT INTO Disciplina VALUES('ADM0002','ESTUDOS E PESQUISAS EM ADMINISTRAÇÃO',327);
INSERT INTO Disciplina VALUES('ADM0061','LOGÍSTICA ORGANIZACIONAL',327);
INSERT INTO Disciplina VALUES('ADM0214','INTRODUÇÃOA TEORIAS ORGANIZACIONAIS',327);
INSERT INTO Disciplina VALUES('EST0048','PROCESSOS ESTOCASTICOS',514);
INSERT INTO Disciplina VALUES('EST0046','DEMOGRAFIA',514);
INSERT INTO Disciplina VALUES('HIS0090','HISTÓRIA ANTIGA 2',559);
INSERT INTO Disciplina VALUES('HIS0091','HISTÓRIA MEDIEVAL 1',559);
INSERT INTO Disciplina VALUES('CIC0097','BANCOS DE DADOS',508);
INSERT INTO Disciplina VALUES('CIC0124','REDES DE COMPUTADORES',508);

#Inserindo turmas
INSERT INTO Turma VALUES(null,'2022.1','5N1234','FAC- ICC Norte','COM0133',1);
INSERT INTO Turma VALUES(null,'2022.1','35N12','PAT','ADM0061',2);
INSERT INTO Turma VALUES(null,'2022.1','6N1234',null,'EST0048',3);
INSERT INTO Turma VALUES(null,'2023.1','35N34','PJC','HIS0090',4);
INSERT INTO Turma VALUES(null,'2023.1','35N34','PAT','CIC0124',5);


#criando avaliações
INSERT INTO Avaliações VALUES(null,'Matéria ótima mas o professor é confuso','2022-07-02',1,3);
INSERT INTO Avaliações VALUES(null,'Não cobra presença','2022-06-02',1,3);
INSERT INTO Avaliações VALUES(null,'Muito difícil','2023-04-02',1,5);
INSERT INTO Avaliações VALUES(null,'O professor é um @#!€3@%&$3','2022-03-10',4,2);

#criando denuncias
INSERT INTO denuncias VALUES(null,'Conteúdo ofensivo','2022-03-12',2,4,5);

select * from Estudantes
select * from Professores
select * from Departamento
select * from Avaliações
select * from Turma
select * from Avaliações
select * from denuncias