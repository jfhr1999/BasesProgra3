DECLARE @XMLTDedu XML

--se cargan la data en bulk a los xml
SET @XMLTDedu = (SELECT * FROM OPENROWSET(BULK 'C:\Users\josef\Desktop\xml\TipoDeduccion.xml', SINGLE_BLOB) AS data)

--se prepara un handler y los prepare
DECLARE @handle INT  
DECLARE @PrepareXmlStatusAD INT

-- se realiza el handling de los xml
EXEC @PrepareXmlStatusAD = sp_xml_preparedocument @handle OUTPUT, @XMLTDedu 

--se insertan los valores de los xml dentro de las variables tabla
INSERT dbo.[Tipo Deduccion](id, nombre)
	SELECT id, Nombre
	FROM OPENXML(@handle, '/dataset/TipoDeduccion') WITH (id int, nombre varchar(50))

