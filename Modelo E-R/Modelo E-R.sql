/*-------------
 |    DROPS    |
 -------------- */
 
DROP TABLE auditoria_articulos;
DROP TABLE control_precios;
DROP TABLE pedido;
DROP TABLE articulo;
DROP TABLE jefe_empleado;
DROP TABLE jefe;
DROP TABLE empleado;
DROP TABLE departamento;
DROP TABLE proveedor;
DROP TABLE cliente;

/*----------------
 |CREACIÓN TABLAS|
 ----------------- */

CREATE TABLE cliente(
    DNI VARCHAR2(9) CONSTRAINT dni_cl_pk PRIMARY KEY,
    Nombre VARCHAR2(15) CONSTRAINT nom_cl_nt NOT NULL,
    Apellido VARCHAR2(25) CONSTRAINT app_cl_nt NOT NULL,
    telefono VARCHAR2(11),
    Sexo CHAR(1) CONSTRAINT sex_cl_ck CHECK (UPPER(sexo) IN ('H' ,'M')),
    saldo NUMBER(12,2) CONSTRAINT saldo_cl_nt NOT NULL,
    pais VARCHAR2(15) CONSTRAINT pais_cl_ck CHECK (UPPER(pais) IN ('CHILE','ESPAÑA','ANDORRA','FRANCIA','REINO UNIDO','NORUEGA','ALEMANIA'))
);

CREATE TABLE proveedor(
    cod_proveedor VARCHAR2(5) CONSTRAINT cod_pro_pk PRIMARY KEY,
    Nombre VARCHAR2(20) CONSTRAINT nom_pro_nt NOT NULL,
    telefono VARCHAR2(11) CONSTRAINT tef_pro_nt NOT NULL,
    direccion VARCHAR2(50)

);

CREATE TABLE departamento(
    cod_departamento VARCHAR2(5) CONSTRAINT cod_dep_pk PRIMARY KEY,
    nombre VARCHAR2(20) CONSTRAINT nom_dep_nt NOT NULL,
    area_ventas NUMBER(3) CONSTRAINT ar_dep_nt NOT NULL
);

CREATE TABLE jefe(
    cod_jefe VARCHAR2(5) CONSTRAINT cod_jf_pk PRIMARY KEY,
    nombre VARCHAR2(20) CONSTRAINT nom_jf_nt NOT NULL,
    apellido VARCHAR2(20) CONSTRAINT app_jf_nt NOT NULL,
    telefono VARCHAR2(11) CONSTRAINT tef_jf_nt NOT NULL,
    cod_departamento VARCHAR2(5) CONSTRAINT coddep_jf_fk REFERENCES departamento
);

CREATE TABLE  empleado(
    cod_empleado VARCHAR2(6) CONSTRAINT code_emp_pk PRIMARY KEY,
    cod_departamento VARCHAR2(5) CONSTRAINT coddepa_emp_fk REFERENCES departamento,
    nombre VARCHAR2(15) CONSTRAINT nomb_emp_nt NOT NULL,
     apellido VARCHAR2(25) CONSTRAINT appe_emp_nt NOT NULL,
     telefono VARCHAR2(11) CONSTRAINT tlf_jf_nt NOT NULL
);


CREATE TABLE jefe_empleado(
    cod_jefe VARCHAR2(5) CONSTRAINT codj_je_fk REFERENCES jefe,
    cod_empleado VARCHAR2(6) CONSTRAINT code_je_fk REFERENCES empleado,
    fecha_ini DATE CONSTRAINT feini_je_nt NOT  NULL,
    fecha_fin DATE 
);

CREATE TABLE articulo(
    cod_articulo VARCHAR2(6),
    cod_proveedor VARCHAR2(5) CONSTRAINT codp_art_fk REFERENCES proveedor,
    cod_departamento VARCHAR2(5) CONSTRAINT codd_art_fk REFERENCES departamento,
    CONSTRAINT cods_art_pk PRIMARY KEY(cod_articulo,cod_departamento),
    precio_proveedor NUMBER(12,2) CONSTRAINT pp_art_nt NOT NULL,
    precio_venta NUMBER(12,2) CONSTRAINT pv_art_nt NOT NULL,
    nombre VARCHAR2(45) CONSTRAINT nom_art_nt NOT NULL,
    stock NUMBER(5) CONSTRAINT cant_art_nt NOT NULL,
    categoria VARCHAR2(20) CONSTRAINT cat_art_nt NOT NULL
);

