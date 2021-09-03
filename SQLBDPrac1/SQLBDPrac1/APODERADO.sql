﻿CREATE TABLE [dbo].[APODERADO]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Nombre] VARCHAR(50) NOT NULL, 
    [Telefono] VARCHAR(50) NOT NULL, 
    [Id_Alumno] INT NOT NULL, 
    CONSTRAINT [FK_APODERADO_ALUMNO] FOREIGN KEY ([Id_Alumno]) REFERENCES [ALUMNO]([Id]))

