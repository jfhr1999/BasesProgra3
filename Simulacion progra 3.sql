SET LANGUAGE Spanish 



DECLARE @XML XML
SELECT @XML = OP
FROM OPENROWSET(BULK 'C:\Users\josef\Desktop\xml\FechaOperacion V2.xml', SINGLE_BLOB) AS Operaciones(OP)

DECLARE @handler int
EXEC sp_xml_preparedocument @handler OUTPUT, @XML


DECLARE @Fechas table (sec int identity(0,1),Fecha date)
DECLARE @empleados table(nombre varchar(50), valorDocId varchar(50), puesto int, fechain date)
DECLARE @asist table(docId varchar(50), idtipojornada int, horaEntrada time(7), horaSalida time(7), fechain date)
DECLARE @incapacidad table(docId varchar(50), idtipojornada int, fechain date)
Declare @deduc table (DocId varchar(50), idTipoDeduccion int, Valor money,fechaMov date)


SELECT *
INTO fechasCrear
FROM OPENXML (@handler,'dataset/FechaOperacion',1)
WITH (Fecha date)

INSERT INTO @Fechas(Fecha)
SELECT * FROM fechasCrear


SELECT *
INTO clientesCrear
FROM OPENXML (@handler,'dataset/FechaOperacion/NuevoEmpleado',1)
WITH (nombre varchar(50), DocId varchar(50), idPuesto int, fecha date '../@Fecha')

INSERT INTO @empleados (nombre,valorDocId,puesto,fechaIn)
SELECT * FROM clientesCrear


SELECT *
INTO cuentasCrear
FROM OPENXML (@handler,'dataset/FechaOperacion/Asistencia',1)
WITH (DocId varchar(50), idTipoJornada int, HoraEntrada time (7) ,HoraSalida time(7), fechaCuenta date '../@Fecha')

INSERT INTO @asist (docId, idtipojornada, horaEntrada,	horaSalida, fechain)
SELECT * FROM cuentasCrear


SELECT *
INTO cuentasCrear2
FROM OPENXML (@handler,'dataset/FechaOperacion/Incapacidad',1)
WITH (DocId varchar(50), idTipoJornada int, fechaCuenta date '../@Fecha')

INSERT INTO @incapacidad (docId, idtipojornada, fechain)
SELECT * FROM cuentasCrear2


SELECT *
INTO cuentasCrear3
FROM OPENXML (@handler,'dataset/FechaOperacion/NuevaDeduccion',1)
WITH (DocId varchar(50), idTipoDeduccion int, Valor money, fechaCuenta date '../@Fecha')

INSERT INTO @deduc (docId, idTipoDeduccion, Valor, fechaMov)
SELECT * FROM cuentasCrear3

EXEC sp_xml_removedocument @handler

DROP TABLE fechasCrear
DROP TABLE clientesCrear
DROP TABLE cuentasCrear
DROP TABLE cuentasCrear2
DROP TABLE cuentasCrear3

--declaro variables que son vitales para la simulacion y otras variables que son constantes, así como tablas para preprocesar
declare @lo1 int, @hi1 int, @FechaOp date

--asigno las variables para el ciclo de fechas
select @lo1 = min(F.sec), @hi1 = max(F.sec)
from @Fechas F

--inicio el ciclo de fechas
while @lo1 < @hi1
begin
	--limpiar las tablas diarias
	

	select @FechaOp = F.fecha
	from @Fechas F
	where F.sec = @lo1

	--inserto los Empleados
	begin transaction
		insert into dbo.Empleado(nombre,DocId,IdPuesto)
		select TC.nombre, TC.valorDocId, TC.puesto from @empleados TC
		where TC.fechaIn = @FechaOp

		insert into dbo.Asistencia(IdEmpleado, IdTipoJornada, Fecha, HoraEntrada, HoraSalida, Incapacidad)
		select e.Id, a.idTipoJornada, @FechaOp, a.horaEntrada, a.horaSalida, 0 from @asist a inner join Empleado as e on a.docId = e.DocId 
		where a.fechain = @FechaOp

		insert into dbo.Asistencia(IdEmpleado, IdTipoJornada, Fecha, HoraEntrada, HoraSalida, Incapacidad)
		select e.Id, a.idTipoJornada, @FechaOp, '0:00', '0:00', 1 from @incapacidad a inner join Empleado as e on a.docId = e.DocId 
		where a.fechain = @FechaOp

		insert into dbo.[Deducciones x Empleado](IdEmpleado,IdTipoDeduccion,Valor)
		select e.Id, d.idTipoDeduccion, d.valor from @deduc d inner join Empleado as e on d.DocId = e.DocId
		where d.fechaMov = @FechaOp
	commit

	
	set @lo1 = @lo1 + 1
	end

