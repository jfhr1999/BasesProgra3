DECLARE @XMLSalarioxHora XML

--se cargan la data en bulk a los xml
SET @XMLSalarioxHora = (SELECT * FROM OPENROWSET(BULK 'C:\Users\josef\Desktop\xml\SalarioxHora.xml', SINGLE_BLOB) AS data)

--se prepara un handler y los prepare
DECLARE @handle INT  
DECLARE @PrepareXmlStatusAD INT

-- se realiza el handling de los xml
EXEC @PrepareXmlStatusAD = sp_xml_preparedocument @handle OUTPUT, @XMLSalarioxHora 

--se insertan los valores de los xml dentro de las variables tabla
INSERT dbo.[Puesto x Tipo Jornada](id, IdTipoJornada, IdPuesto, SalarioxHoras)
	SELECT id, idTipoJornada, idPuesto, valorHora
	FROM OPENXML(@handle, '/dataset/SalarioxHora') WITH (id int,idPuesto int, idTipoJornada int, valorHora money)
