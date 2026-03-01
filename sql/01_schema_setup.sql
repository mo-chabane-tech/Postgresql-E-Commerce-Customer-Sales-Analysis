-- Customers
CREATE TABLE customers (
    customer_id varchar(50) PRIMARY KEY,
    customer_unique_id varchar(50),
    customer_zip_code_prefix integer,
    customer_city varchar(100),
    customer_state varchar(2)
);

-- Geolocation 
CREATE TABLE geolocation (
    geolocation_zip_code_prefix integer,
    geolocation_lat numeric,
    geolocation_lng numeric,
    geolocation_city varchar(100),
    geolocation_state varchar(2)
);

-- Orders
CREATE TABLE orders (
    order_id varchar(50) PRIMARY KEY,
    customer_id varchar(50) REFERENCES customers(customer_id),
    order_status varchar(20),
    order_purchase_timestamp timestamp,
    order_approved_at timestamp,
    order_delivered_carrier_date timestamp,
    order_delivered_customer_date timestamp,
    order_estimated_delivery_date timestamp
);

-- Order Items
CREATE TABLE order_items (
    order_id varchar(50) REFERENCES orders(order_id),
    order_item_id integer,
    product_id varchar(50),
    seller_id varchar(50),
    shipping_limit_date timestamp,
    price numeric(10,2),
    freight_value numeric(10,2),
    PRIMARY KEY (order_id, order_item_id)
);

-- Products
CREATE TABLE products (
    product_id varchar(50) PRIMARY KEY,
    product_category_name varchar(100),
    product_name_length integer,
    product_description_length integer,
    product_photos_qty integer,
    product_weight_g integer,
    product_length_cm integer,
    product_height_cm integer,
    product_width_cm integer
);

-- Sellers
CREATE TABLE sellers (
    seller_id varchar(50) PRIMARY KEY,
    seller_zip_code_prefix integer,
    seller_city varchar(100),
    seller_state varchar(2)
);

-- Payments
CREATE TABLE order_payments (
    order_id varchar(50) REFERENCES orders(order_id),
    payment_sequential integer,
    payment_type varchar(20),
    payment_installments integer,
    payment_value numeric(10,2),
    PRIMARY KEY (order_id, payment_sequential)
);

-- Reviews
CREATE TABLE order_reviews (
    review_id varchar(50),
    order_id varchar(50) REFERENCES orders(order_id),
    review_score integer,
    review_comment_title varchar(100),
    review_comment_message text,
    review_creation_date timestamp,
    review_answer_timestamp timestamp,
    PRIMARY KEY (review_id, order_id)
);