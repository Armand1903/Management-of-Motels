--crearea tabelelor
create table patroni (
    id_patron number(3),
    nume varchar2(20),
    prenume varchar2(30)
);
desc patroni;

create table moteluri (
    id_motel number(3),
    denumire varchar2(30),
    nr_camere number(3),
    nivel_comfort number(1),
    pret_noapte number(4)
);
desc moteluri;

create table angajati_m (
    id_angajat number(3),
    nume varchar2(20),
    prenume varchar2(30),
    telefon varchar2(10),
    salariu number(6),
    data_angajare date
);
desc angajati_m;

create table camere (
    id_camera number(4),
    etaj number(1),
    capacitate number(1)
);
desc camere;

create table oaspeti (
    id_oaspete number(6),
    nume varchar2(20),
    prenume varchar2(30),
    telefon varchar2(10),
    email varchar2(30),
    data_sosire date,
    data_plecare date,
    constraint oas_data_ck check (data_sosire < data_plecare)
);
desc oaspeti;
drop table oaspeti;

--actualizarea structurii tabelelor
alter table moteluri add id_patron number(3);
alter table angajati_m add id_motel number(3);
alter table camere add id_motel number(3);
alter table oaspeti add id_camera number(4);

--modificarea restrictiilor de integritate
alter table patroni
add constraint id_patron_pk primary key (id_patron);
alter table patroni
modify (nume constraint pat_nume_nn NOT NULL);
alter table patroni
modify (prenume constraint pat_prenume_nn NOT NULL);
select constraint_name, constraint_type, status 
from user_constraints
where table_name = 'PATRONI';

alter table moteluri
add constraint id_motel_pk primary key (id_motel);
alter table moteluri
modify (nr_camere constraint mot_cam_nn NOT NULL);
alter table moteluri
modify (nivel_comfort constraint mot_nivel_nn NOT NULL);
alter table moteluri
modify (pret_noapte constraint mot_pret_nn NOT NULL);
alter table moteluri
add constraint id_patron_fk foreign key (id_patron)
references patroni(id_patron) ON DELETE SET NULL;
select constraint_name, constraint_type, status 
from user_constraints
where table_name = 'MOTELURI';

alter table angajati_m
add constraint id_angajat_pk primary key (id_angajat);
alter table angajati_m
modify (nume constraint ang_nume_nn NOT NULL);
alter table angajati_m
modify (prenume constraint ang_prenume_nn NOT NULL);
alter table angajati_m
modify (telefon constraint ang_tel_nn NOT NULL);
alter table angajati_m
modify salariu default 2500;
alter table angajati_m
add constraint id_motel_a_fk foreign key (id_motel)
references moteluri(id_motel) ON DELETE SET NULL;
select constraint_name, constraint_type, status 
from user_constraints
where table_name = 'ANGAJATI_M';

alter table camere
add constraint id_camera_pk primary key (id_camera);
alter table camere
modify etaj default 0;
alter table camere
modify (capacitate constraint cam_capacitate_nn NOT NULL);
alter table camere
add constraint id_motel_c_fk foreign key (id_motel)
references moteluri(id_motel) ON DELETE SET NULL;
select constraint_name, constraint_type, status 
from user_constraints
where table_name = 'CAMERE';

alter table oaspeti
add constraint id_oaspete_pk primary key (id_oaspete);
alter table oaspeti
modify (nume constraint oas_nume_nn NOT NULL);
alter table oaspeti
modify (email constraint oas_email_nn NOT NULL);
alter table oaspeti
modify (data_sosire constraint oas_data_sos_nn NOT NULL);
alter table oaspeti
modify (data_plecare constraint oas_data_plc_nn NOT NULL);
alter table oaspeti
add constraint id_camera_fk foreign key (id_camera)
references camere(id_camera) ON DELETE SET NULL;
select constraint_name, constraint_type, status 
from user_constraints
where table_name = 'OASPETI';

select constraint_name, table_name, constraint_type, status 
from user_constraints
where table_name in ('PATRONI','MOTELURI','ANGAJATI_M','CAMERE','OASPETI');