CREATE TABLE pedido(
    cod_pedido VARCHAR2(10) CONSTRAINT cped_ped_pk PRIMARY KEY,
    dni VARCHAR2(9) CONSTRAINT dni_ped_fk REFERENCES cliente,
    cod_articulo VARCHAR2(6) ,
    cod_departamento VARCHAR2(5),
    CONSTRAINT codart_ped_fk FOREIGN KEY(cod_articulo,cod_departamento) REFERENCES articulo,
    cantidad NUMBER(3) CONSTRAINT cant_ped_nt NOT NULL,
    fecha DATE,
    fecha_llegada DATE,
    precio NUMBER(8,2) CONSTRAINT pre_ped_nt NOT NULL
);

CREATE TABLE control_precios(
    operacion VARCHAR2(8) CONSTRAINT op_cp_ck CHECK(UPPER(operacion) IN ('AUMENTAR','REDUCIR')),
    descripcion VARCHAR2(20),
    porcentaje NUMBER(3,1) CONSTRAINT por_cp_nt NOT NULL,
    fecha DATE CONSTRAINT fech_cp_nt NOT NULL,
    usuario VARCHAR2(30) CONSTRAINT usu_cp_nt NOT NULL
);
CREATE TABLE auditoria_articulos(
    usuario VARCHAR2(20) CONSTRAINT usu_audart_nt NOT NULL,
    fecha_hora VARCHAR2(22) CONSTRAINT fech_audart_nt NOT NULL,
    operacion NUMBER(1) CONSTRAINT opp_audart_nt NOT NULL,
    datos_antiguos VARCHAR2(80),
    datos_nuevos VARCHAR2(80)
);

/*-----------------
 |INSERCCIÓN DATOS|
 ------------------ */

/*-------------
 |  CLIENTES  |
 -------------- */
INSERT INTO cliente VALUES('48124785E','José','Ruiz González','627345920','H',250.23,'España');
INSERT INTO cliente VALUES('12473265J','Marta','Ruiz Magro',null,'M',456.45,'España');
INSERT INTO cliente VALUES('65893234T','Diego','Domínguez López',null,null,25.12,'Chile');
INSERT INTO cliente VALUES('85603123G','Carmen','Campos Fernández','867456',null,1123,'Andorra');
INSERT INTO cliente VALUES('58340212S','María José','López Rodríguez','823224586','M',1423.84,'Alemania');
INSERT INTO cliente VALUES('84632218W','Paula','Magro Méndez',null,'M',327,'Francia');
INSERT INTO cliente VALUES('87567391F','Aksel','Seim Harr','22118080',null,453.25,'Noruega');
INSERT INTO cliente VALUES('94236523B','Sophie','Brown Joy',null,'M',422.63,'Reino Unido');
INSERT INTO cliente VALUES('84372347H','Adrienne','Pierre Dubois',null,null,324,'Francia');
INSERT INTO cliente VALUES('74830928L','Mark','Hamill Jackson',null,'H',487.92,'Reino Unido');
INSERT INTO cliente VALUES('74712948K','Lourdes','Hernández Prieto','678084492','M',223.41,'Alemania');

/*-------------
 |PROVEEDORES |
 -------------- */
CREATE SEQUENCE proveedores START WITH 1 INCREMENT BY 1;

INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'ASUS','96734273','Avd. Almodóvar 12 (Madrid)');
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'MSI','96755555','Calle Carrer de Paris 65 (Barcelona)');
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'Gigabyte','9333327','Calle Carrer de Bilbao 58 (Barcelona)');
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'Intel','93412840',null);
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'AMD','998332565','Avd. Andalucía 33 (Madrid)');
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'Zotac','933215674',null);
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'Toshiba','922363127',null);
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'Nox','922363127','Calle Ebro 43 (Sevilla)' );
INSERT INTO proveedor VALUES('C-00'||TO_CHAR(proveedores.nextval),'EVGA','966767423','Calle Francos Rodríguez 4 (Madrid)' );
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Tacens','998746126',null);
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Corsair','922437786','Calle Carrer del Vallès 22 (Barcelona)' );
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Cooler Master','933525619','Calle Carrer de Malgrat 1 (Barcelona)' );
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Samsung','911647950','Calle Passatge de Marí 9 (Barcelona)' );
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Western Digital','915985565',null);
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Nestle','923873323',null);
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Nescafé','923873323',null);
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Mercadona','92840921',null);
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'Bosh','954673323',null);
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'DeWalt','998462847',null);
INSERT INTO proveedor VALUES('C-0'||TO_CHAR(proveedores.nextval),'BIC','935218746',null);
INSERT INTO proveedor VALUES('Local','Tienda','-',null);
DROP SEQUENCE proveedores;

/*-------------
 |DEPARTAMENTO|
 -------------- */
CREATE SEQUENCE departamentos START WITH 1 INCREMENT BY 1; 

INSERT INTO departamento VALUES('DE-0'||TO_CHAR(departamentos.nextval),'Montaje',1);
INSERT INTO departamento VALUES('DE-0'||TO_CHAR(departamentos.nextval),'Reparaciones',1);
INSERT INTO departamento VALUES('DE-0'||TO_CHAR(departamentos.nextval),'Att.cliente',0);
INSERT INTO departamento VALUES('DE-0'||TO_CHAR(departamentos.nextval),'Venta',15);
INSERT INTO departamento VALUES('DE-0'||TO_CHAR(departamentos.nextval),'Recepción',1);
INSERT INTO departamento VALUES('DE-0'||TO_CHAR(departamentos.nextval),'Bar',3);
DROP SEQUENCE departamentos;

/*-------------
 |  EMPLEADO  |
 -------------- */
CREATE SEQUENCE empleados START WITH 1 INCREMENT BY 1;

INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Juán','Moreno Gómez','687542390');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Silvia','Bonilla Rivero','657352853');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Gabriela','Vasquez Soliz','638149046');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Lázaro','Pelayo Tapia','663863369');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Artemisa','Lozano Batista','640094299');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Elinda','Estrada Almonte','642856556');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Rafael','Espinosa Hernández','608417524');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Mohamed','Rosario Campos','619271895');
INSERT INTO empleado VALUES('E-00'||TO_CHAR(empleados.nextval),'DE-04','Bonifacio','Alfaro Llarnas','669069308');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Arnold','Gallegos Ayala','699077274');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Pilar','Mila Arellano','711843173');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Ibero','Cepeda Samaniego','662421506');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Lucía','Ferrer Fernández','674208857');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Pedro','Flores Razo','789091619');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Eduardo','Blanco Maestas','673611016');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Teodoro','Palomo Escobar','656226825');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-04','Nicolás','Campos López','758365548');

INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Fernando','Nino Carmona','632542390');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Celia','Acosta Díaz','692432390');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Eva','Zambrano Garza','607406016');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Angel','Orta Gómez','623173781');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Natalio','Aguilar Orta','612748856');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Adriana','Orta Valladares','740105849');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Joaquín','Crespo García','615798687');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','Rafael','Moreno Gómez','644531390');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-06','José Luis','López Zambrano','677877823');

INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-05','Judith','Campos Fernández','679896337');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-05','Victoria','García López','634563323');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-05','Iván','Rojo Pina','718875709');

INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-03','Juana','Godoy Herrera','629404917');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-03','Inma','Rodríguez  Gómez','610375160');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-03','Ismael','Hernández Zambrano','687547452');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-03','Eustaquio','Torres Lozano','677755614');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-03','Nuria','Carrizosa Murillo','608120342');

INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-02','Natalia','Rodríguez Torres','731206690');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-02','Olivia','Molina Prieto','685293005');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-02','Emilio','Robles Gómez','656447341');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-02','Santiago','Campos Herrera','666915740');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-02','Ana','Gómez Campos','673205641');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-02','Roberto','Almaraz Gómez','687947319');

INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Isabel','Nazareno Salcido','664680255');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Laura','Suárez Zaragoza','616840279');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Elvisa','Gamboa Velázquez','657964919');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Úrsula','Enríquez Ramos','683413297');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Vitorino','Chavarría Núñez','628242894');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Alejandro','Alemán Gastelum','621842973');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Sara','Venegas Acuna','625467325');
INSERT INTO empleado VALUES('E-0'||TO_CHAR(empleados.nextval),'DE-01','Orquídea','Galindo Reyna','653353273');
DROP SEQUENCE empleados;

/*-------------
 |    JEFES    |
 -------------- */
CREATE SEQUENCE jefes START WITH 1 INCREMENT BY 1;

INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Luis','Quintanilla Chacón','687619091','DE-01');
INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Adrián','Abrego Márquez','646735628','DE-06');
INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Rafael','Becerra Pabón','687619091','DE-05');
INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Sofía','Bustos Díaz','672750372','DE-04');
INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Caín','Villalpando Saavedra','659987091','DE-02');
INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Daniel','Pulido Álvarez','669089060','DE-03');
INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Sabrina','Mota Nazario','677547578','DE-02');
INSERT INTO jefe VALUES('JE-0'||TO_CHAR(jefes.nextval),'Alexis','Sisneros Vega','658449812','DE-01');
DROP SEQUENCE jefes;


/*-------------
 |  ARTICULO  |
 -------------- */
CREATE SEQUENCE articulos START WITH 1 INCREMENT BY 1;

INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-007','DE-04',32,45,'Disco duro HDD 1TB Toshiba',92,'Discos Duros');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-013','DE-04',38,50.15,'Disco duro SSD 240GB Samsung',15,'Discos Duros');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-012','DE-04',44,50,'Cooler master masterbox lite',3,'Torres');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-014','DE-04',30,42.76,'Disco duro HDD 4TB Western Digital',33,'Discos Duros');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-001','DE-04',137.86,190.99,'GTX 1050 TI ASUS',5,'Gráficas');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-006','DE-04',233.78,290.99,'RTX 2060 Zotac',1,'Gráficas');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-016','DE-06',0.70,1.20,'Café con leche',120,'Bebidas');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-016','DE-06',1.20,1.8,'Capuchino',84,'Bebidas');
INSERT INTO articulo VALUES('A-00'||TO_CHAR(articulos.nextval),'C-015','DE-05',0.5,1,'Botella de agua pequeña',200,'Bebidas');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-015','DE-05',1.20,2,'Kit-Kat',65,'Chucherias');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-018','DE-04',5.7,8.2,'Destornillador magnetizado Bosh',22,'Herramientas');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-018','DE-04',83.72,90.92,'Taladro Bosh',10,'Herramientas');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-018','DE-06',2.3,3.5,'Chipirones a la plancha',21,'Comida');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-020','DE-05',1,2.5,'Pollo a la plancha',50,'Comida');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'Local','DE-01',50,50,'Montaje ordenador',999,'Montaje');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'Local','DE-02',30,30,'Reparación odenador',999,'Reparación');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'Local','DE-02',30,30,'Limpiar virus',999,'Asistencia');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'Local','DE-01',30,30,'Cambiar pieza',999,'Asistencia');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-020','DE-05',0.40,1,'Bolígrago',852,'Papelería');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-002','DE-04',35,48,'Placa Base Mortar MSI',0,'Placas Bases');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-004','DE-04',105,140,'Intel i7 7700K',0,'Procesadores');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-001','DE-04',80,110.64,'ASUS Rog Strix',3,'Placas Bases');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-004','DE-04',105,140,'Intel i3 8100K',20,'Procesadores');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-005','DE-04',90,110,'Ryzen 5 1600X',45,'Procesadores');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-005','DE-04',270,309,'Ryzen 7 3700X',0,'Procesadores');
INSERT INTO articulo VALUES('A-0'||TO_CHAR(articulos.nextval),'C-005','DE-04',1005.74,1120,'Ryzen Threadripper 3955WX',72,'Procesadores');
DROP SEQUENCE articulos;


