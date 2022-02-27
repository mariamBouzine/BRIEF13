----------- Creation of a database -----------

create database commerce;
Use commerce;

----------- La table Cliente ---------------
create table Cliente(
	Code_C char(4) primary key,
    Nom varchar(70) not null,
    Prenom varchar(70) not null,
    Adresse varchar(100) not null,
    Numéro_tele varchar(30) not null,
    Email varchar(50) not null,
    Mot_passe varchar(70) not null
);

----- Insérer des informations dans la table Cliente ------- 
insert into Cliente values('M001','Bouzine','Mariam','Rue assad ibn fourate','0610509576','bouzine.mariam.solicode@gmail.com','123');
insert into Cliente values('M002','Soodi','Zobair','Rue ibni touzin ','0667895839','Soodi.zoubair.solicode@gmail.com','456');
insert into Cliente values('M003','Idrissi','Ayoub','Rue rahal mskin','0698209876','Idrissi.Ayoub.solicode@gmail.com','789');

--------- afficher tout les information de la table Cliente -------
select * from Cliente;

----------- La table Commande ---------------
create table commande(
	Id_cmd char(4) primary key,
    Adresse varchar(50) not null,
    Date_cmd date  not null,
    Code_C char(4),
    constraint Fk_commande FOREIGN KEY (Code_C) REFERENCES Cliente(Code_C) on delete cascade on update cascade
);

----- Insérer des informations dans la table Commande ------- 
insert into commande values('C001','Rue rahal mskin','2022-02-24','M001');
insert into commande values('C002','Rue Assad ibn fourate','2022-02-30','M001');
insert into commande values('C003','tanger madina','2022-03-12','M002');
insert into commande values('C004','Rue KASABAH','2022-05-24','M002');
insert into commande values('C005','Rue rahal mskin','2022-01-24','M003');
insert into commande values('C006','Rue widadiya','2022-02-29','M003');

--------- afficher tout les information de la table Cammande -------
select * from commande;

----------- La table produit ---------------
create table produit(
	Code_P char(4) primary key ,
    Libellé varchar(70) not null,
    Descriptions varchar(70) not null,
    Prix_unitaire float not null,
    Quantité int not null
);

----- Insérer des informations dans la table produit ------- 
insert into produit values('P001','Libellé1','Descriptions1','200',30);
insert into produit values('P002','Libellé2','Descriptions2','400',800);
insert into produit values('P003','Libellé3','Descriptions3','100',90);
insert into produit values('P004','Libellé4','Descriptions4','50',10);
insert into produit values('P005','Libellé5','Descriptions5','600',60);
insert into produit values('P006','Libellé6','Descriptions6','800',90);

--------- afficher tout les information de la table Produit -------
select * from produit;

----------- La table detail ---------------
create table detail(
    Quantite int not null,
    Id_cmd char(4),
    Code_P char(4)
);

----------- Ajouter les contraintes (clé étrangère de la table détaille)---------------
alter table detail add constraint Fk_id_Commande foreign key (Id_cmd) REFERENCES commande(Id_cmd) on delete cascade on update cascade;
alter table detail add constraint Fk_id_produit foreign key (Code_P) REFERENCES produit(Code_P) on delete cascade on update cascade;
alter table detail add constraint PK_id_produit_id_Commande primary key (Id_cmd,Code_P);

----- Insérer des informations dans la table detail ------- 
insert into detail values(100,'C001','P001');
insert into detail values(300,'C002','P003');
insert into detail values(50,'C003','P002');
insert into detail values(70,'C004','P005');
insert into detail values(400,'C005','P006');
insert into detail values(800,'C006','P004');

--------- afficher tout les information de la table detail -------
select * from detail;

-- R1: Afficher les Information de tous les clients .
select * from Cliente;

-- R2: Afficher le nom et le prenom de tous les clients classes par order alphabetique .
select Nom , Prenom from Cliente
order by Nom , Prenom ;

-- R3: Afficher toutes les commandes effectuees a une date précise .
select * from commande 
where Date_cmd = '2022-02-24';
 
-- R4: Afficher le nombre de commandes d'un client dont le nom et le prenom sont egaux a des value précise .
select count(*) nbr_cmd from commande Cmd
inner join Cliente Cl on Cmd.Code_C = Cl.Code_C
where Nom = 'Bouzine' and Prenom ='Mariam' ;

-- R5: Afficher tous les produits de votre magasin .
select * from produit;

-- R6: Afficher les produits le prix est superieur a une valeur précise .
select * from produit
where Prix_unitaire > 400;

-- R7:  Afficher les produits qui sont en reptire de stock (Quantite en stock = 0) .
select * from produit
where Quantite = 0;

-- R8: Afficher le detail d'une commande (passee par un client doit le nom et le prenom sont egaux a des value précise a une date précise) .
select Cl.Code_C , Cl.Nom , Cl.Prenom , Cmd.Adresse , Cmd.Date_cmd , Dtl.Quantite  from commande Cmd 
inner join Cliente Cl on Cl.Code_C = Cmd.Code_C
inner join detail Dtl on Dtl.Id_cmd = Cmd.Id_cmd
where Cl.Nom = 'Bouzine' and Cl.Prenom ='Mariam' and Cmd.Date_cmd = '2022-02-24';

-- R9: Afficher le prix total d'une commande (passee par un client doit le nom et le prenom sont egaux a des value précise a une date précise) .
select Cl.Code_C , Cl.Nom , Cl.Prenom , Cmd.Adresse , Cmd.Date_cmd , Dtl.Quantite , (Dtl.Quantite * P.Prix_unitaire) as Totale from commande Cmd 
inner join Cliente Cl on Cl.Code_C = Cmd.Code_C
inner join detail Dtl on Dtl.Id_cmd = Cmd.Id_cmd
inner join produit P on P.Code_P = Dtl.Code_P 
where Cl.Nom = 'Bouzine' and Cl.Prenom ='Mariam' and Cmd.Date_cmd = '2022-02-24';