--adaugarea de inregistrari in tabele
--delete from patroni;
select * from patroni;
insert into patroni values (1, 'Popescu','Paul');
insert into patroni values (2, 'Ionescu','Tudor');
insert into patroni values (3, 'Popescu','Teodor');
insert into patroni values (4, 'Cristea','Catalin');
insert into patroni values (5, 'Negoita','Alecu');
insert into patroni values (6, 'Ionescu','Catalin');
insert into patroni values (7, 'Ciobanu','Florin');
insert into patroni values (8, 'Radu','Petra');
insert into patroni values (9, 'Ionescu','Sofia');
insert into patroni values (10, 'Tocmelea','Georgiana');
insert into patroni values (11, 'Draghici','Gherghina');
insert into patroni values (12, 'Draghici','Dalia');

select * from moteluri;
delete from moteluri;
desc moteluri;
--creare secventa
create sequence motel_seq
minvalue 1
maxvalue 999
start with 1
increment by 1
cache 20;
drop sequence motel_seq;
--inserare moteluri
insert into moteluri values (motel_seq.nextval, 'Napoleon', 12, 11, 130, 1); 
--nu se poate introduce din cauza valorii prea mari introduse pentru coloana nivel_comfort
insert into moteluri values (motel_seq.nextval, 'Napoleon', 12, 3, 130, 1); 
insert into moteluri values (motel_seq.nextval, 'Afrodita', 8, 2, 110, 1);
insert into moteluri values (motel_seq.nextval, 'Hera', 10, 3, 150, 1);
insert into moteluri values (motel_seq.nextval, 'Star Wars', 6, 1, 80, 3);
insert into moteluri values (motel_seq.nextval, 'Napoleon', 9, 1, 60, 3);
insert into moteluri values (motel_seq.nextval, 'Dor de Munte', 12, 2, 100, 4);
insert into moteluri (id_motel, nr_camere, nivel_comfort, pret_noapte, id_patron) values (motel_seq.nextval, 5, 3, 150, 8);
insert into moteluri values (motel_seq.nextval, 'Minerva', 8, 1, 75, 8);
insert into moteluri values (motel_seq.nextval, 'Neptun', 11, 2, 90, 8);
alter sequence motel_seq increment by 20;
insert into moteluri values (motel_seq.nextval, 'Hades', 7, 3, 150, 10);
insert into moteluri values (motel_seq.nextval, 'Olimp', 5, 3, 130, 11);
insert into moteluri values (motel_seq.nextval, 'Verona', 8, 2, 90, 11);
alter sequence motel_seq increment by 1;
insert into moteluri values (motel_seq.nextval, 'Venus', 10, 1, 75, 11);
insert into moteluri values (motel_seq.nextval, 'Hercules', 6, 2, 80, 11);
insert into moteluri values (motel_seq.nextval, 'Iunona', 7, 3, 150, 7);

select * from moteluri;
select * from angajati_m;
desc angajati_m;
delete from angajati_m where id_angajat = 12;

insert into angajati_m values (1, 'Popescu', 'Iulian', '0733018910', 3000, TO_DATE('14-SEP-2010', 'DD-MON-YYYY'),1);
insert into angajati_m (id_angajat, nume, prenume, telefon, data_angajare, id_motel) 
    values (2, 'Ionescu', 'Ianis', '0733018911', TO_DATE('17-OCT-2015', 'DD-MON-YYYY'),1);
insert into angajati_m (id_angajat, nume, prenume, telefon, id_motel) 
    values (3, 'Tanica', 'Leonard', '0733018912', 1);
insert into angajati_m (id_angajat, nume, prenume, telefon, data_angajare, id_motel) 
    values (4, 'Davidescu', 'David', '0733018915', TO_DATE('30-NOV-2021', 'DD-MON-YYYY'),4);
