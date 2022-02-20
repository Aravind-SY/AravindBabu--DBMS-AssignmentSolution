create database TravelOnTheGo;
use TravelOnTheGo;

create table PASSENGER(Passenger_name varchar(25),
 Category varchar(25),
 Gender varchar(25),
 Boarding_City varchar(25),
 Destination_City varchar(25),
 Distance int,
 Bus_Type varchar(25));

create table PRICE(Bus_Type varchar(25),
 Distance int,
 Price int);
 
 insert into PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type) values
 ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
 ('Anmol', 'Non-AC' ,'M','Mumbai', 'Hyderabad', 700, 'Sitting'),
 ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
 ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),
 ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper'),
 ('Ankur', 'AC', 'M' ,'Nagpur', 'Hyderabad', 500 ,'Sitting'),
 ('Hemant', 'Non-AC' ,'M', 'panaji', 'Mumbai', 700 ,'Sleeper'),
 ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500 ,'Sitting'),
 ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');
 
 insert into PRICE (Bus_Type, Distance, Price) values 
 ('Sleeper', 350, 770),
 ('Sleeper', 500, 1100),
 ('Sleeper', 600, 1320),
 ('Sleeper', 700, 1540),
 ('Sleeper', 1000, 2200),
 ('Sleeper', 1200, 2640),
 ('Sleeper', 1500, 2700),
 ('Sitting', 500, 620),
 ('Sitting', 600, 744),
 ('Sitting', 700, 868),
 ('Sitting', 1000, 1240),
 ('Sitting', 1200, 1488),
 ('Sitting', 1500, 1860);
 
 /*3) How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/

select Gender,Count(*) from PASSENGER where Distance >= 600 group by Gender;

/*4) Find the minimum ticket price for Sleeper Bus.*/

select min(price) from PRICE where Bus_type = 'Sleeper';

/*5) Select passenger names whose names start with character 'S'*/

select * from PASSENGER where Passenger_name like 'S%';

/* 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/

select pasngr.Passenger_name, pasngr.Boarding_City, pasngr.Destination_City, pasngr.Category, pasngr.Bus_type, prce.price
from PASSENGER pasngr left join PRICE prce using (Bus_type, Distance)
group by pasngr.Passenger_name, pasngr.Boarding_City, pasngr.Destination_City, pasngr.Category, pasngr.Bus_type;

/* 7) What is the passenger name/s and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM s */

select pasngr.passenger_name, pasngr.Boarding_city,pasngr.Destination_city,pasngr.category, pasngr.Bus_type, prce.price
from PASSENGER pasngr , price prce where pasngr.distance=1000 and pasngr.Bus_type='Sitting';

/* 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?*/

select pasngr.Passenger_name, pasngr.Boarding_city,pasngr.Destination_city,pasngr.Category, prce.Price
from passenger pasngr right join price prce using (distance) where ( (pasngr.Boarding_city='Bengaluru' and pasngr.Destination_city='Panaji') or (pasngr.Boarding_city='Panaji' and pasngr.Destination_city='Bengaluru') ) ;

/*9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.*/

select distinctrow (distance) from PASSENGER  ;

/* 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables */

select pasngr.Passenger_name, (pasngr.Distance/(select sum(Distance) from PASSENGER))*100 from PASSENGER pasngr;

/* 11)Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */

select prce.Distance ,prce.Price, case when prce.Price > 1000 then 'expensive' when (prce.price >500 and prce.price < 1000) 
then 'average' else 'cheap' end from price prce;