-- PRE-ENTREGA MÓDULO 5 - CONSULTAS CON JOINS

USE Ventas_Tech_DB;

-- CONSULTA 1 - VISTA BASE DEL PROYECTO (INNER JOIN)

SELECT
    v.id_venta,
    v.fecha_venta AS fecha,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;


-- CONSULTA 2 - CLIENTES SIN VENTAS (LEFT JOIN)
-- Identifica clientes registrados que todavía no compraron.
-- WHERE v.id_venta IS NULL conserva solamente los clientes
-- para los que no se encontró una venta relacionada.

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.fecha_registro;


-- CONSULTA 3 - PRODUCTOS SIN VENTAS (LEFT JOIN)
-- Identifica productos del catálogo sin ventas registradas.
-- Se incorpora la categoría mediante un INNER JOIN.

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;


-- CONSULTA 4 - CONSOLIDADO POR CANAL / ORIGEN (UNION ALL)
-- Como la base no posee una columna de canal, se crea una
-- columna literal y se dividen las ventas en dos períodos.
-- UNION ALL conserva todas las ventas, incluso si hubiera
-- filas con valores coincidentes.

SELECT
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total,
        '05 al 10 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total,
        '11 al 15 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-11' AND '2024-03-15'
) AS ventas_por_canal
GROUP BY canal
ORDER BY canal;
