CREATE DATABASE SQAcademy;

USE SQAcademy;

-- Crear tabla de clientes
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50) CHECK (region IN ('Norte', 'Sur')) -- Regiones permitidas: Norte, Sur
);

-- Insertar valores en la tabla de clientes (ajusta según tus necesidades)
INSERT INTO customers (customer_id, customer_name, region)
VALUES
    (101, 'Cliente 1', 'Norte'),
    (102, 'Cliente 2', 'Sur'),
    (103, 'Cliente 3', 'Norte'),
    (104, 'Cliente 4', 'Sur');

-- Crear tabla de categorías (ajusta según tus necesidades)
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Insertar valores en la tabla de categorías (ajusta según tus necesidades)
INSERT INTO categories (category_id, category_name)
VALUES
    (301, 'Categoría 1'),
    (302, 'Categoría 2'),
    (303, 'Categoría 3'),
    (304, 'Categoría 4');

-- Crear tabla de productos
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Insertar valores en la tabla de productos (ajusta según tus necesidades)
INSERT INTO products (product_id, product_name, category_id)
VALUES
    (201, 'Producto A', 301),
    (202, 'Producto B', 302),
    (203, 'Producto C', 303),
    (204, 'Producto D', 304);

-- Crear tabla de ventas
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_amount DECIMAL(10, 2),
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Insertar valores en la tabla de ventas
INSERT INTO sales (sale_id, customer_id, product_id, sale_amount, sale_date)
VALUES
    (1, 101, 201, 50, '2024-06-01'),
    (2, 102, 202, 150, '2024-06-02'),
    (3, 103, 203, 300, '2024-06-03'),
    (4, 104, 204, 80, '2024-06-04');

SELECT
    s.sale_id,
    c.customer_name,
    p.product_name,
    cat.category_name
FROM
    sales s
LEFT JOIN
    customers c ON s.customer_id = c.customer_id
JOIN
    products p ON s.product_id = p.product_id
JOIN
    categories cat ON p.category_id = cat.category_id
WHERE
    s.sale_amount > 100
    AND c.region = 'Norte'
ORDER BY
    s.sale_date DESC;
