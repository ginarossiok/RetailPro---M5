# RetailPro - Proyecto de Data Analytics

**Autora:** Gina Rossi

## Descripción del proyecto

RetailPro es un proyecto académico de análisis de datos orientado a una empresa de retail tecnológico. Su objetivo es organizar la información comercial en una base de datos relacional y obtener métricas sobre ventas, productos y clientes para apoyar la toma de decisiones.

Este repositorio reúne el trabajo de los módulos 3, 4 y 5: creación de la base de datos, consultas de negocio e integración de tablas mediante SQL.

## Herramientas utilizadas

- **SQL Server Express:** gestión de la base de datos.
- **SQL Server Management Studio (SSMS):** ejecución de scripts y revisión de resultados.
- **GitHub:** almacenamiento de archivos y documentación.
- **ChatGPT:** asistencia para revisar consultas SQL, interpretar resultados y mejorar la documentación, evaluando críticamente sus sugerencias.

## Base de datos y modelo relacional

La base de datos se llama `Ventas_Tech_DB` y contiene cuatro tablas:

| Tabla | Clave primaria | Relación |
| --- | --- | --- |
| `categorias` | `id_categoria` | Una categoría puede tener varios productos. |
| `clientes` | `id_cliente` | Un cliente puede tener varios registros de venta. |
| `productos` | `id_producto` | Se relaciona con `categorias` mediante `id_categoria`. |
| `ventas` | `id_venta` | Se relaciona con `clientes` y `productos`. |

Las claves primarias y foráneas mantienen la integridad referencial.

Cada fila de `ventas` registra un producto vendido a un cliente, indicando cantidad, precio unitario y fecha. El modelo no incluye un identificador de pedido que agrupe varios productos.

Por ese motivo:

- `COUNT(*)` cuenta registros de venta.
- `AVG(cantidad * precio_unitario)` calcula el importe promedio por registro.

## Contenido del repositorio

### Módulo 3 - Creación y carga de la base

El script de M3 incluye:

- Creación de `Ventas_Tech_DB`.
- Definición de tablas mediante sentencias DDL.
- Definición de claves primarias y foráneas.
- Carga de datos mediante sentencias DML.
- Consultas de validación y conteo de registros.

### Módulo 4 - Consultas de negocio

El archivo `m4_consultas_negocio.sql` contiene:

1. Resumen mensual de facturación, cantidad de registros e importe promedio.
2. Top 5 de productos por facturación, con unidades vendidas.
3. Clientes con más de un registro de venta y su gasto acumulado.
4. Comparación de la facturación mensual con el promedio de los meses disponibles mediante `CASE`.

La facturación se calcula como:

    cantidad * precio_unitario

Se utiliza el precio registrado en cada venta para conservar el importe histórico de la operación.

### Módulo 5 - Consultas con JOIN y UNION ALL

El archivo `m5_consultas_joins.sql` contiene:

1. **Consulta base:** integra `ventas`, `clientes`, `productos` y `categorias` mediante `INNER JOIN`.
2. **Clientes sin ventas:** utiliza `LEFT JOIN` y `WHERE v.id_venta IS NULL`.
3. **Productos sin ventas:** utiliza `LEFT JOIN` con ventas e incorpora la categoría del producto mediante `INNER JOIN`.
4. **Consolidación por período:** combina mediante `UNION ALL` las ventas del 5 al 10 y del 11 al 15 de marzo de 2024.

La consulta base es una sentencia `SELECT`; el script no crea una vista mediante `CREATE VIEW`.

En la consolidación, la columna literal denominada `canal` identifica períodos. No representa un canal comercial real, porque la base no contiene ese atributo.

## Cómo ejecutar los scripts SQL

### Requisitos

- SQL Server Express instalado y una instancia en ejecución.
- SQL Server Management Studio (SSMS).
- Permisos para crear la base de datos y sus tablas.
- Scripts descargados del repositorio.

### Primera ejecución

1. Abrir SSMS y conectarse a la instancia de SQL Server.
2. Abrir el script de creación y carga de M3.
3. Seleccionar y ejecutar primero únicamente:

       CREATE DATABASE Ventas_Tech_DB;

4. Ejecutar el resto del script desde:

       USE Ventas_Tech_DB;

   Esto crea las tablas, carga los datos y ejecuta las validaciones.

5. Abrir y ejecutar `m4_consultas_negocio.sql`.
6. Abrir y ejecutar `m5_consultas_joins.sql`.
7. Revisar la pestaña de mensajes y las cuadrículas de resultados.

### Si la base ya existe

Para consultar los datos existentes, ejecutar directamente los scripts de M4 y M5.

No volver a ejecutar `CREATE DATABASE`.

El script de M3 contiene `DROP TABLE IF EXISTS`, por lo que su sección de recreación elimina las tablas y sus datos antes de volver a cargar la muestra. Ejecutarla únicamente cuando se quiera reinicializar la base de práctica.

## Validación de los datos

La versión del script de M3 revisada contiene:

| Tabla | Cantidad de registros |
| --- | ---: |
| `categorias` | 4 |
| `clientes` | 5 |
| `productos` | 6 |
| `ventas` | 10 |

Las ventas corresponden al período del **5 al 15 de marzo de 2024**.

Los conteos pueden verificarse mediante las consultas `COUNT(*)` incluidas al final del script de M3.

En esta muestra, todos los clientes y productos tienen ventas. Por lo tanto, las consultas que buscan clientes y productos sin ventas devuelven cero filas.

Si se agregan registros sin ventas para probar los `LEFT JOIN`, deben actualizarse los conteos esperados.

## Principales resultados

| Indicador | Resultado |
| --- | ---: |
| Facturación total | $6.444,00 |
| Registros de venta | 10 |
| Importe promedio por registro | $644,40 |
| Facturación de Laptop Pro 15 | $3.600,00 |
| Participación de Laptop Pro 15 | 55,9 % |
| Gasto acumulado de María López | $2.640,00 en 2 registros |

Los importes se muestran con el símbolo `$`; el script no especifica la moneda.

Durante la revisión con IA, estos resultados se recalcularon a partir de los datos incluidos en las sentencias `INSERT`, sin ejecutar SQL Server.

## Alcance y limitaciones del análisis

- La muestra contiene ventas de una parte de marzo de 2024. No permite inferir crecimiento ni estacionalidad.
- Marzo aparece como “Igual al promedio” porque es el único mes disponible.
- Las consultas agrupan por `MONTH(fecha_venta)`. Si se incorporan varios años, debe agregarse el año a la agrupación para evitar mezclar períodos.
- La facturación no equivale a rentabilidad: no se dispone de costos ni márgenes.
- Los registros de venta no permiten identificar pedidos con varios productos ni analizar canastas de compra.
- Las acciones comerciales propuestas deben validarse con más información antes de aplicarse.

## Uso de IA en el proyecto

Se utilizó ChatGPT como apoyo para revisar la consulta base de M5, interpretar resultados de M4 y preparar la documentación.

En la revisión SQL se evaluó eliminar `ORDER BY` cuando la extracción no requiera datos ordenados. Para la revisión cronológica de las ventas se decidió conservarlo. No se afirmó una mejora de rendimiento medida.

La documentación se ajustó para distinguir registros de venta de pedidos, períodos de canales comerciales y resultados observados de propuestas que requieren validación.

## Próximas etapas

- Ampliar y validar el conjunto de datos.
- Adaptar las consultas temporales si se incorporan nuevos años.
- Conectar la información con Power BI.
- Construir visualizaciones y dashboards para el análisis comercial.
