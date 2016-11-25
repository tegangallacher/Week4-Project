DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id SERIAL8 primary key,
  tag VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL8 primary key,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL8 primary key,
  merchant_id INT8 references merchants(id),
  category_id INT8 references categories(id),
  amount INT8,
  item VARCHAR(255)
);