insert into angajati_m values (5, 'Chirila', 'Monica', '0331497132', 4500, TO_DATE('14-MAR-2008', 'DD-MON-YYYY'),4);
insert into angajati_m values (6, 'G?bureanu', 'Smaranda', '0794936265', 2700, TO_DATE('19-APR-2018', 'DD-MON-YYYY'),70);
insert into angajati_m values (7, 'Vl?sceanu', 'Ana', '0311080163', 3700, TO_DATE('19-JUL-2013', 'DD-MON-YYYY'),9);
insert into angajati_m values (8, 'Pîndaru', 'Petra', '0707067076', 3200, TO_DATE('28-JUL-2017', 'DD-MON-YYYY'),5);
insert into angajati_m values (9, 'P?lici', 'Mara', '0336442798', 2700, TO_DATE('1-JAN-2022', 'DD-MON-YYYY'),69);
insert into angajati_m values (10, 'Ionescu', 'George', '0369045693', 2650, TO_DATE('10-JAN-2023', 'DD-MON-YYYY'),8);
insert into angajati_m values (11, 'Gherghe', 'Diana', '0724024421', 2650, TO_DATE('5-FEB-2021', 'DD-MON-YYYY'),29);
insert into angajati_m values (12, 'Petrescu', 'Laurentiu', '0716109364', 2900, TO_DATE('19-AUG-2020', 'DD-MON-YYYY'),29);
insert into angajati_m (id_angajat, nume, prenume, telefon, salariu, id_motel) 
    values (13, 'Petrescu', 'Vadim', '0706813969', 3100, 29);
insert into angajati_m values (14, 'Ionescu', 'Stefan', '0315458213', 3000, TO_DATE('21-SEP-2016', 'DD-MON-YYYY'),6);
insert into angajati_m values (15, 'Popescu', 'Valentin', '0708569043', 3300, TO_DATE('27-MAY-2020', 'DD-MON-YYYY'),6);

select * from camere;
desc camere;
insert into camere values (1, 0, 2, 1);
insert into camere (id_camera, capacitate, id_motel) values (2, 1, 4); 
    --etajul este completat automat cu valoarea 0, adica parter
insert into camere values (3, 0, 1, 1);
insert into camere values (4, 0, 3, 1);
insert into camere values (5, 1, 2, 4);
insert into camere values (6, 2, 1, 29);
insert into camere values (7, 2, 2, 29);
insert into camere values (8, 1, 1, 29);
insert into camere values (9, 2, 1, 29);
insert into camere values (10, 0, 1, 6);
insert into camere values (11, 1, 1, 6);
insert into camere values (12, 0, 1, 7);
alter table camere modify etaj default NULL; 
    --am modificat restrictiile tabelei astfel incat, la fiecare valoare lipsa 
    --pentru etaj, sa fie introdusa in tabela valoarea null
insert into camere (id_camera, capacitate, id_motel) values (13, 2, 4);
insert into camere (id_camera, capacitate, id_motel) values (14, 1, 4);
insert into camere values (15, 1, 1, 6);

select * from oaspeti;
desc oaspeti;
insert into oaspeti values (1, 'Hangu', 'Armand-Gabriel', '0733018980', 'armandhangu2@gmail.com', 
    TO_DATE('14-DEC-2022', 'DD-MON-YYYY'), TO_DATE('17-DEC-2022', 'DD-MON-YYYY'), 1);
insert into oaspeti values (2, 'Bazarea', 'Eduard-Nicolae', '0241284222', 'edibazar18@gmail.com', 
    TO_DATE('14-DEC-2022', 'DD-MON-YYYY'), TO_DATE('19-DEC-2022', 'DD-MON-YYYY'), 1);
insert into oaspeti values (3, 'Oana', 'Albert', '0335010953', 'oanalbert30@gmail.com', 
    TO_DATE('17-DEC-2022', 'DD-MON-YYYY'), TO_DATE('23-DEC-2022', 'DD-MON-YYYY'), 3);
insert into oaspeti (id_oaspete, nume, email, data_sosire, data_plecare, id_camera)
    values (4, 'Toma', 'oanalbert30@gmail.com', 
    TO_DATE('18-DEC-2022', 'DD-MON-YYYY'), TO_DATE('22-DEC-2022', 'DD-MON-YYYY'), 6);
