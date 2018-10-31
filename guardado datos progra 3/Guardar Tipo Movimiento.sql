DECLARE @XMLTMov XML

--se cargan la data en bulk a los xml
SET @XMLTMov = (SELECT * FROM OPENROWSET(BULK 'C:\Users\josef\Desktop\xml\TipoMovimiento.xml', SINGLE_BLOB) AS data)

--se prepara un handler y los prepare
DECLARE @handle INT  
DECLARE @PrepareXmlStatusAD INT

-- se realiza el handling de los xml
EXEC @PrepareXmlStatusAD = sp_xml_preparedocument @handle OUTPUT, @XMLTMov

--se insertan los valores de los xml dentro de las variables tabla
INSERT dbo.[Tipo Movimiento Planilla](Id, Nombre)
	SELECT id, nombre
	FROM OPENXML(@handle, '/dataset/TipoMovimiento') WITH (id int , nombre varchar(50))