/*-------------
 |JEFE_EMPLEADO|
 -------------- */
CREATE SEQUENCE empleados START WITH 1 INCREMENT BY 1;

INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'1/1/2002',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'1/1/2002',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'14/3/2003',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'1/12/2003',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'16/11/2004',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'4/12/2004',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'25/5/2005',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'30/6/2005',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-00'||TO_CHAR(empleados.nextval),'3/9/2005',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'12/11/2005',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'18/1/2006',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'22/4/2006',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'22/4/2006',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'22/4/2007',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'3/5/2007',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'2/10/2007',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'20/12/2007',null);

INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'23/12/2007',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'23/3/2008',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'30/4/2008',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'12/2/2011',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'12/2/2011',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'22/4/2011',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'30/5/2011',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'3/1/2012',null);
INSERT INTO jefe_empleado VALUES('JE-02','E-0'||TO_CHAR(empleados.nextval),'1/4/2012',null);

INSERT INTO jefe_empleado VALUES('JE-03','E-0'||TO_CHAR(empleados.nextval),'12/4/2019',null);
INSERT INTO jefe_empleado VALUES('JE-03','E-0'||TO_CHAR(empleados.nextval),'19/6/2019',null);
INSERT INTO jefe_empleado VALUES('JE-03','E-0'||TO_CHAR(empleados.nextval),'27/8/2019',null);

INSERT INTO jefe_empleado VALUES('JE-06','E-0'||TO_CHAR(empleados.nextval),'14/5/2020',null);
INSERT INTO jefe_empleado VALUES('JE-06','E-0'||TO_CHAR(empleados.nextval),'15/5/2020',null);
INSERT INTO jefe_empleado VALUES('JE-06','E-0'||TO_CHAR(empleados.nextval),'22/7/2020',null);
INSERT INTO jefe_empleado VALUES('JE-06','E-0'||TO_CHAR(empleados.nextval),'26/9/2020',null);
INSERT INTO jefe_empleado VALUES('JE-06','E-0'||TO_CHAR(empleados.nextval),'22/10/2020',null);

INSERT INTO jefe_empleado VALUES('JE-07','E-0'||TO_CHAR(empleados.nextval),'12/2/2016',null);
INSERT INTO jefe_empleado VALUES('JE-07','E-0'||TO_CHAR(empleados.nextval),'22/7/2016','1/1/2017');
INSERT INTO jefe_empleado VALUES('JE-04','E-036','2/1/2017',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'14/8/2016',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'2/3/2017','4/5/2019');
INSERT INTO jefe_empleado VALUES('JE-07','E-038','5/5/2019','3/8/2020');
INSERT INTO jefe_empleado VALUES('JE-04','E-038','4/8/2020',null);
INSERT INTO jefe_empleado VALUES('JE-04','E-0'||TO_CHAR(empleados.nextval),'14/11/2018',null);
INSERT INTO jefe_empleado VALUES('JE-07','E-0'||TO_CHAR(empleados.nextval),'24/11/2018',null);

