DECLARE @XMLJornada XML

--se cargan la data en bulk a los xml
SET @XMLJornada = (SELECT * FROM OPENROWSET(BULK 'C:\Users\josef\Desktop\xml\TipoJornadas.xml', SINGLE_BLOB) AS data)

--se prepara un handler y los prepare
DECLARE @handle INT  
DECLARE @PrepareXmlStatusAD INT

-- se realiza el handling de los xml
EXEC @PrepareXmlStatusAD = sp_xml_preparedocument @handle OUTPUT, @XMLJornada

--se insertan los valores de los xml dentro de las variables tabla
INSERT dbo.[Tipo Jornada](Id, Nombre,HoraEntrada, HoraSalida)
	SELECT id, nombre, HoraInicio, HoraFin
	FROM OPENXML(@handle, '/dataset/TipoJornadas') WITH (id int , nombre varchar(50), HoraInicio time(0), HoraFin time(0))
