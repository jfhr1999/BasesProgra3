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
declare @lo1 int, @hi1 int, @lo2 int, @hi2 int, @FechaOp date, @fot time(7), @fit time(7), @sot time(7), @sit time(7), @idP int, @salario money, @idEmp int, @valDeduc money, @idDeduc int

DECLARE @asistOP table(sec int identity(1,1),idOP int,idEmpOP int, idtipojornada int, horaEntrada time(7), horaSalida time(7))

--asigno las variables para el ciclo de fechas
select @lo1 = min(F.sec), @hi1 = max(F.sec)
from @Fechas F

--inicio el ciclo de fechas
while @lo1 < @hi1
begin
	

	select @FechaOp = F.fecha
	from @Fechas F
	where F.sec = @lo1

	--inserto los Empleados
	begin transaction
		insert into dbo.Empleado(nombre,DocId,IdPuesto)
		select TC.nombre, TC.valorDocId, TC.puesto from @empleados TC
		where TC.fechaIn = @FechaOp
	commit

	insert into dbo.[Planilla Mensual](idEmpleado,fecha, SalarioBruto, SalarioNeto)
	select e.id, @FechaOp, 0,0 from dbo.Empleado e inner join @empleados as ee on e.DocId = ee.valorDocId and ee.fechain = @FechaOp

	insert into dbo.[Planilla Semanal](IdEmpleado,IdPlanillaMensual,SalarioBruto,SalarioNeto)
	select pm.idEmpleado, pm.id, 0,0 from dbo.[Planilla Mensual] pm where pm.Fecha = @FechaOp

	insert into dbo.Asistencia(IdEmpleado, IdTipoJornada, Fecha, HoraEntrada, HoraSalida, Incapacidad)
	select e.Id, a.idTipoJornada, @FechaOp, a.horaEntrada, a.horaSalida, 0 from @asist a inner join Empleado as e on a.docId = e.DocId 
	where a.fechain = @FechaOp

	insert into @asistOP(idOP,idEmpOP,idtipojornada,horaEntrada, horaSalida)
	select * from dbo.Asistencia 
	where Asistencia.Fecha = @FechaOp and Asistencia.Incapacidad = 0

	select @lo2 = min(aop.sec), @hi2 = max(aop.sec)
	from @asistOP aop

	while @lo2 < @hi2
	begin
		select @sot = tj.horaSalida, @sit = tj.horaEntrada from [Tipo Jornada] tj inner join @asistOP as att on att.IdTipoJornada = tj.Id
		where att.sec = @lo2

		select @fot = asi.horaSalida, @fit = asi.horaEntrada from  @asistOP asi
		where asi.sec = @lo2

		select @idP = E.idPuesto from Empleado E inner join @asistOP as A on e.Id = A.idEmpOP
		where A.sec = @lo2

		select @idEmp = A.idEmpOp from @asistOP A
		where A.sec = @lo2

		select @salario = PJ.SalarioxHoras from [Puesto x Tipo Jornada] PJ inner join @asistOP as assi on pj.IdTipoJornada = assi.IdTipoJornada where @idP = Pj.IdPuesto and  assi.sec = @lo2

			if datepart(hour,@fot) = datepart(hour, @sot) and datepart(hour, @fit) = datepart(hour, @sit)
				begin transaction
					insert into [Movimiento Horas Trabajadas](IdAsistencia, IdTipoMovimiento, tipoJornada, cantidadHoras)
					select a.IdOP, 1, a.idTipojornada, 8 from @asistOP a inner join Empleado as e on a.idEmpOP = e.Id
					where a.sec = @lo2

					insert into [Movimiento Planilla](IdPlanillaSemanal,IdTipoMovimiento, Fecha, monto)
					select	PS.id,1,@FechaOp,@salario from [Planilla Semanal] PS inner join @asistOP as ASs on Ps.IdEmpleado = ASs.idEmpOP
					where ASs.sec = @lo2

					update [Planilla Semanal]
					set SalarioBruto = SalarioBruto + @salario
					where IdEmpleado = @idEmp
				commit

			set @lo2 = @lo2 + 1
	end

	delete @asistOP

	insert into dbo.Asistencia(IdEmpleado, IdTipoJornada, Fecha, HoraEntrada, HoraSalida, Incapacidad)
	select e.Id, a.idTipoJornada, @FechaOp, '0:00', '0:00', 1 from @incapacidad a inner join Empleado as e on a.docId = e.DocId 
	where a.fechain = @FechaOp


	insert into @asistOP(idOP,idEmpOP,idtipojornada,horaEntrada, horaSalida)
	select * from dbo.Asistencia 
	where Asistencia.Fecha = @FechaOp and Asistencia.Incapacidad = 1

	select @lo2 = min(aop.sec), @hi2 = max(aop.sec)
	from @asistOP aop

	while @lo2 < @hi2
	begin
		select @sot = tj.horaSalida, @sit = tj.horaEntrada from [Tipo Jornada] tj inner join @asistOP as att on att.IdTipoJornada = tj.Id
		where att.sec = @lo2

		select @fot = asi.horaSalida, @fit = asi.horaEntrada from  @asistOP asi
		where asi.sec = @lo2

		select @idP = E.idPuesto from Empleado E inner join @asistOP as A on e.Id = A.idEmpOP
		where A.sec = @lo2

		select @idEmp = A.idEmpOp from @asistOP A
		where A.sec = @lo2

		select @salario = PJ.SalarioxHoras from [Puesto x Tipo Jornada] PJ inner join @asistOP as assi on pj.IdTipoJornada = assi.IdTipoJornada where @idP = Pj.IdPuesto and  assi.sec = @lo2

			if datepart(hour,@fot) = datepart(hour, @sot) and datepart(hour, @fit) = datepart(hour, @sit)
				begin transaction
					insert into [Movimiento Horas Trabajadas](IdAsistencia, IdTipoMovimiento, tipoJornada, cantidadHoras)
					select a.IdOP, 3, a.idTipojornada, 8 from @asistOP a inner join Empleado as e on a.idEmpOP = e.Id
					where a.sec = @lo2

					insert into [Movimiento Planilla](IdPlanillaSemanal,IdTipoMovimiento, Fecha, monto)
					select	PS.id,3,@FechaOp,(@salario * 0.60) from [Planilla Semanal] PS inner join @asistOP as ASs on Ps.IdEmpleado = ASs.idEmpOP
					where ASs.sec = @lo2

					update [Planilla Semanal]
					set SalarioBruto = SalarioBruto + (@salario * 0.60)
					where IdEmpleado = @idEmp
				commit

			set @lo2 = @lo2 + 1
	end

	delete @asistOP

	insert into dbo.[Deducciones x Empleado](IdEmpleado,IdTipoDeduccion,Valor)
	select e.Id, d.idTipoDeduccion, d.valor from @deduc d inner join Empleado as e on d.DocId = e.DocId
	where d.fechaMov = @FechaOp

	

	
	set @lo1 = @lo1 + 1
	end

