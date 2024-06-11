
SELECT * FROM  railway.HISTORIACLINICA;
SELECT * FROM  railway.VISITA;
SELECT * FROM  railway.PACIENTE;
SELECT * FROM  railway.MEDICO;



/* insert  pacientes  */ 


INSERT INTO `railway`.`PACIENTE` 
(`PACI_NOMBRE`, `PACI_APELLIDO`, `PACI_NIT`, `PACI_EMAIL`, `PACI_CELULAR`)
 VALUES ('RONAL DAVID', 'GIL HURTADO', 'CC15923478', 'rodagil9@yopmail.com', '3125965541');
 
 INSERT INTO `railway`.`PACIENTE` 
(`PACI_NOMBRE`, `PACI_APELLIDO`, `PACI_NIT`, `PACI_EMAIL`, `PACI_CELULAR`)
 VALUES ('JENNY', 'DIAZ', 'CC147852369', 'jenny@yopmail.com', '3125965541');
 
 INSERT INTO `railway`.`PACIENTE` 
(`PACI_NOMBRE`, `PACI_APELLIDO`, `PACI_NIT`, `PACI_EMAIL`, `PACI_CELULAR`)
 VALUES ('PEDRO', 'PINEDA', 'CC12548997', 'pedro@yopmail.com', '3125965541');
 
 INSERT INTO `railway`.`PACIENTE` 
(`PACI_NOMBRE`, `PACI_APELLIDO`, `PACI_NIT`, `PACI_EMAIL`, `PACI_CELULAR`)
 VALUES ('PAOLA ANDREA', 'BELTRAN', 'CC187', 'paola@yopmail.com', '3125965541');
 
 /* medico   */ 
 
 INSERT INTO `railway`.`MEDICO` (`MEDI_NOMBRE`, `MEDI_APELLIDO`, `MEDI_NIT`, `MEDI_EMAIL`, `MEDI_AREA`) VALUES ('EDILBERTO', 'LOPEZ', 'CC18974897', 'edilberto@yopmail.com', 'General');
 INSERT INTO `railway`.`MEDICO` (`MEDI_NOMBRE`, `MEDI_APELLIDO`, `MEDI_NIT`, `MEDI_EMAIL`, `MEDI_AREA`) VALUES ('JUAN', 'ARANGO', 'CC1569487', 'juan@yopmail.com', 'Neurologia');


/*
2. Cree un stored procedure que permita registrar una nueva visita de un 
paciente. El procedimiento debe recibir los siguientes parámetros: PacienteID, 
MedicoID, FechaVisita, Diagnostico, y Tratamiento. El procedimiento debe 
crear una nueva entrada en la tabla Visit

*/

DELIMITER  //
CREATE PROCEDURE insertar_visita 

(

in LV_PacienteID  BIGINT,
in LV_MedicoID    BIGINT,
IN LV_FechaVisita  TIMESTAMP,
IN LV_Diagnostico   VARCHAR(255),
IN LV_Tratamiento  VARCHAR(255)



)
begin 

INSERT INTO `railway`.`VISITA`  (`VIST_FECHAVISITA`, `VIST_DIAGNOSTICO`, `VIST_TRATAMIENTO`, `PACI_ID`, `MEDI_ID`)  
VALUES  (LV_FechaVisita, LV_Diagnostico, LV_Tratamiento , LV_PacienteID,  LV_MedicoID);

END;

//

DELIMITER ;


 CALL railway.insertar_visita(3/* LV_PacienteID*/,1,   /* LV_MedicoID*/   sysdate() ,  ' Migraña  ',' dolex  cada 12 horas durante 6 dias' ); 
 
/*
3.Cree un trigger que se dispare después de insertar un nuevo registro en la tabla 
Visita. El trigger debe actualizar la columna FechaUltimaVisita en la tabla 
HistoriaClinica con la fecha de la nueva visita. 
*/

INSERT INTO `railway`.`HISTORIACLINICA` (`HICL_OBSERVACION`, `HICL_MEDICAMENTO`, `VIST_ID`, `FECHAULTIMAVISITA`) VALUES ('dificultad al respirar', 'dolex', '1' /* paciente */, sysdate());
INSERT INTO `railway`.`HISTORIACLINICA` (`HICL_OBSERVACION`, `HICL_MEDICAMENTO`, `VIST_ID`, `FECHAULTIMAVISITA`) VALUES ('dificultad al respirar', 'dolex', '2'  /* paciente */, sysdate());

CREATE TRIGGER   VISITA_AFTER_INSERT
after  insert ON railway.VISITA 
for each  row
begin 
 
 UPDATE  RAILWAY.HISTORIACLINICA
 SET FECHAULTIMAVISITA =  sysdate()
  where  PACI_ID = new.PACI_ID;

END;


SHOW   TRIGGERS LIKE 'VISITA';
/*  consulta 
4. Escriba una consulta SQL que liste todos los pacientes y su última fecha de 
visita, ordenados por la fecha de la última visita en orden descendente. 

*/

SELECT  
  PACI_NOMBRE, PACI_APELLIDO, PACI_NIT, PACI_EMAIL, PACI_CELULAR  , VIST. VIST_FECHAVISITA
FROM 
 railway.VISITA  VIST ,
 railway.PACIENTE PACI,
 railway.MEDICO MEDI
 WHERE
 PACI.PACI_ID  =  VIST.PACI_ID
  AND  MEDI.MEDI_ID =   MEDI.MEDI_ID
	ORDER BY  VIST_FECHAVISITA DESC
; 






 
 
