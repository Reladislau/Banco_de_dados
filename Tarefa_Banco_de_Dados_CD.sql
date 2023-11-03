create database DB_CDS;
USE DB_CDS;


create table tb_artista (
 pk_Cod_Art int primary key not null auto_increment,
 Nome_Art varchar (100) not null unique key
);

describe tb_artista;

create table tb_gravadora(
	pk_cod_grav int primary key not null auto_increment,
    nome_grav varchar (50) unique key not null
);

describe tb_gravadora;

create table tb_categoria(
pk_Cod_Cat int primary key not null auto_increment,
Nome_Cat varchar (50) unique key not null
);

describe tb_categoria;

create table tb_Estado(
	Pk_Sigla_Estado char(2) primary key not null,
    Nome_Estado char(50) unique key not null
);

describe tb_estado;

create table tb_Cidade(
	Pk_Cod_Cid int primary key not null auto_increment,
    Fk_Sigla_Estado char(2) not null,
    Nome_Cid varchar (100) not null unique key
);

alter table tb_Cidade 
add constraint Fk_Sigla_Estado
foreign key (Fk_Sigla_Estado)
references tb_Estado (Pk_sigla_estado);

describe tb_cidade;

create table Tb_Cliente(
	Pk_Cod_Cli int primary key not null, 
    Fk_cod_Cid int,
    Nome_Cli varchar (100) not null,
    End_Cli varchar (100) not null,
    Renda_cli decimal (10.2) check(Renda_Cli >=0) default 0,
    Sexo_Cli char(1) check (Sexo_Cli = 'F' or Sexo_Cli = 'M') default 'F'
);

alter table tb_Cliente
add constraint fk_cod_cid
foreign key (fk_cod_cid)
references tb_cidade (pk_cod_cid);

describe Tb_Cliente;

create table tb_conjuge(
    Fk_cod_cli int not null,
    nome_conj varchar (100) not null,
    Renda_conj decimal (10.2) check(Renda_conj >=0) default 0,
    Sexo_conj char(1) check (Sexo_conj = 'F' or Sexo_Conj = 'M') default 'M',
    
    foreign key (Fk_cod_cli)
	references Tb_Cliente (Pk_Cod_Cli)
);

describe tb_conjuge;

create table tb_funcionario (
	Pk_Cod_Func int not null primary key auto_increment,
    Nome_func varchar (100) not null, 
    End_func varchar (100) not null,
    sal_func decimal (10.2) not null default 0 check (Sal_func >=0),
    sexo_func char (1) not null check (sexo_func = 'M' or sexo_func = 'F') default 'M'
);

describe tb_funcionario;

create table tb_dependente(
	Pk_Cod_dep int not null primary key auto_increment,
    Fk_Cod_func int not null,
    Nome_dep varchar (100) not null,
    sexo_dep char (1) check (sexo_dep = 'F' or sexo_dep = 'M') default 'M',
    
    foreign key (Fk_Cod_func)
    references tb_funcionario(Pk_cod_func)
);

describe tb_dependente;

create table tb_titulo (
	Pk_cod_tit int primary key not null auto_increment,
    fk_cod_cat int not null,
    Fk_Cod_grav int not null,
    Nome_CD varchar (100) not null unique key, 
    val_cd decimal (10.2) not null check (val_cd > 0),
    Qtd_Cd int not null check (Qtd_Cd >= 0),
    
    foreign key (fk_cod_cat)
    references tb_categoria(pk_cod_cat),
    
    foreign key (fk_cod_grav)
    references tb_gravadora(Pk_cod_Grav)
);

describe tb_titulo;

create table tb_pedido(
	pk_num_ped int not null primary key auto_increment,
    fk_cod_cli int not null,
    fk_cod_func int not null,
	data_ped datetime not null,
    val_ped decimal (10.2) not null check (val_ped >= 0) default 0,
    
    foreign key (fk_cod_cli)
    references tb_cliente (pk_cod_cli),
    
    foreign key (fk_cod_func)
    references tb_funcionario (pk_cod_func)
    );
    
    describe tb_pedido;
    
    create table tb_titulo_pedido(
		Fk_num_ped int not null, 
        Fk_Cod_tit int Not null, 
        Qtd_cd int not null check (Qtd_cd >=1), 
        Val_Cd decimal (10.2) check (Val_cd > 0),
        
        primary key (Fk_num_ped, Fk_Cod_tit),
        
        foreign key (Fk_num_ped)
        references tb_pedido(pk_num_ped),
        foreign key (Fk_Cod_tit)
        references tb_titulo(Pk_cod_tit)
    );
    
    describe tb_titulo_pedido;
    
    create table tb_titulo_artista(
		fk_Cod_tit int not null,
        fk_Cod_art int not null,
        
        primary key (fk_cod_tit, fk_cod_art),
        
        foreign key (Fk_cod_tit)
        references tb_titulo(Pk_cod_tit),
        
        foreign key (Fk_cod_art)
        references tb_artista (Pk_cod_art)
    );
    
    describe tb_titulo_artista;