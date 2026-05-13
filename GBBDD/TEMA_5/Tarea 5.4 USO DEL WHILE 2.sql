-- Tarea 5.4 Diego Rodríguez Martínez
-- Creamos tabla para las estanterías y le metemos las 10 que pide el enunciado
SELECT * FROM ArticulosAlmacen
CREATE TABLE Estanterias (
id int IDENTITY (1,1) PRIMARY KEY,
huecos_total int,
huecos_libres int,
articulo varchar(50)
)
-- Esto x10
INSERT INTO Estanterias
VALUES (10, 10, 'Portátiles')

-- ??? Fumando un poco
ALTER TABLE Productos
ADD stock_almacenado int CHECK (stock_almacenado >=0), stock_sin_almacenar int CHECK (stock_sin_almacenar >=0)
UPDATE Productos
SET stock_sin_almacenar = stock
UPDATE Productos
SET stock_almacenado = 0


-- Y ahora lo chungo
DECLARE @id_estanteria int
DECLARE @id_articulo int

WHILE (1=1)
BEGIN
-- Aqui lo cambiamos según el articulo que vamos a meter
SET @id_articulo = 1

SET @id_estanteria = (
SELECT TOP 1 id
FROM Estanterias
WHERE huecos_libres > 0
ORDER BY id ASC)

--Cuando no haya ninguna estantería libre, paramos el bucle
-- Falta un break para cuando tengamos más huecos que stock sin almacenar
IF @id_estanteria IS NULL BREAK 
IF (SELECT stock_sin_almacenar FROM Productos WHERE id=@id_articulo) = 0 BREAK
-- updateamos el stock en productos
UPDATE Productos
SET stock_sin_almacenar = stock_sin_almacenar - 1
WHERE id = @id_articulo
UPDATE Productos
SET stock_almacenado = stock_almacenado + 1
WHERE id = @id_articulo
-- updateamos la estanteria en la que estamos
UPDATE Estanterias
SET huecos_libres = huecos_libres - 1
WHERE id = @id_estanteria

-- La fecha no tengo claro como registrarla, si con un print es suficiente por cada vez que se ejecuta ahi está
PRINT 'Se ha metido un producto con ID = '+CAST(@id_articulo as varchar)+' en la estantería con ID ='+CAST(@id_estanteria as varchar)+' a las '+CAST(CURRENT_TIMESTAMP as varchar)

END
