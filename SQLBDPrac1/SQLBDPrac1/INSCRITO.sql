﻿CREATE TABLE [dbo].[INSCRITO]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Id_Alumno] INT NOT NULL, 
    [Cod_Curso] INT NOT NULL, 
    CONSTRAINT [FK_INSCRITO_ALUMNO] FOREIGN KEY ([Id_Alumno]) REFERENCES [INSCRITO]([Id])
)