insert into oaspeti (id_oaspete, nume, email, data_sosire, data_plecare, id_camera)
    values (5, 'Ionescu', 'ionionescu34@gmail.com', 
    TO_DATE('19-DEC-2022', 'DD-MON-YYYY'), TO_DATE('24-DEC-2022', 'DD-MON-YYYY'), 8);
insert into oaspeti values (6, 'Teodorescu ', 'Dragos', '0268884514', 'teodragon12@gmail.com', 
    TO_DATE('1-JAN-2023', 'DD-MON-YYYY'), TO_DATE('2-JAN-2023', 'DD-MON-YYYY'), 9);
insert into oaspeti (id_oaspete, nume, email, data_sosire, data_plecare)
    values (7, 'Ioan', 'ioanioan24@yahoo.com', TO_DATE('1-JAN-2023', 'DD-MON-YYYY'), TO_DATE('5-JAN-2023', 'DD-MON-YYYY'));
insert into oaspeti values (8, 'Pop', 'Albertino', '0214813354', 'albertinho@yahoo.com', 
    TO_DATE('3-JAN-2022', 'DD-MON-YYYY'), TO_DATE('6-JAN-2022', 'DD-MON-YYYY'), 13);
insert into oaspeti values (9, 'Voinea', 'Cristi', '0353924648', 'voinicescuc79@yahoo.com', 
    TO_DATE('3-JAN-2022', 'DD-MON-YYYY'), TO_DATE('9-JAN-2022', 'DD-MON-YYYY'), 14);
insert into oaspeti (id_oaspete, nume, prenume, email, data_sosire, data_plecare, id_camera)
    values (10, 'Tomescu', 'Denis', 'denistomescu44@gmail.com', 
    TO_DATE('10-JAN-2023', 'DD-MON-YYYY'), TO_DATE('12-JAN-2023', 'DD-MON-YYYY'), 10); 
insert into oaspeti (id_oaspete, nume, telefon, email, data_sosire, data_plecare, id_camera)
    values (11, 'Barbu', '0314801717', 'barbulescu99@hotmail.com', 
    TO_DATE('8-JAN-2023', 'DD-MON-YYYY'), TO_DATE('11-JAN-2023', 'DD-MON-YYYY'), 11);
insert into oaspeti values (12, 'Marin', 'Bogdan', '0736807044', 'marinbogdinho3@hotmail.com', 
    TO_DATE('3-JAN-2022', 'DD-MON-YYYY'), TO_DATE('7-JAN-2022', 'DD-MON-YYYY'), 11);
insert into oaspeti values (13, 'Constantinescu', 'Iulia', '0232097360', 'constantinesq123@yahoo.com', 
    TO_DATE('30-DEC-2022', 'DD-MON-YYYY'), TO_DATE('2-JAN-2023', 'DD-MON-YYYY'), 14);
insert into oaspeti values (14, 'Pavel', 'Clara', '0357920574', 'clarapevale@yahoo.com', 
    TO_DATE('12-DEC-2022', 'DD-MON-YYYY'), TO_DATE('14-DEC-2022', 'DD-MON-YYYY'), 14);
insert into oaspeti values (15, 'Tunaru', 'Gabriela', '0743552014', 'tunargabrel54@gmail.com', 
    TO_DATE('12-DEC-2022', 'DD-MON-YYYY'), TO_DATE('17-DEC-2022', 'DD-MON-YYYY'), 4);
    
commit;

--actualizarea inregistrarilor
update oaspeti
set prenume = 'Andrei'
where prenume is NULL;

update camere
set etaj = 0
where id_motel = 1;

update moteluri
set denumire = 'Popasul Drumetului'
where denumire is null;

update moteluri
set denumire = upper(denumire);
select * from moteluri;
--stergere si recuperare tabela
drop table oaspeti; --stergere
select * from oaspeti;
flashback table oaspeti to before drop; --recuperare

