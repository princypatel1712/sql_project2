drop table if exists pizza_sales;
create table pizzas(pizza_id text, pizza_type_id text, size text,price float);
select * from pizzas;

create table pizza_types(pizza_type_id text, name text,category text,ingredients text);
select * from pizza_types;

drop table if exists orders;
create table orders(order_id int primary key,date date not null,time time not null);
select * from orders;

create table order_details(order_details_id int primary key,order_id int not null,pizaa_id text not null,quantity int not null);
select * from order_details;

--Questions:

-- Basic:
-- 1. Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;


-- 2.Calculate the total revenue generated from pizza sales.
select sum(order_details.quantity * pizzas.price) as total_sales from order_details join pizzas on pizzas.pizza_id=order_details.pizaa_id;


-- 3.Identify the highest-priced pizza.
select pizza_types.name,pizzas.price from pizza_types join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id order by pizzas.price desc limit 1; 


-- 4.Identify the most common pizza size ordered.
select pizzas.size,sum(order_details.quantity) as total_sale from pizzas join order_details on pizzas.pizza_id=order_details.pizaa_id group by pizzas.size order by total_sale desc;


-- 5.List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name , sum(order_details.quantity) as quantity from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizaa_id group by pizza_types.name order by quantity desc limit 5;


-- Intermediate:

-- 6.Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,sum(order_details.quantity) as total_quantity from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizaa_id group by pizza_types.category order by total_quantity desc;


-- 7.Determine the distribution of orders by hour of the day.
select extract(hour from orders.time) as hours, count(order_id) as total_orders from orders group by hours ; 


-- 8.Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name) from pizza_types group by category order by count(name);


-- 9.Group the orders by date and calculate the average number of pizzas ordered per day. 
select avg(quantity) from (select orders.date,sum(order_details.quantity) as quantity from orders join order_details on orders.order_id=order_details.order_id group by orders.date) as data;


-- 10.Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name , sum(order_details.quantity * pizzas.price) as total_revenue from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizaa_id group by pizza_types.name order by total_revenue desc limit 3;


-- Advanced:

-- 11.Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category , sum(order_details.quantity * pizzas.price)/(select sum(order_details.quantity * pizzas.price) as total_sales from order_details join pizzas on pizzas.pizza_id=order_details.pizaa_id) * 100
 as total_revenue from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizaa_id group by pizza_types.category order by total_revenue desc limit 3;

 
-- 12.Analyze the cumulative revenue generated over time.
select date,sum(revenue) over(order by date) from (select orders.date, sum(order_details.quantity * pizzas.price) as revenue from order_details join pizzas on order_details.pizaa_id=pizzas.pizza_id join orders on orders.order_id=order_details.order_id group by orders.date) as sales;


-- 13.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category,name,revenue from (select category , name , revenue, rank() over(partition by category order by revenue) as rn from (select pizza_types.category,pizza_types.name,sum(order_details.quantity * pizzas.price) as revenue from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on order_details.pizaa_id=pizzas.pizza_id group by pizza_types.category,pizza_types.name)as a)as b where rn <=3;