INSERT INTO jefe_empleado VALUES('JE-01','E-0'||TO_CHAR(empleados.nextval),'1/2/2019',null);
INSERT INTO jefe_empleado VALUES('JE-01','E-0'||TO_CHAR(empleados.nextval),'3/4/2019',null);
INSERT INTO jefe_empleado VALUES('JE-08','E-0'||TO_CHAR(empleados.nextval),'5/12/2019','3/2/2021');
INSERT INTO jefe_empleado VALUES('JE-01','E-045','4/2/2021',null);
INSERT INTO jefe_empleado VALUES('JE-08','E-0'||TO_CHAR(empleados.nextval),'4/11/2020',null);
INSERT INTO jefe_empleado VALUES('JE-08','E-0'||TO_CHAR(empleados.nextval),'23/11/2020',null);
INSERT INTO jefe_empleado VALUES('JE-01','E-0'||TO_CHAR(empleados.nextval),'1/1/2021','25/3/2021');  
INSERT INTO jefe_empleado VALUES('JE-08','E-047','26/3/2021',null);
INSERT INTO jefe_empleado VALUES('JE-01','E-0'||TO_CHAR(empleados.nextval),'3/2/2021',null);
INSERT INTO jefe_empleado VALUES('JE-08','E-0'||TO_CHAR(empleados.nextval),'20/4/2021',null);
DROP SEQUENCE empleados;

/*-------------
 |   PEDIDO   |
 -------------- */
 /*-----------------
 |FUNCIÓN ARTÍCULOS|
 ------------------- */

CREATE OR REPLACE FUNCTION calcula_precio(cod VARCHAR2, cantidad NUMBER) RETURN NUMBER IS
    v_precio NUMBER;
BEGIN
    v_precio:=0;
    SELECT precio_venta INTO v_precio FROM articulo WHERE cod_articulo=cod;
    v_precio:=v_precio*cantidad;
    RETURN v_precio;
END;
/
/*-------------
 | INSERCCIÓN |
 -------------- */
CREATE SEQUENCE pedidos START WITH 1 INCREMENT BY 1;

INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'84372347H','A-011','DE-04',3,'22/8/2010','28/8/2010',(SELECT calcula_precio('A-011',3) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'58340212S','A-020','DE-04',1,'3/4/2011','14/4/2011',(SELECT calcula_precio('A-020',1) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'84632218W','A-017','DE-02',1,'14/3/2013','15/3/2013',(SELECT calcula_precio('A-017',1) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'74830928L','A-003','DE-04',1,'1/6/2013','10/6/2013',(SELECT calcula_precio('A-003',1) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'48124785E','A-022','DE-04',1,'30/12/2014','10/1/2015',(SELECT calcula_precio('A-022',1) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'74712948K','A-024','DE-04',1,'29/7/2015','8/8/2015',(SELECT calcula_precio('A-024',1) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'85603123G','A-019','DE-05',12,'12/11/2015','12/11/2015',(SELECT calcula_precio('A-019',12) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'65893234T','A-007','DE-06',3,'5/1/2016','5/1/2016',(SELECT calcula_precio('A-007',3) from dual));
INSERT INTO pedido VALUES('E-0000000'||TO_CHAR(pedidos.nextval),'65893234T','A-013','DE-06',2,'5/1/2016','5/1/2016',(SELECT calcula_precio('A-013',2) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval), '65893234T','A-014','DE-05',1,'5/1/2016','5/1/2016',(SELECT calcula_precio('A-014',1) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'87567391F','A-016','DE-02',1,'22/4/2016','25/4/2016',(SELECT calcula_precio('A-016',1) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'48124785E','A-026','DE-04',1,'5/4/2021',null,(SELECT calcula_precio('A-026',1) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'65893234T','A-001','DE-04',2,'2/7/2018','12/7/2018',(SELECT calcula_precio('A-001',2) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'58340212S','A-025','DE-04',1,'31/8/2017','6/9/2017',(SELECT calcula_precio('A-025',1) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'74830928L','A-012','DE-04',1,'3/2/2021','15/2/2021',(SELECT calcula_precio('A-012',1) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'84372347H','A-015','DE-01',2,'23/11/2020','28/11/2020',(SELECT calcula_precio('A-015',2) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'84632218W','A-021','DE-04',1,'3/1/2019','30/1/2019',(SELECT calcula_precio('A-021',1) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'65893234T','A-018','DE-01',2,'15/2/2021','16/2/2021',(SELECT calcula_precio('A-018',2) from dual));
INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'65893234T','A-002','DE-04',4,'30/3/2021',null,(SELECT calcula_precio('A-002',4) from dual));
DROP SEQUENCE pedidos;

COMMIT;