--interogari variate
--1. afisare denumiri moteluri detinute de fiecare proprietar
select p.id_patron, nume, prenume, denumire as "Motel"
from patroni p, moteluri m
where p.id_patron = m.id_patron
order by p.id_patron;
--2. count(moteluri)
select p.id_patron, nume, prenume, count(id_motel) "Nr Moteluri"
from patroni p, moteluri m
where p.id_patron = m.id_patron
group by p.id_patron, nume, prenume
order by count(id_motel) desc, p.id_patron;
--3. sortare moteluri dupa nivelul de comfort
select id_motel, denumire, pret_noapte, nivel_comfort 
from moteluri
order by nivel_comfort desc, pret_noapte desc, id_motel;
--4. cati angajati are fiecare patron?
select p.prenume ||' '|| p.nume as "Patron", count(id_angajat) as "Nr Angajati"
from patroni p, moteluri m, angajati_m a
where p.id_patron = m.id_patron and m.id_motel = a.id_motel
group by p.nume, p.prenume;
--5. care este cel mai mare salariu oferit de fiecare patron in parte?
select p.prenume ||' '|| p.nume as "Patron", max(salariu) as "Salariul maxim"
from patroni p, moteluri m, angajati_m a
where p.id_patron = m.id_patron and m.id_motel = a.id_motel
group by p.nume, p.prenume
order by max(salariu) desc;
--6. care este patronul care ofera cel mai mare salariu?
select nume||' '||prenume as "Patron"
from patroni 
where id_patron = (select id_patron
    from angajati_m a, moteluri m
    where a.id_motel = m.id_motel
    and salariu = (select max(salariu) from angajati_m));
    
--7. clasificati salariatii in functie de castigurile lunare
select nume||' '||prenume as "Nume angajat", salariu "Salariu", 
case when salariu < 3000 then 'Salariu Mic'
    when salariu < 3500 then 'Salariu Mediu'
    else 'Salariu Bun'
    end as "Clasificare salariati"
from angajati_m
order by case when salariu < 3000 then 'Salariu Mic'
when salariu < 3500 then 'Salariu Mediu'
else 'Salariu Bun'
end, nume;

--8. inner join
select nivel_comfort, nr_camere, id_camera, capacitate
from moteluri m
inner join camere c 
on m.id_motel = c.id_motel
where nivel_comfort = 3;

--9. motelurile ocupate in data de 15 decembrie 2022
select * from oaspeti;
select distinct denumire
from moteluri m, camere c
where id_camera in 
(
select id_camera 
from oaspeti
where TO_DATE(data_sosire,'DD-MON-YY') <= TO_DATE('15-DEC-2022', 'DD-MON-YYYY')
and TO_DATE(data_plecare,'DD-MON-YY') >= TO_DATE('15-DEC-2022', 'DD-MON-YYYY') 
)
and m.id_motel = c.id_motel;

--10. sortare moteluri dupa capacitatea camerelor
select * from camere
order by capacitate desc;
select m.denumire, sum(capacitate)
from camere c, moteluri m
where c.id_motel = m.id_motel
group by denumire;

