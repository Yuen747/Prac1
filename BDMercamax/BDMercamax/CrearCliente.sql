CREATE PROCEDURE [dbo].[CrearCliente]
	@cc int,
	@nombre nvarchar,
	@telefono nvarchar,
	@email nvarchar,
	@direccion nvarchar,
	@fecha date
AS
	Insert into Cliente (cc_cliente, nombre_apellido_cliente, telefono_cliente, email_cliente, direccion_cliente, fecha_nacimiento, puntos_acumulados)  values (@cc, @nombre, @telefono, @email, @direccion, @fecha, 0) 
RETURN 0
