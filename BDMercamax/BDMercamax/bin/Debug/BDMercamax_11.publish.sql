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
/*
Se está quitando la columna [dbo].[LugarStock].[id_lugar]; puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[LugarStock])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Clave principal restricción sin nombre en [dbo].[LugarStock]...';


GO
ALTER TABLE [dbo].[LugarStock] DROP CONSTRAINT [PK__LugarSto__B172B1F8E6401FE9];


GO
PRINT N'Modificando Tabla [dbo].[LugarStock]...';


GO
ALTER TABLE [dbo].[LugarStock] DROP COLUMN [id_lugar];


GO
PRINT N'Actualizando Procedimiento [dbo].[VerProductoBodega]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[VerProductoBodega]';


GO
PRINT N'Actualizando Procedimiento [dbo].[VerProductoGondola]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[VerProductoGondola]';


GO
PRINT N'Actualización completada.';


GO