--11. ce oaspeti au inoptat cele mai multe nopti la motel?
select max(TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')) "Nopti petrecute la motel"
from oaspeti;
select nume ||' '|| prenume as "Nume oaspete"
from oaspeti 
where TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')
    = (select max(TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')) from oaspeti);

--12. care sunt acele moteluri?
select denumire as "Motel", nivel_comfort "Comfort", nume ||' '|| prenume as "Nume oaspete"
from oaspeti o, camere c, moteluri m
where TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')
    = (select max(TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')) from oaspeti)
and o.id_camera = c.id_camera
and c.id_motel = m.id_motel;
    
--13. cat are de plata fiecare oaspete?
select pret_noapte * (TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')) as "Plata/oaspete"
from oaspeti o, camere c, moteluri m
where o.id_camera = c.id_camera
and c.id_motel = m.id_motel;

--14. cele mai frecventate moteluri in 2023
select denumire, sum(TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')) "Nr nopti"
from oaspeti o, camere c, moteluri m
where o.id_camera = c.id_camera
and c.id_motel = m.id_motel
and TO_DATE(data_plecare,'DD-MON-YY') >= TO_DATE('1-JAN-23','DD-MON-YY')
group by denumire
order by "Nr nopti" desc;

--15. top venituri obtinute de fiecare patron
select p.nume||' '||p.prenume "Patron", pret_noapte * sum(TO_DATE(data_plecare,'DD-MON-YY') - TO_DATE(data_sosire,'DD-MON-YY')) "Venituri"
from oaspeti o, camere c, moteluri m, patroni p
where o.id_camera = c.id_camera
and c.id_motel = m.id_motel
and m.id_patron = p.id_patron
group by p.nume, p.prenume, pret_noapte
order by "Venituri" desc;

--16. Presupunem ca Popescu Paul, patronul care a obtinut cele mai multe venituri, vrea sa le ofere 
--angajatilor sai o marire de salariu: 20% pentru cei cu vechime mai mare de 10 ani si 10% pentru restul. 
--Cum vor arata salariile angajatilor dupa marire?

select id_angajat id, concat(concat(nume,' '),prenume) as "Angajat", salariu, data_angajare
from angajati_m a, moteluri m
where a.id_motel = m.id_motel
and id_patron = (select id_patron from patroni where nume = 'Popescu' and prenume = 'Paul');

--folosim view
create view angajati_view as
    select initcap(moteluri.denumire) denumire_motel, angajati_m.nume||' '||angajati_m.prenume angajat, angajati_m.salariu, angajati_m.data_angajare
    from angajati_m
    inner join moteluri
    on angajati_m.id_motel = moteluri.id_motel
    where id_patron = (select id_patron from patroni where nume = 'Popescu' and prenume = 'Paul');
    
select * from angajati_view;  
drop view angajati_view;

update angajati_view
set salariu = case
    when extract (year from SYSDATE) - extract (year from (TO_DATE(data_angajare,'DD-MON-YY')) ) > 10 then salariu * 1.2
        else salariu * 1.1
        end;
rollback;

--17. Care sunt camerele care au ajuns la capacitatea lor maxima de-a lungul lunii analizate?
    select c.id_camera, count(id_oaspete) "Oaspeti", capacitate
    from oaspeti o, camere c
    where o.id_camera = c.id_camera
    group by capacitate, c.id_camera;
    
select c.id_camera id, capacitate "Capacitate", case 
    when count(id_oaspete) = capacitate then 'capacitate maxima'
    when count(id_oaspete) < capacitate then 'capacitatea maxima nu a fost atinsa'
    else 'capacitatea maxima a fost depasita'
    end "Oaspeti primiti"
from oaspeti o, camere c
where o.id_camera = c.id_camera
group by capacitate, c.id_camera
order by c.id_camera;

--18. afisati doar id-urile patronilor ce detin moteluri
select id_patron from patroni
INTERSECT
select id_patron from moteluri;
--19. care sunt id-urile patronilor ce nu detin niciun motel?
select id_patron from patroni
MINUS
select id_patron from moteluri;
--20. exista oaspeti care inca nu au fost cazati in nicio camera? (pentru a verifica, folosim comanda minus
select id_camera from oaspeti
MINUS
select id_camera from camere; --returneaza null, deci exista oaspeti care nu sunt cazati
--21. care sunt id-urile camerelor libere? (care nu au fost ocupate pe intreg parcursul lunii)
select id_camera from camere 
MINUS
select id_camera from oaspeti;

--22. sa se afiseze numele angajatilor al caror nume se termina de forma "escu"
select nume from angajati_m where nume like '%escu';

--23. sa se determine cate luni diferenta sunt intre cel mai experimentat si cel mai putin experimentat angajat (indiferent de motelul de care apartin)
--transformati apoi valoarea in ani
select min(TO_DATE(data_angajare,'DD-MON-YY')) from angajati_m;
select max(TO_DATE(data_angajare,'DD-MON-YY')) from angajati_m;
select round( months_between(max(TO_DATE(data_angajare,'DD-MON-YY')), min(TO_DATE(data_angajare,'DD-MON-YY'))) ) "Diferenta experienta in luni" from angajati_m;
select round( months_between(max(TO_DATE(data_angajare,'DD-MON-YY')), min(TO_DATE(data_angajare,'DD-MON-YY'))) /12 ) "Diferenta experienta in ani" from angajati_m;
