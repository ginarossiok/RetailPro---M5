-- PRE-ENTREGA MÓDULO 4 - CONSULTAS SQL DE NEGOCIO
-- Extrayendo métricas clave con SQL

USE Ventas_Tech_DB;

-- CONSULTA 1 - RESUMEN EJECUTIVO MENSUAL
-- Total facturado, cantidad de pedidos y ticket promedio por mes

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- CONSULTA 2 - RANKING DE PRODUCTOS
-- Top 5 productos según facturación total

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


-- CONSULTA 3 - CLIENTES RECURRENTES
-- Clientes que realizaron más de un pedido

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


-- CONSULTA 4 - MESES POR ENCIMA / POR DEBAJO DEL PROMEDIO
-- Comparación de la facturación mensual con el promedio mensual
-- general

SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(total_mensual)
            FROM (
                SELECT
                    MONTH(fecha_venta) AS mes,
                    SUM(cantidad * precio_unitario) AS total_mensual
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS facturacion_mensual
        )
        THEN 'Por encima'

        WHEN total_facturado < (
            SELECT AVG(total_mensual)
            FROM (
                SELECT
                    MONTH(fecha_venta) AS mes,
                    SUM(cantidad * precio_unitario) AS total_mensual
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS facturacion_mensual
        )
        THEN 'Por debajo'

        ELSE 'Igual al promedio'

    END AS comparacion_promedio

FROM (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS resumen_mensual

ORDER BY mes;


-- HALLAZGOS:

-- 1. El producto 1 fue el de mayor facturación, generando $3.600,lo que representa aproximadamente el 55,9% de la facturación total.

-- 2. El cliente 1 fue el cliente recurrente con mayor gasto acumulado,con un total de $2.640 distribuido en 2 pedidos.

-- 3. La facturación total del período fue de $6.444, con 10 pedidos y un ticket promedio de $644,40.