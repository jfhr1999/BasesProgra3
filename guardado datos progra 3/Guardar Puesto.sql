DECLARE @XMLPuesto XML

--se cargan la data en bulk a los xml
SET @XMLPuesto = (SELECT * FROM OPENROWSET(BULK 'C:\Users\josef\Desktop\xml\Puesto.xml', SINGLE_BLOB) AS data)

--se prepara un handler y los prepare
DECLARE @handle INT  
DECLARE @PrepareXmlStatusAD INT

-- se realiza el handling de los xml
EXEC @PrepareXmlStatusAD = sp_xml_preparedocument @handle OUTPUT, @XMLPuesto 

--se insertan los valores de los xml dentro de las variables tabla
INSERT dbo.Puesto(id, nombre)
	SELECT id, nombre
	FROM OPENXML(@handle, '/dataset/Puesto') WITH (id int, nombre varchar(50))

