create table Roles
(
    id int,
    name varchar(255),
    constraint uk_id_roles unique(id),
    constraint pk_name_roles primary key(name)
);

create table ClientInfo
(
    id int,
    name varchar(255),
    surname varchar(255),
    constraint pk_id_clieninfo primary key(id)
);

create table Client
(
    id int generated always as identity(start with 1, increment by 1),
    email varchar(255) not null,
    password varchar(255) not null,
    info int,
    role int not null,
    constraint uk_id_client unique(id),
    constraint uk_role_client unique(info),
    constraint pk_email_client primary key(email),
    constraint fk_ClientInfo_To_Client foreign key (info) references ClientInfo(id),
    constraint fk_Role_To_Client foreign key(role) references Roles(id)
);

create table OrderList
(
    id int generated always as identity(start with 1, increment by 1),   
    client int not null,
    created timestamp not null,
    constraint fk_OrderList_To_Client foreign key(client) references Client(id),
    constraint uk_client_OrderList unique(client),
    constraint pk_id_OrderList primary key(id)
);

create table Supplier
(
    id int generated always as identity(start with 1, increment by 1),
    name varchar(255) not null,
    address varchar(255),
    phone varchar(255) not null,
    representative varchar(255),
    constraint uk_id_supplier unique(id),
    constraint pk_name_supplier primary key(name)
);

create table Product
(
    id int generated always as identity(start with 1, increment by 1),
    code int not null,
    title varchar(255) not null,
    supplier int not null,
    initial_price double not null,
    retail_value double not null,
    constraint uk_id_product unique(id),
    constraint pk_code_product primary key(code),
    constraint fk_Supplier_To_product foreign key(supplier) references Supplier(id)
);

create table Order2Product
(
    order_id int not null,
    product int not null,
    constraint uk_order_id_Order2Product unique(order_id),
    constraint fk_booking foreign key(order_id) references OrderList(id),
    constraint fk_product foreign key(product) references Product(id)
);

# Добавление записей в таблицы

insert into Roles(id ,name) values 
(1, 'Администратор'),
(2, 'Клиент');

insert into ClientInfo(id, name, surname) values
(1, 'Александр', 'Иванов'),
(2, 'Иван', 'Петров'),
(3, 'Иван', 'Иванов');

insert into Client(email, password, role, info) values
('Ivanov@gmail.com', '1111', 2, 1),
('Petrov@gmail.com', '2222', 1, 2),
('Ivanibanov@gmail.com', '333', 2, 3);

insert into OrderList(client, created) values
(1, '2019-06-04 22:00:00'),
(2,'2019-06-05 14:00:00'),
(3,'2019-06-05 14:40:00');

insert into Supplier(name, address ,phone ,representative) values
('Рога и Копыта', 'Петергофское шоссе д 72 к. 4', '8(812) 667-85-84',''),
('Зева', 'д. Кудрово, Венская д. 4 к. 2', '8(812) 964-32-69','');

insert into Product( code, title, supplier, initial_price, retail_value) values
(4324872, 'Молоко', 1 , 12.0, 13.0),
(4522467, 'Хлеб', 1 , 2.0, 3.0),
(7665746, 'Бумага', 2 , 5.0, 3.0);

insert into Order2Product(order_id, product) values
(1,1),
(2,3),
(3,1)

