--4.2 Sentencia de consulta
--Observación: Realice la exploración básica de los datos, conteos totales y por categorías, máximos, 
--promedio y mínimos. Es decir, aplique estadística descriptiva con el fin de conocer las propiedades 
--de los datos y entenderlos lo mejor posible. 
--Use solamente sentencias SQL. Anexe las tomas de pantalla donde evidencie la sentencia SQL y su 
--correspondiente ejecución. 
--Además, Almacene en el repositorio (REPO EN GITHUB) el script con el nombre de T1.4.2.Consultar_Datos.sql


--Valor promedio para cada contaminante

db.Medicion.aggregate(
    [
        {$group: {
            _id: "$Item_Code",
            Promedio: {$avg: "$Average_Value"}
            }
        },
        {$sort: {Promedio: -1}}
    ]
)


--Valor máximo para cada contaminante

db.Medicion.aggregate(
    [
        {$group: {
            _id: "$Item_Code",
            Máximo: {$max: "$Average_Value"}
            }
        },
        {$sort: {Máximo: -1}}
    ]
)


--Valor mínimo para cada contaminante

db.Medicion.aggregate(
    [
        {$group: {
            _id: "$Item_Code",
            Mínimo: {$min: "$Average_Value"}
            }
        },
        {$sort: {Mínimo: -1}}
    ]
)


--Número de contaminantes reportados
db.Medicion.aggregate(
    [
        {$group: {_id: {Contaminantes: "$Item_Code"}}},
        {$count: "Contaminantes"}
    ]
)


--Número de estaciones reportadas
db.Medicion.aggregate(
    [
        {$group: {_id: {Estaciones: "$Station_Name"}}},
        {$count: "Estaciones"}
    ]
)


--Valor promedio, mínimo y máximo general para cada estación

db.Medicion.aggregate(
    [
        {$group: {
            _id: "$Station_Name",
            Promedio: {$avg: "$Average_Value"},
            Mínimo: {$min: "$Average_Value"},
            Máximo: {$max: "$Average_Value"}
            }
        }
    ]
)


--Valor promedio y máximo general por contaminante para la estación Jongno-gu 

db.Medicion.aggregate(
    [
        {$match: {Station_Name: {$in: ["Jongno-gu"]}}},
        {$group: {
            _id: "$Item_Code",
            Promedio: {$avg: "$Average_Value"},
            Máximo: {$max: "$Average_Value"}
            }
        }
    ]
)


--Cuenta de contaminantes en el rango de Bueno (Good) en la estación Yangcheon-gu

db.Medicion.aggregate(
    [
        {$match: {Station_Name: {$in: ["Yangcheon-gu"]}, Pollutant_Status: {$in: ["Good"]}}},
        {$group: {_id: {Contaminante: "$Item_Code"}}},
        {$count: "Contaminante"}
    ]
)



