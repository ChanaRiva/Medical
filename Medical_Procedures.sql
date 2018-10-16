create database Medical_Centers
use Medical_Centers
create table Hospitals (
	ID int identity (1,1) primary key,
	Name varchar (20),
	)	
create table Specialties (
	ID int identity (1,1) primary key,
	Name varchar (20)
	)
create table Doctors (
	ID int identity (1,1) primary key,
	Name varchar (20),
	HospitalID int foreign key references Hospitals(ID),
	Specialty_num int foreign key references Specialties (ID),
	birthday date,
	)
create table Patients(
	ID int identity (1,1) primary key,
	Name varchar (20),
	Address varchar (25),
	Phone varchar (10),
	Age int check (Age between 0 and 120),
	DocID int foreign key references Doctors(ID)
	)
	
	insert into Hospitals (Name) values ('Shaarei Tzedek')
	insert into Hospitals (Name) values('Hadassah Ein Kerem')
	insert into Hospitals (Name) values('Bikur Cholim')
	insert into Hospitals (Name) values ('Maayanei HaYeshua')
	insert into Specialties (Name) values ('Labor and Delivery')
	insert into Specialties (Name) values ('Oncology')
	insert into Specialties (Name) values ('Emergency')
	insert into Specialties (Name) values ('Geriatrics')
	insert into Doctors values ('Dr. Greenfield',1,1, '02/25/1998')
	insert into Doctors values ('Dr. Litman', 2,2, '11/07/1997')
	insert into Doctors values ('Dr. Hartstein',3,3, '05/05/1998')
	insert into Doctors values ('Dr. Steiner', 1,3, '01/01/1990')
	insert into Doctors values ('Dr. Zerol', 2,4, '09/11/2001')
	insert into Patients values ('B. Hamilton', '6820 Elbrook Ave','5137281046',25, 1)
	insert into Patients values ('J. Votto', '6060 Sultana Ave','1234567890',50, 5)
	insert into Patients values ('J. Bruce', '17 East 12th','9987654321',32, 4)
	insert into Patients values ('T. BarnHart', '5043 Bluegrass Ln','5134056228',41, 2)
	insert into Patients values ('Y. Molina', '1200 MeadowRidge Ln','5135170271',21, 3)
	insert into Patients values ('T. Fraizer', '4056 Vera Ave','5139695996',63, 2)
	insert into Patients values ('Dr. Steiner', '5896 Sterin st','7186861025',18, 2)
	insert into Patients values ('Dr. Litman', '505 Avenue c','7188543919',35, 5)


	select Patients.Name,Patients.Address,Patients.Age,Patients.Phone,Doctors.Name, Specialties.Name
	from Patients
	inner join Doctors on Doctors.ID=Patients.DocID
	inner join Specialties on Doctors.Specialty_num=Specialties.ID
	--Select all the patients details including name of doctor and the specialty of the doctor

	select count(Patients.DocID) as docId, Doctors.Name 
	from Patients
	inner join Doctors on Doctors.ID=Patients.DocID
	group by Doctors.Name
	--Create a procedure that selects for each doctor how many patients he has
	
		CREATE PROCEDURE PatientsPerDoctor
	AS
	BEGIN
		select count(Patients.DocID) as docId, Doctors.Name 
		from Patients
		inner join Doctors on Doctors.ID=Patients.DocID
		group by Doctors.Name
		having count(Patients.DocID)>1
		--Create a procedure that selects for each doctor how many patients he has
	END
	GO
	exec PatientsPerDoctor

	select Doctors.Name
	from Doctors
	inner join Patients on Doctors.Name=Patients.Name
	--Select all the doctors that are patients of other doctors.

	CREATE PROCEDURE ChangeHospital
	AS
	BEGIN
		update Doctors
		set Doctors.HospitalID= 1
		where Doctors.HospitalID= 3
	END
	GO
	exec ChangeHospital
	--4. Create a procedure that updates all the doctors from “bikur chulim” hospital,to be Doctors in “shaari zedek”

	
	

	select Doctors.Name 
	from Patients
	inner join Doctors on Doctors.ID=Patients.DocID
	group by Doctors.Name
	having count(Patients.DocID)=
	(select MAX(s.docId) 
	from(
	select count(Patients.DocID) as docId, Doctors.Name 
	from Patients
	inner join Doctors on Doctors.ID=Patients.DocID
	group by Doctors.Name)s) 
	--Select the famous doctors, the famous doctors are doctors that have the maximumn number of patience
	
	select avg(s.Age)
	from(
	select Patients.Age
	from Patients
	inner join Doctors on Doctors.ID=Patients.DocID
	inner join Specialties on Doctors.ID=Specialties.ID
	where Specialties.Name= 'Oncology'
	group by Patients.Age)s
	
	--Select the average age of patients that need an eye doctor.