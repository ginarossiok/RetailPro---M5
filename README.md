# RetailPro – Proyecto de Data Analytics

## Descripción del proyecto

RetailPro es un proyecto de análisis de datos orientado a una empresa de retail tecnológico. El objetivo es construir una base de datos relacional que permita organizar la información comercial y obtener métricas relevantes para la toma de decisiones.

A lo largo del proyecto se desarrollan las distintas etapas del proceso de análisis de datos, desde el diseño del modelo y la creación de la base de datos hasta la extracción de información mediante SQL y su posterior visualización.

---

## Base de datos

La base de datos utilizada en el proyecto es:

`Ventas_Tech_DB`

El modelo contiene las siguientes tablas:

* `categorias`
* `clientes`
* `productos`
* `ventas`

Estas tablas se relacionan mediante claves primarias y foráneas para mantener la integridad referencial de la información.

---

## Módulo 3 – Creación de la base de datos

En esta etapa se desarrolló el script SQL encargado de crear y poblar la base de datos.

El archivo incluye:

* Creación de la base de datos `Ventas_Tech_DB`.
* Definición de las tablas mediante sentencias DDL.
* Definición de claves primarias y foráneas.
* Carga inicial de datos mediante sentencias DML.
* Inclusión de registros de ejemplo sin ventas para validar consultas con `LEFT JOIN`.
* Consultas de validación de la información.

---

## Módulo 4 – Consultas SQL de negocio

En el archivo `m4_consultas_negocio.sql` se desarrollaron consultas orientadas a responder preguntas de negocio a partir de la tabla `ventas`.

### Consulta 1 – Resumen ejecutivo mensual

Calcula por mes:

* Total facturado.
* Cantidad de pedidos.
* Ticket promedio.

La facturación de cada venta se obtiene mediante:

`cantidad * precio_unitario`

### Consulta 2 – Ranking de productos

Obtiene el Top 5 de productos según su facturación total, mostrando:

* ID del producto.
* Unidades vendidas.
* Total facturado.

### Consulta 3 – Clientes recurrentes

Identifica los clientes que realizaron más de un pedido y muestra:

* ID del cliente.
* Cantidad de pedidos.
* Total gastado.

### Consulta 4 – Comparación con el promedio mensual

Calcula la facturación de cada mes y la compara con el promedio mensual general mediante `CASE WHEN`, permitiendo identificar el desempeño de cada período respecto del promedio.

---

## Módulo 5 – Consultas con JOINs

En el archivo `m5_consultas_joins.sql` se desarrollaron consultas para cruzar las tablas del modelo relacional y enriquecer el análisis de negocio.

### Consulta 1 – Vista base del proyecto

Combina mediante `INNER JOIN` las tablas `ventas`, `clientes`, `productos` y `categorias` para obtener una vista única con información descriptiva de cada operación.

La consulta incluye, entre otros datos:

* Fecha de la venta.
* Identificación y nombre del cliente.
* Email y ciudad.
* Identificación y nombre del producto.
* Categoría del producto.
* Cantidad.
* Precio unitario.
* Total de venta.

Esta vista funcionará como fuente principal de datos para el posterior análisis en Power BI.

### Consulta 2 – Clientes sin ventas

Utiliza `LEFT JOIN` y `WHERE ... IS NULL` para identificar clientes registrados que todavía no realizaron ninguna compra.

Muestra:

* Nombre del cliente.
* Email.
* Fecha de registro.

### Consulta 3 – Productos sin ventas

Utiliza `LEFT JOIN` y `WHERE ... IS NULL` para identificar productos del catálogo que no poseen ventas registradas.

Muestra:

* Nombre del producto.
* Categoría.
* Precio.

### Consulta 4 – Consolidado por origen

Utiliza `UNION ALL` para consolidar las ventas de dos períodos diferentes. En cada `SELECT` se crea una columna de texto fija denominada `canal`, que identifica el período de origen.

Luego se agrupan los resultados para obtener la facturación total correspondiente a cada origen.


---

## Principales hallazgos

A partir de las consultas realizadas se obtuvieron los siguientes resultados:

1. El producto 1 fue el de mayor facturación, generando **$3.600**, aproximadamente el **55,9 % de la facturación total**.

2. El cliente 1 fue el cliente recurrente con mayor gasto acumulado, con un total de **$2.640** distribuido en **2 pedidos**.

3. La facturación total del período fue de **$6.444**, correspondiente a **10 pedidos**, con un ticket promedio de **$644,40**.


---

## Próximas etapas

En los siguientes módulos se continuará ampliando el proyecto a partir de la vista enriquecida construida mediante `JOIN`, avanzando hacia la conexión de los datos con Power BI y la construcción de visualizaciones y dashboards.

