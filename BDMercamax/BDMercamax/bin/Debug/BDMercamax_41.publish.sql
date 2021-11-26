/*
Script de implementación para BDMercamax

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDMercamax"
:setvar DefaultFilePrefix "BDMercamax"
:setvar DefaultDataPath "C:\Users\nayib\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\nayib\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creando Procedimiento [dbo].[ComprarBodega]...';


GO
CREATE PROCEDURE [dbo].[ComprarBodega]
	@codigo int,
	@n int
AS
	UPDATE LugarStock SET cantidad_bodega = cantidad_bodega+@n WHERE barcode_producto = @codigo
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[CrearVenta]...';


GO
CREATE PROCEDURE [dbo].[CrearVenta]
	@id int,
	@n int,
	@factura int
AS
	Insert into Venta (barcode_producto, cantidad, id_factura) values ((SELECT barcode from Producto WHERE id_producto = @id), @n, @factura)
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[GetFacturas]...';


GO
CREATE PROCEDURE [dbo].[GetFacturas]
	@id int
AS
	SELECT id_factura, monto_total, monto_iva, fecha FROM Facturacion WHERE cc_cliente = @id
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[GetInfoCompra]...';


GO
CREATE PROCEDURE [dbo].[GetInfoCompra]
	@codigo int
AS
	SELECT agente_ventas, telefono_proveedor FROM Proveedor WHERE nit = (SELECT nit FROM Producto WHERE Producto.barcode = @codigo)
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[MoverAgondola]...';


GO
CREATE PROCEDURE [dbo].[MoverAgondola]
	@codigo int,
	@n int
AS
	UPDATE LugarStock SET cantidad_gondola = cantidad_gondola+@n, cantidad_bodega = cantidad_bodega-@n WHERE barcode_producto = @codigo
RETURN 0
GO
PRINT N'Actualización completada.';


GO
