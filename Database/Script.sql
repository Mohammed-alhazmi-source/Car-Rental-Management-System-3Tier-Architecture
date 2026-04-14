--CREATE DATABASE CarsRentalDB;
--USE CarsRentalDB;

-- ÃœÊ· «·œÊ·
CREATE TABLE Countries
(
	CountryID INT NOT NULL IDENTITY(1,1),
	CountryName NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_CountryID PRIMARY KEY CLUSTERED(CountryID)
);

-- ÃœÊ· «·«‘Œ«’
CREATE TABLE People
(
	PersonID INT NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(20) NOT NULL,
	SecondName NVARCHAR(20) NOT NULL,
	ThirdName NVARCHAR(20),
	LastName NVARCHAR(20) NOT NULL,
	Gender BIT NOT NULL,
	NationalNo NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(500) NOT NULL,
	Phone NVARCHAR(30) NOT NULL,
	Email NVARCHAR(100),
	DateOfBirth SMALLDATETIME NOT NULL,
	Nationality INT NOT NULL,
	ImagePath NVARCHAR(150), 

	CONSTRAINT PK_PersonID PRIMARY KEY CLUSTERED(PersonID),
	CONSTRAINT FK_Nationality_People FOREIGN KEY(Nationality) REFERENCES Countries(CountryID)
);
ALTER TABLE People ADD CONSTRAINT DF_Gender DEFAULT 0 FOR Gender;


-- ÃœÊ· „” Œœ„Ì‰ «·‰Ÿ«„
CREATE TABLE Users
(
	UserID INT NOT NULL IDENTITY(1,1),
	PersonID INT NOT NULL,
	UserName NVARCHAR(20) NOT NULL,
	[Password] NVARCHAR(20) NOT NULL,
	IsActive BIT NOT NULL,
	-- Permissions => TODO...

	CONSTRAINT PK_UserID PRIMARY KEY CLUSTERED(UserID),
	CONSTRAINT FK_PersonID_Users FOREIGN KEY(PersonID) REFERENCES People(PersonID)
);
ALTER TABLE Users ADD CONSTRAINT DF_ActiveUser DEFAULT 1 FOR IsActive;


-- ÃœÊ· «·⁄„·«¡
CREATE TABLE Customers
(
	CustomerID INT NOT NULL IDENTITY(1,1),
	CustomerName NVARCHAR(100) NOT NULL,
	Phone NVARCHAR(30) NOT NULL,
	DriverLicenseNumber INT NOT NULL,
	CreatedByUserID INT NOT NULL,

	CONSTRAINT PK_CustomerID PRIMARY KEY CLUSTERED(CustomerID),
	CONSTRAINT FK_CreatedByUserID_Customers FOREIGN KEY(CreatedByUserID) REFERENCES Users(UserID)
);


-- ÃœÊ· «‰Ê«⁄ «·ÊﬁÊœ
CREATE TABLE FuelTypes
(
	FuelTypeID INT NOT NULL IDENTITY(1,1),
	FuelType NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_FuelTypeID PRIMARY KEY CLUSTERED(FuelTypeID)
);


-- ÃœÊ· ›∆«  «·„—ﬂ»…
CREATE TABLE VehicleCategories
(
	CategoryID INT NOT NULL IDENTITY(1,1),
	CategoryName NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_CategoryID PRIMARY KEY CLUSTERED(CategoryID)
);

-- Makes
CREATE TABLE Makes
(
	MakeID INT NOT NULL IDENTITY(1,1),
	MakeName NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_MakeID PRIMARY KEY CLUSTERED(MakeID)
);


-- Make Models
CREATE TABLE MakeModels
(
	ModelID INT NOT NULL IDENTITY(1,1),
	MakeID INT NOT NULL,
	ModelName NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_ModelID PRIMARY KEY CLUSTERED(ModelID),
	CONSTRAINT FK_MakeID_MakeModels FOREIGN KEY(MakeID) REFERENCES Makes(MakeID)
);

-- ÃœÊ· «·„—ﬂ»« 
CREATE TABLE Vehicles
(
	VehicleID INT NOT NULL IDENTITY(1,1),
	MakeID INT NOT NULL,
	ModelID INT NOT NULL,
	[Year] INT NOT NULL,
	Mileage INT NOT NULL,
	FuelTypeID INT NOT NULL,
	PlateNumber INT NOT NULL,
	CarCategoryID INT NOT NULL,
	RentalPricePerDay DECIMAL NOT NULL,
	IsAvailableForRent BIT NOT NULL,
	CreatedByUserID INT NOT NULL,
	ImagePaht NVARCHAR(150),

	CONSTRAINT PK_VehicleID PRIMARY KEY CLUSTERED(VehicleID),
	CONSTRAINT FK_FuelTypeID_Vehicles FOREIGN KEY(FuelTypeID) REFERENCES FuelTypes(FuelTypeID),
	CONSTRAINT FK_CarCategoryID_Vehicles FOREIGN KEY(CarCategoryID) REFERENCES VehicleCategories(CategoryID),
	CONSTRAINT FK_CreatedByUserID_Vehicles FOREIGN KEY(CreatedByUserID) REFERENCES Users(UserID),
	CONSTRAINT FK_MakeID_Vehicles FOREIGN KEY(MakeID) REFERENCES Makes(MakeID),
	CONSTRAINT FK_ModelID_Vehicles FOREIGN KEY(ModelID) REFERENCES MakeModels(ModelID),

);
ALTER TABLE Vehicles ADD CONSTRAINT DF_CarAvailableForRent DEFAULT 1 FOR IsAvailableForRent;



-- ÃœÊ· «·ÕÃÊ“«  «Ê «·«” ∆Ã«—
CREATE TABLE RentalBooking
(
	BookingID INT NOT NULL IDENTITY(1,1),
	CustomerID INT NOT NULL,
	VehicleID INT NOT NULL,
	RentalStartDate Date NOT NULL,
	RentalEndDate DATE NOT NULL,
	PickupLocation NVARCHAR(50) NOT NULL,
	DropOfLocation NVARCHAR(50) NOT NULL,
	InitialRentalDays INT NOT NULL,
	RentalPricePerDay SMALLMONEY NOT NULL,
	InitialTotalDueAmount SMALLMONEY NOT NULL,
	InitialCheckNotes NVARCHAR(500) NOT NULL,
	CreatedByUserID INT NOT NULL,
	IsBooking BIT NOT NULL,

	CONSTRAINT PK_BookingID PRIMARY KEY CLUSTERED(BookingID),
	CONSTRAINT FK_CustomerID_RentalBooking FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
	CONSTRAINT FK_VehicleID_RentalBooking FOREIGN KEY(VehicleID) REFERENCES Vehicles(VehicleID),
	CONSTRAINT FK_CreatedByUserID_RentalBooking FOREIGN KEY(CreatedByUserID) REFERENCES Users(UserID)
);
ALTER TABLE RentalBooking ADD CONSTRAINT DF_RentalStartDate DEFAULT GETDATE() FOR RentalStartDate;
ALTER TABLE RentalBooking ADD CONSTRAINT DF_IsBooking DEFAULT 1 FOR IsBooking;
--ALTER TABLE RentalBooking ALTER COLUMN InitialRentalDays INT;
--ALTER TABLE RentalBooking ALTER COLUMN IsBooking BIT NOT NULL ;
--1 Series M

-- ÃœÊ· «⁄«œ… «·„—ﬂ»« 
CREATE TABLE VehicleReturns
(
	ReturnID INT NOT NULL IDENTITY(1,1),
	ActualReturnDate DATETIME NOT NULL,
	ActualRentalDays INT NOT NULL,
	Mileage SMALLINT NOT NULL,
	ConsumedMileage INT NOT NULL,
	FinalCheckNotes NVARCHAR(500) NOT NULL,
	AdditionalCharges SMALLMONEY NOT NULL,
	ActualTotalDueAmount SMALLMONEY NOT NULL,
	CreatedByUserID INT NOT NULL,

	CONSTRAINT PK_ReturnID PRIMARY KEY CLUSTERED(ReturnID),
	CONSTRAINT FK_CreatedByUserID_VehicleReturns FOREIGN KEY(CreatedByUserID) REFERENCES Users(UserID)
);
ALTER TABLE VehicleReturns ADD CONSTRAINT DF_FinalCheckNotes DEFAULT 'No Thing' FOR FinalCheckNotes;
ALTER TABLE VehicleReturns ADD CONSTRAINT DF_AdditionalCharges DEFAULT 0 FOR AdditionalCharges;
--ALTER TABLE VehicleReturns ALTER COLUMN ActualRentalDays INT NOT NULL;

--ALTER TABLE VehicleReturns ALTER COLUMN ConsumedMileage INT;
--ALTER TABLE VehicleReturns ALTER COLUMN Mileage INT;

-- ÃœÊ· Õ—ﬂ«  «·œ›⁄
CREATE TABLE RentalTransaction
(
	TransactionID INT NOT NULL IDENTITY(1,1),
	BookingID INT NOT NULL,
	ReturnID INT,
	PaymentDetails NVARCHAR(100) NOT NULL,
	PaidInitialTotalDueAmount SMALLMONEY NOT NULL,
	ActualTotalDueAmount SMALLMONEY,
	TotalRemaining SMALLMONEY,
	TotalRefundedAmount SMALLMONEY,
	TransactionDate DATETIME NOT NULL,
	CreatedByUserID INT NOT NULL,
	UpdatedTransactionDate DATETIME,
	UpdatedByUserID INT,

	CONSTRAINT PK_TransactionID PRIMARY KEY CLUSTERED(TransactionID),
	CONSTRAINT FK_BookingID_RentalTransaction FOREIGN KEY(BookingID) REFERENCES RentalBooking(BookingID),
	CONSTRAINT FK_ReturnID_RentalTransaction FOREIGN KEY(ReturnID) REFERENCES VehicleReturns(ReturnID),
	CONSTRAINT FK_CreatedByUserID_RentalTransaction FOREIGN KEY(CreatedByUserID) REFERENCES Users(UserID),
	CONSTRAINT FK_UpdatedByUserID_RentalTransaction FOREIGN KEY(UpdatedByUserID) REFERENCES Users(UserID)
);
--ALTER TABLE RentalTransaction ADD CONSTRAINT DF_TransactionDate DEFAULT GETDATE() FOR TransactionDate;



-- Insert Data

--  VehicleCategories Data
INSERT INTO VehicleCategories(CategoryName)
VALUES
	('10 X 2'),	('10 X 4'),	('10 X 6'),	('10 X 8'),	('12 X 4'),	('12 X 6'),
	('14 X 4'),	('14 X 6'),	('4 X 2'),	('4 X 4'),	('4WD'),	('6 X 2'),
	('6 X 4'),	('6 X 6'),	('8 X 2'),	('8 X 4'),	('8 X 6'),	('8 X 8'),
	('AWD'),	('FWD'),	('RWD');
--------------------------------------------------------------

-- Fuel Types
INSERT INTO FuelTypes(FuelType)
VALUES
('BATTERY EV (EV/BEV)'),('BATTERY W/RANGE EXT (BEV REX)'),('BI-FUEL'),
('BIODIESEL'),('CNG'),('DIESEL'),('ELECTRIC'),('ELECTRIC/DIESEL'),
('ELECTRIC/GAS'),('FLEX'),('FUEL CELL EV (FCEV)'),('FULL HYBRID EV-FLEX (FHEV)'),
('FULL HYBRID EV-GAS (FHEV)'),('GAS'),('LPG'),('MILD HYBRID EV-GAS (MHEV)'),
('PLUG-IN HYBRID EV-GAS (PHEV)');
---------------------------------------

-- Make Data
INSERT Makes (MakeName) VALUES (N'Abarth')						
INSERT Makes (MakeName) VALUES (N'AC')							
INSERT Makes (MakeName) VALUES (N'Acura')							
INSERT Makes (MakeName) VALUES (N'Advance Mixer')							
INSERT Makes (MakeName) VALUES (N'Airstream')							
INSERT Makes (MakeName) VALUES (N'Alfa Romeo')							
INSERT Makes (MakeName) VALUES (N'Allard')							
INSERT Makes (MakeName) VALUES (N'Allstate')							
INSERT Makes (MakeName) VALUES (N'Alpine')
INSERT Makes (MakeName) VALUES (N'Alvis')
INSERT Makes (MakeName) VALUES (N'AM General')
INSERT Makes (MakeName) VALUES (N'AMC')
INSERT Makes (MakeName) VALUES (N'American Austin')
INSERT Makes (MakeName) VALUES (N'American Bantam')
INSERT Makes (MakeName) VALUES (N'American Coach')
INSERT Makes (MakeName) VALUES (N'American LaFrance')
INSERT Makes (MakeName) VALUES (N'Amphicar')
INSERT Makes (MakeName) VALUES (N'Apollo')
INSERT Makes (MakeName) VALUES (N'Apperson')
INSERT Makes (MakeName) VALUES (N'Ariel')
INSERT Makes (MakeName) VALUES (N'Armstrong-Siddeley')
INSERT Makes (MakeName) VALUES (N'Arnolt-Bristol')
INSERT Makes (MakeName) VALUES (N'Arnolt-MG')
INSERT Makes (MakeName) VALUES (N'Aston Martin')
INSERT Makes (MakeName) VALUES (N'Astra')
INSERT Makes (MakeName) VALUES (N'Asuna')
INSERT Makes (MakeName) VALUES (N'Auburn')
INSERT Makes (MakeName) VALUES (N'Audi')
INSERT Makes (MakeName) VALUES (N'Austin')
INSERT Makes (MakeName) VALUES (N'Austin Healey')
INSERT Makes (MakeName) VALUES (N'Autocar')
INSERT Makes (MakeName) VALUES (N'Autocar LLC')
INSERT Makes (MakeName) VALUES (N'Avanti')
INSERT Makes (MakeName) VALUES (N'BAIC')
INSERT Makes (MakeName) VALUES (N'Bentley')
INSERT Makes (MakeName) VALUES (N'Bering')
INSERT Makes (MakeName) VALUES (N'Berkeley')
INSERT Makes (MakeName) VALUES (N'Bertone')
INSERT Makes (MakeName) VALUES (N'Biddle')
INSERT Makes (MakeName) VALUES (N'Bizzarrini')
INSERT Makes (MakeName) VALUES (N'Blackhawk')
INSERT Makes (MakeName) VALUES (N'Blue Bird')
INSERT Makes (MakeName) VALUES (N'BMW')
INSERT Makes (MakeName) VALUES (N'Bond')
INSERT Makes (MakeName) VALUES (N'Borgward')
INSERT Makes (MakeName) VALUES (N'Bricklin')
INSERT Makes (MakeName) VALUES (N'Bristol')
INSERT Makes (MakeName) VALUES (N'Bugatti')
INSERT Makes (MakeName) VALUES (N'Buick')
INSERT Makes (MakeName) VALUES (N'Bus & Coach Intl (BCI)')
INSERT Makes (MakeName) VALUES (N'BYD')
INSERT Makes (MakeName) VALUES (N'Cadillac')
INSERT Makes (MakeName) VALUES (N'Capacity Of Texas')
INSERT Makes (MakeName) VALUES (N'Case')
INSERT Makes (MakeName) VALUES (N'Caterpillar')
INSERT Makes (MakeName) VALUES (N'Chance Coach Transit Bus')
INSERT Makes (MakeName) VALUES (N'Chandler')
INSERT Makes (MakeName) VALUES (N'Changan')
INSERT Makes (MakeName) VALUES (N'Chanje')
INSERT Makes (MakeName) VALUES (N'Checker')
INSERT Makes (MakeName) VALUES (N'Chevrolet')
INSERT Makes (MakeName) VALUES (N'Chirey')
INSERT Makes (MakeName) VALUES (N'Chrysler')
INSERT Makes (MakeName) VALUES (N'Cisitalia')
INSERT Makes (MakeName) VALUES (N'CitroÎn')
INSERT Makes (MakeName) VALUES (N'Cleveland')
INSERT Makes (MakeName) VALUES (N'Coach House')
INSERT Makes (MakeName) VALUES (N'Coachmen')
INSERT Makes (MakeName) VALUES (N'Coda')
INSERT Makes (MakeName) VALUES (N'Cole')
INSERT Makes (MakeName) VALUES (N'Continental')
INSERT Makes (MakeName) VALUES (N'Cord')
INSERT Makes (MakeName) VALUES (N'Country Coach')
INSERT Makes (MakeName) VALUES (N'Country Coach Motorhome')
INSERT Makes (MakeName) VALUES (N'Crane Carrier')
INSERT Makes (MakeName) VALUES (N'Crosley')
INSERT Makes (MakeName) VALUES (N'Crown Coach')
INSERT Makes (MakeName) VALUES (N'Cunningham')
INSERT Makes (MakeName) VALUES (N'Daewoo')
INSERT Makes (MakeName) VALUES (N'DAF')
INSERT Makes (MakeName) VALUES (N'Daihatsu')
INSERT Makes (MakeName) VALUES (N'Daimler')
INSERT Makes (MakeName) VALUES (N'Damon')
INSERT Makes (MakeName) VALUES (N'Darrin')
INSERT Makes (MakeName) VALUES (N'Datsun')
INSERT Makes (MakeName) VALUES (N'Davis')
INSERT Makes (MakeName) VALUES (N'De Tomaso')
INSERT Makes (MakeName) VALUES (N'De Vaux')
INSERT Makes (MakeName) VALUES (N'Delage')
INSERT Makes (MakeName) VALUES (N'Delahaye')
INSERT Makes (MakeName) VALUES (N'Dellow')
INSERT Makes (MakeName) VALUES (N'DeLorean')
INSERT Makes (MakeName) VALUES (N'Dennis Eagle')
INSERT Makes (MakeName) VALUES (N'Denzel')
INSERT Makes (MakeName) VALUES (N'DeSoto')
INSERT Makes (MakeName) VALUES (N'Deutsch-Bonnet')
INSERT Makes (MakeName) VALUES (N'Diamond Reo')
INSERT Makes (MakeName) VALUES (N'Diana')
INSERT Makes (MakeName) VALUES (N'Dina')
INSERT Makes (MakeName) VALUES ( N'Dina Transit Bus')
INSERT Makes (MakeName) VALUES ( N'DKW')
INSERT Makes (MakeName) VALUES ( N'Dodge')
INSERT Makes (MakeName) VALUES ( N'Doretti')
INSERT Makes (MakeName) VALUES ( N'Du Pont')
INSERT Makes (MakeName) VALUES ( N'Dual-Ghia')
INSERT Makes (MakeName) VALUES ( N'Duesenberg')
INSERT Makes (MakeName) VALUES ( N'Duplex')
INSERT Makes (MakeName) VALUES ( N'Durant')
INSERT Makes (MakeName) VALUES ( N'Duryea')
INSERT Makes (MakeName) VALUES ( N'Dynamax Corp')
INSERT Makes (MakeName) VALUES ( N'Eagle')
INSERT Makes (MakeName) VALUES ( N'Eagle Transit Buses')
INSERT Makes (MakeName) VALUES ( N'Edsel')
INSERT Makes (MakeName) VALUES ( N'El Dorado')
INSERT Makes (MakeName) VALUES ( N'Elcar')
INSERT Makes (MakeName) VALUES ( N'Elva')
INSERT Makes (MakeName) VALUES ( N'Emergency One')
INSERT Makes (MakeName) VALUES ( N'Entegra Coach')
INSERT Makes (MakeName) VALUES ( N'Erskine')
INSERT Makes (MakeName) VALUES ( N'Essex')
INSERT Makes (MakeName) VALUES ( N'Evobus')
INSERT Makes (MakeName) VALUES ( N'Excalibur')
INSERT Makes (MakeName) VALUES ( N'Facel Vega')
INSERT Makes (MakeName) VALUES ( N'Fairthorpe')
INSERT Makes (MakeName) VALUES ( N'Falcon Knight')
INSERT Makes (MakeName) VALUES ( N'Fargo')
INSERT Makes (MakeName) VALUES ( N'FAW')
INSERT Makes (MakeName) VALUES ( N'Federal Motors')
INSERT Makes (MakeName) VALUES ( N'Ferrara')
INSERT Makes (MakeName) VALUES ( N'Ferrari')
INSERT Makes (MakeName) VALUES ( N'Fiat')
INSERT Makes (MakeName) VALUES ( N'Fisker')
INSERT Makes (MakeName) VALUES ( N'Fleetwood')
INSERT Makes (MakeName) VALUES ( N'Flint')
INSERT Makes (MakeName) VALUES ( N'Flxible Transit Bus')
INSERT Makes (MakeName) VALUES ( N'Ford')
INSERT Makes (MakeName) VALUES ( N'Forest River')
INSERT Makes (MakeName) VALUES ( N'Foretravel Motorhome')
INSERT Makes (MakeName) VALUES ( N'Foton')
INSERT Makes (MakeName) VALUES ( N'Four Winds International')
INSERT Makes (MakeName) VALUES ( N'Franklin')
INSERT Makes (MakeName) VALUES ( N'Frazer')
INSERT Makes (MakeName) VALUES ( N'Frazer Nash')
INSERT Makes (MakeName) VALUES ( N'Freightliner')
INSERT Makes (MakeName) VALUES ( N'FWD')
INSERT Makes (MakeName) VALUES ( N'FWD Corporation')
INSERT Makes (MakeName) VALUES ( N'Gardner')
INSERT Makes (MakeName) VALUES ( N'Genesis')
INSERT Makes (MakeName) VALUES ( N'Genesis Transit Buses')
INSERT Makes (MakeName) VALUES ( N'Geo')
INSERT Makes (MakeName) VALUES ( N'Giant')
INSERT Makes (MakeName) VALUES ( N'Giant Motors')
INSERT Makes (MakeName) VALUES ( N'Gillig')
INSERT Makes (MakeName) VALUES ( N'Glas')
INSERT Makes (MakeName) VALUES ( N'GMC')
INSERT Makes (MakeName) VALUES ( N'goggomobil') 
INSERT Makes (MakeName) VALUES ( N'goliath')
INSERT Makes (MakeName) VALUES ( N'Grodon-Keeble')
INSERT Makes (MakeName) VALUES ( N'Graham')
INSERT Makes (MakeName) VALUES ( N'Graham-Paige')
INSERT Makes (MakeName) VALUES ( N'Grande West')
INSERT Makes (MakeName) VALUES ( N'GreenPower Motors')
INSERT Makes (MakeName) VALUES ( N'Griffith')
INSERT Makes (MakeName) VALUES ( N'Gulf Stream')
INSERT Makes (MakeName) VALUES ( N'Hansa')
INSERT Makes (MakeName) VALUES ( N'Haynes')
INSERT Makes (MakeName) VALUES ( N'HCS')
INSERT Makes (MakeName) VALUES ( N'Healey')
INSERT Makes (MakeName) VALUES ( N'Hendrickson')
INSERT Makes (MakeName) VALUES ( N'Henry J')
INSERT Makes (MakeName) VALUES ( N'Hertz')
INSERT Makes (MakeName) VALUES ( N'Hillman')
INSERT Makes (MakeName) VALUES ( N'Hino')
INSERT Makes (MakeName) VALUES ( N'Hispano-Suiza')
INSERT Makes (MakeName) VALUES ( N'Holiday Rambler')
INSERT Makes (MakeName) VALUES ( N'Honda')
INSERT Makes (MakeName) VALUES ( N'Hotchkiss')
INSERT Makes (MakeName) VALUES ( N'HRG')
INSERT Makes (MakeName) VALUES ( N'Hudson')
INSERT Makes (MakeName) VALUES ( N'Humber')
INSERT Makes (MakeName) VALUES ( N'Hummer')
INSERT Makes (MakeName) VALUES ( N'Hupmobile')
INSERT Makes (MakeName) VALUES ( N'Hyundai')
INSERT Makes (MakeName) VALUES ( N'IC Corporation')
INSERT Makes (MakeName) VALUES ( N'Indiana Phoenix')
INSERT Makes (MakeName) VALUES ( N'INFINITI')
INSERT Makes (MakeName) VALUES ( N'International Harvester')
INSERT Makes (MakeName) VALUES ( N'Iso')
INSERT Makes (MakeName) VALUES ( N'Isotta Fraschini')
INSERT Makes (MakeName) VALUES ( N'Isuzu')
INSERT Makes (MakeName) VALUES ( N'Itasca')
INSERT Makes (MakeName) VALUES ( N'Iveco')
INSERT Makes (MakeName) VALUES ( N'JAC')
INSERT Makes (MakeName) VALUES ( N'Jaguar')
INSERT Makes (MakeName) VALUES ( N'Jayco')
INSERT Makes (MakeName) VALUES ( N'Jeep')
INSERT Makes (MakeName) VALUES ( N'Jeffery')
INSERT Makes (MakeName) VALUES ( N'Jensen')
INSERT Makes (MakeName) VALUES ( N'Jewett')
INSERT Makes (MakeName) VALUES ( N'JMC')
INSERT Makes (MakeName) VALUES ( N'Jordan')
INSERT Makes (MakeName) VALUES ( N'Jowett')
INSERT Makes (MakeName) VALUES ( N'Kaiser')
INSERT Makes (MakeName) VALUES ( N'Kalmar')
INSERT Makes (MakeName) VALUES ( N'Karma')
INSERT Makes (MakeName) VALUES ( N'Kenworth')
INSERT Makes (MakeName) VALUES ( N'Kia')
INSERT Makes (MakeName) VALUES ( N'Kimble Chassis')
INSERT Makes (MakeName) VALUES ( N'Kissel')
INSERT Makes (MakeName) VALUES ( N'Koenigsegg')
INSERT Makes (MakeName) VALUES ( N'Kovatch')
INSERT Makes (MakeName) VALUES ( N'Kurtis')
INSERT Makes (MakeName) VALUES ( N'Lada')
INSERT Makes (MakeName) VALUES ( N'Laforza')
INSERT Makes (MakeName) VALUES ( N'Lagonda')
INSERT Makes (MakeName) VALUES ( N'Lamborghini')
INSERT Makes (MakeName) VALUES ( N'Lanchester')
INSERT Makes (MakeName) VALUES ( N'Lancia')
INSERT Makes (MakeName) VALUES ( N'Land Rover')
INSERT Makes (MakeName) VALUES ( N'LaSalle')
INSERT Makes (MakeName) VALUES ( N'Lea-Francis')
INSERT Makes (MakeName) VALUES ( N'Leisure Travel')
INSERT Makes (MakeName) VALUES ( N'Les Autobus MCI')
INSERT Makes (MakeName) VALUES ( N'Lexington')
INSERT Makes (MakeName) VALUES ( N'Lexus')
INSERT Makes (MakeName) VALUES ( N'Lincoln')
INSERT Makes (MakeName) VALUES ( N'Lion')
INSERT Makes (MakeName) VALUES ( N'Lloyd')
INSERT Makes (MakeName) VALUES ( N'Locomobile')
INSERT Makes (MakeName) VALUES ( N'Lodal')
INSERT Makes (MakeName) VALUES ( N'Lotus')
INSERT Makes (MakeName) VALUES ( N'Lucid')
INSERT Makes (MakeName) VALUES ( N'Mack')
INSERT Makes (MakeName) VALUES ( N'Maico')
INSERT Makes (MakeName) VALUES ( N'MAN')
INSERT Makes (MakeName) VALUES ( N'Marathon')
INSERT Makes (MakeName) VALUES ( N'Marauder')
INSERT Makes (MakeName) VALUES ( N'Marcos')
INSERT Makes (MakeName) VALUES ( N'Marmon')
INSERT Makes (MakeName) VALUES ( N'Marmon Herrington')
INSERT Makes (MakeName) VALUES ( N'Marquette')
INSERT Makes (MakeName) VALUES ( N'MASA')
INSERT Makes (MakeName) VALUES ( N'Maserati')
INSERT Makes (MakeName) VALUES ( N'Mastretta')
INSERT Makes (MakeName) VALUES ( N'Matra')
INSERT Makes (MakeName) VALUES ( N'Maxim')
INSERT Makes (MakeName) VALUES ( N'Maxwell')
INSERT Makes (MakeName) VALUES ( N'Maybach')
INSERT Makes (MakeName) VALUES ( N'Mazda')
INSERT Makes (MakeName) VALUES ( N'McLaren')
INSERT Makes (MakeName) VALUES ( N'Mercedes-Benz')
INSERT Makes (MakeName) VALUES ( N'Mercury')
INSERT Makes (MakeName) VALUES ( N'Merkur')
INSERT Makes (MakeName) VALUES ( N'Messerschmitt')
INSERT Makes (MakeName) VALUES ( N'Metropolitan')
INSERT Makes (MakeName) VALUES ( N'MG')
INSERT Makes (MakeName) VALUES ( N'Mini')
INSERT Makes (MakeName) VALUES ( N'Mitsubishi')
INSERT Makes (MakeName) VALUES ( N'Mitsubishi Fuso')
INSERT Makes (MakeName) VALUES ( N'Mobility Ventures')
INSERT Makes (MakeName) VALUES ( N'Monaco Coach')
INSERT Makes (MakeName) VALUES ( N'Monteverdi')
INSERT Makes (MakeName) VALUES ( N'Moon')
INSERT Makes (MakeName) VALUES ( N'Moretti')
INSERT Makes (MakeName) VALUES ( N'Morgan')
INSERT Makes (MakeName) VALUES ( N'Morris')
INSERT Makes (MakeName) VALUES ( N'Moskvich')
INSERT Makes (MakeName) VALUES ( N'Motor Coach Industries')
INSERT Makes (MakeName) VALUES ( N'Nardi')
INSERT Makes (MakeName) VALUES ( N'Nash')
INSERT Makes (MakeName) VALUES ( N'National RV')
INSERT Makes (MakeName) VALUES ( N'Neoplan')
INSERT Makes (MakeName) VALUES ( N'New Flyer')
INSERT Makes (MakeName) VALUES ( N'Newmar')
INSERT Makes (MakeName) VALUES ( N'Nexus')
INSERT Makes (MakeName) VALUES ( N'Nissan')
INSERT Makes (MakeName) VALUES ( N'North American Bus Industries (NABI)')
INSERT Makes (MakeName) VALUES ( N'Nova Bus Corporation')
INSERT Makes (MakeName) VALUES ( N'NSU')
INSERT Makes (MakeName) VALUES ( N'Oakland')
INSERT Makes (MakeName) VALUES ( N'Oldsmobile')
INSERT Makes (MakeName) VALUES ( N'Omega')
INSERT Makes (MakeName) VALUES ( N'Ontario Bus')
INSERT Makes (MakeName) VALUES ( N'Opel')
INSERT Makes (MakeName) VALUES ( N'Orion Bus')
INSERT Makes (MakeName) VALUES ( N'Osca')
INSERT Makes (MakeName) VALUES ( N'Oshkosh Motor Truck Co')
INSERT Makes (MakeName) VALUES ( N'Ottawa')
INSERT Makes (MakeName) VALUES ( N'Packard')
INSERT Makes (MakeName) VALUES ( N'Paige')
INSERT Makes (MakeName) VALUES ( N'Panhard')
INSERT Makes (MakeName) VALUES ( N'Panoz')
INSERT Makes (MakeName) VALUES ( N'Panther')
INSERT Makes (MakeName) VALUES ( N'Peerless')
INSERT Makes (MakeName) VALUES ( N'Pegaso')
INSERT Makes (MakeName) VALUES ( N'Peterbilt')
INSERT Makes (MakeName) VALUES ( N'Peugeot')
INSERT Makes (MakeName) VALUES ( N'Pierce Mfg Inc')
INSERT Makes (MakeName) VALUES ( N'Pierce-Arrow')
INSERT Makes (MakeName) VALUES ( N'Pleasure-Way')
INSERT Makes (MakeName) VALUES ( N'Plymouth')
INSERT Makes (MakeName) VALUES ( N'Polestar')
INSERT Makes (MakeName) VALUES ( N'Pontiac')
INSERT Makes (MakeName) VALUES ( N'Porsche')
INSERT Makes (MakeName) VALUES ( N'Prevost')
INSERT Makes (MakeName) VALUES ( N'Proterra')
INSERT Makes (MakeName) VALUES ( N'Qvale')
INSERT Makes (MakeName) VALUES ( N'Ram')
INSERT Makes (MakeName) VALUES ( N'Rambler')
INSERT Makes (MakeName) VALUES ( N'Reliant')
INSERT Makes (MakeName) VALUES ( N'Renault')
INSERT Makes (MakeName) VALUES ( N'Renegade')
INSERT Makes (MakeName) VALUES (N'Reo')
INSERT Makes (MakeName) VALUES (N'Rickenbacker')
INSERT Makes (MakeName) VALUES (N'Riley')
INSERT Makes (MakeName) VALUES (N'Rivian')
INSERT Makes (MakeName) VALUES (N'Roadmaster Rail')
INSERT Makes (MakeName) VALUES (N'Roadtrek')
INSERT Makes (MakeName) VALUES (N'Roamer')
INSERT Makes (MakeName) VALUES (N'Rockne')
INSERT Makes (MakeName) VALUES (N'Rollin')
INSERT Makes (MakeName) VALUES (N'Rolls-Royce')
INSERT Makes (MakeName) VALUES (N'Roosevelt')
INSERT Makes (MakeName) VALUES (N'Rosenbauer America')
INSERT Makes (MakeName) VALUES (N'Rover')
INSERT Makes (MakeName) VALUES (N'R-Vision')
INSERT Makes (MakeName) VALUES (N'Saab')
INSERT Makes (MakeName) VALUES (N'Sabra')
INSERT Makes (MakeName) VALUES (N'Saleen')
INSERT Makes (MakeName) VALUES (N'Salmson')
INSERT Makes (MakeName) VALUES (N'Saturn')
INSERT Makes (MakeName) VALUES (N'Savage')
INSERT Makes (MakeName) VALUES (N'Scania')
INSERT Makes (MakeName) VALUES (N'Scion')
INSERT Makes (MakeName) VALUES (N'Scripps Booth')
INSERT Makes (MakeName) VALUES (N'Seagrave Fire Apparatus')
INSERT Makes (MakeName) VALUES (N'Seat')
INSERT Makes (MakeName) VALUES (N'Shelby')
INSERT Makes (MakeName) VALUES (N'Sheridan')
INSERT Makes (MakeName) VALUES (N'Siata')
INSERT Makes (MakeName) VALUES (N'Simca')
INSERT Makes (MakeName) VALUES (N'Singer')
INSERT Makes (MakeName) VALUES (N'Skoda')
INSERT Makes (MakeName) VALUES (N'Smart')
INSERT Makes (MakeName) VALUES (N'Spartan Motors')
INSERT Makes (MakeName) VALUES (N'Spyker')
INSERT Makes (MakeName) VALUES (N'SRT')
INSERT Makes (MakeName) VALUES (N'SsangYong')
INSERT Makes (MakeName) VALUES (N'Standard')
INSERT Makes (MakeName) VALUES (N'Stanguellini')
INSERT Makes (MakeName) VALUES (N'Star')
INSERT Makes (MakeName) VALUES (N'Stearns Knight')
INSERT Makes (MakeName) VALUES (N'Sterling')
INSERT Makes (MakeName) VALUES (N'Sterling Truck')
INSERT Makes (MakeName) VALUES (N'Stevens-Duryea')
INSERT Makes (MakeName) VALUES (N'Stewart & Stevenson')
INSERT Makes (MakeName) VALUES (N'Studebaker')
INSERT Makes (MakeName) VALUES (N'Stutz')
INSERT Makes (MakeName) VALUES (N'Subaru')
INSERT Makes (MakeName) VALUES (N'Sunbeam')
INSERT Makes (MakeName) VALUES (N'Sutphen Corp')
INSERT Makes (MakeName) VALUES (N'Suzuki')
INSERT Makes (MakeName) VALUES (N'Swallow')
INSERT Makes (MakeName) VALUES (N'Talbot-Lago')
INSERT Makes (MakeName) VALUES (N'Tatra')
INSERT Makes (MakeName) VALUES (N'Temsa Bus')
INSERT Makes (MakeName) VALUES (N'Terex / Terex Advance')
INSERT Makes (MakeName) VALUES (N'Tesla')
INSERT Makes (MakeName) VALUES (N'Think')
INSERT Makes (MakeName) VALUES (N'Thomas')
INSERT Makes (MakeName) VALUES (N'Thor Motor Coach')
INSERT Makes (MakeName) VALUES (N'Tiffin')
INSERT Makes (MakeName) VALUES (N'Toyopet')
INSERT Makes (MakeName) VALUES (N'Toyota')
INSERT Makes (MakeName) VALUES (N'Transportation Mfg Corp')
INSERT Makes (MakeName) VALUES (N'Triumph')
INSERT Makes (MakeName) VALUES (N'Tucker')
INSERT Makes (MakeName) VALUES (N'Turner')
INSERT Makes (MakeName) VALUES (N'TVR')
INSERT Makes (MakeName) VALUES (N'UAZ')
INSERT Makes (MakeName) VALUES (N'UD')
INSERT Makes (MakeName) VALUES (N'Unimog')
INSERT Makes (MakeName) VALUES (N'Utilimaster')
INSERT Makes (MakeName) VALUES (N'VAM')
INSERT Makes (MakeName) VALUES (N'Van Hool')
INSERT Makes (MakeName) VALUES (N'Vauxhall')
INSERT Makes (MakeName) VALUES (N'Velie')
INSERT Makes (MakeName) VALUES (N'Vespa')
INSERT Makes (MakeName) VALUES (N'Viking')
INSERT Makes (MakeName) VALUES (N'Volkswagen')
INSERT Makes (MakeName) VALUES (N'Volvo')
INSERT Makes (MakeName) VALUES (N'VPG')
INSERT Makes (MakeName) VALUES (N'Wartburg')
INSERT Makes (MakeName) VALUES (N'Westcott')
INSERT Makes (MakeName) VALUES (N'Western RV')
INSERT Makes (MakeName) VALUES (N'Western Star')
INSERT Makes (MakeName) VALUES (N'Whippet')
INSERT Makes (MakeName) VALUES (N'White')
INSERT Makes (MakeName) VALUES (N'White/GMC')
INSERT Makes (MakeName) VALUES (N'Willys')
INSERT Makes (MakeName) VALUES (N'Windsor')
INSERT Makes (MakeName) VALUES (N'Winnebago')
INSERT Makes (MakeName) VALUES (N'Wolseley')
INSERT Makes (MakeName) VALUES (N'Workhorse')
INSERT Makes (MakeName) VALUES (N'Workhorse Custom Chassis')
INSERT Makes (MakeName) VALUES (N'Xos')
INSERT Makes (MakeName) VALUES (N'Yellow Cab')
INSERT Makes (MakeName) VALUES (N'Yugo')
INSERT Makes (MakeName) VALUES (N'Zacua')
INSERT Makes (MakeName) VALUES (N'Zeligson')
INSERT Makes (MakeName) VALUES (N'Zundapp')
---------------------------------------------

-- Make Models Data

INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'1150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'204')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'205')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'850')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (1, N'Simca')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (2, N'427')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (2, N'428')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (2, N'Ace')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (2, N'Aceca')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 2, N'Greyhound')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 2, N'Shelby Cobra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 2, N'Two-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'CL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'CSX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'EL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'ILX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'Integra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'Legend')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'MDX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'NSX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'RDX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'RL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'RLX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'RSX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'SLX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'TL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'TLX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'TSX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'Vigor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 3, N'ZDX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 4, N'Advance Mixer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 4, N'Glider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 4, N'M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 4, N'S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 5, N'Interstate')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 5, N'Land Yacht XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'147')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'156')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'159')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'164')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'166')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'1900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'1900C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'2600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'4C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'6C 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'6C 1750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'6C 2300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'6C 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'8C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'8C 2300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'8C 2900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'Alfetta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'Berlina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'Brera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'Duetto 1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'Giulia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'Giulia Sprint')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'Giulietta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'GT Veloce')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'GTA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 6, N'GTC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'GTV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'GTV-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'GTZ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Milano')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Mito')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Montreal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'RL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Sportwagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Sprint')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Stelvio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'Tonale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'TZ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (6, N'TZ 2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'J1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'J2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'J2X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'K1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'K2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'K3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'Monte Carlo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'Palm Beach')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (7, N'Safari')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (8, N'A-230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (8, N'A-240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (9, N'A110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (9, N'A310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TA14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TA21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TB14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TB21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TC108/G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TC21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TC21/100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TD21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TE21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (10, N'TF21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (11, N'DJ5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (11, N'FJ8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (11, N'Hummer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Ambassador')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'American')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'AMX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Concord')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Eagle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Gremlin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Hornet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Javelin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Marlin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Matador')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Pacer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Rambler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Rebel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Rogue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Spirit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (12, N'Super Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (13, N'American Austin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (14, N'May-75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (14, N'Model 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (14, N'Model 62')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (14, N'Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (15, N'American Eagle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (15, N'American Heritage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (15, N'American Patriot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (15, N'American Revolution SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (15, N'American Tradition')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (15, N'Revolution')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (15, N'Revolution LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (16, N'ALF Eagle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (16, N'Condor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (16, N'Metropolitan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (17, N'770')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (18, N'GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (19, N'Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (19, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (20, N'Atom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (21, N'Hurricane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (21, N'Lancaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (21, N'Sapphire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (21, N'Star Sapphire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (21, N'Tempest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (21, N'Typhoon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (21, N'Whitley')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (22, N'Bolide')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (22, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (23, N'MG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB2-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DB9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DBD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DBS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DBX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'DBX707')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'Lagonda')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'One-77')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'Rapide')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'V12 Vantage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'V-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'V8 Vantage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'Vanquish')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'Vantage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'Virage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (24, N'Zagato')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (25, N'Dumper Articulado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (25, N'Dumper Rigido')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (25, N'HD9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (26, N'GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (26, N'SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (26, N'Sunfire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (26, N'Sunrunner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 115')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 12-160')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 12-160A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 12-161')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 12-161A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 12-165')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 1250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 30L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 33L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 33M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 35L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 40A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 40H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 40L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 40M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 40N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 4-36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 4-38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 4-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 4-41')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 4-43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 4-44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 45B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-39')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-46')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-51')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 652X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 652Y')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-63')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-653')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-654')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 6-85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 76')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-100A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-101A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 850X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 850Y')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-77')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-851')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-852')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-98')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model 8-98A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model Union 4-36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Model Y')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (27, N'Second Series Model 76')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'100 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'100 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'200 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'4000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'4000 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'5000 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'80 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'90 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A3 e-tron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A3 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A3 Sportback e-tron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A4 allroad')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A4 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A5 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A5 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (28, N'A6 allroad')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'A6 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'A7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'A7 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'A7 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'A8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'A8 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'allroad')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Allroad Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Cabriolet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Coupe Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'e-tron GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'e-tron Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'e-tron S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'e-tron S Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'e-tron Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Fox')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q2 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q3 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q4 e-tron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q4 e-tron Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q5 PHEV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q5 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Q8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'R8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS e-tron GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS Q3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS Q8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS5 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS6 Avant')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'RS7 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S5 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S7 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'S8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'SQ5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'SQ5 Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'SQ7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'SQ8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'Super 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'TT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'TT Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'TT RS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'TT RS Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'TTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'TTS Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 28, N'V8 Quattro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'A125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'A30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'A35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'A40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'A60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'A70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'A90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'America')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Atlantic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Bantam')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Cambridge')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Countryman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Devon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Hereford')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Marina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Mini')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Mini 850')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Mini Cooper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Mini Moke')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Princess')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Seven')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Sheerline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Somerset')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Sports')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 29, N'Westminster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 30, N'100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 30, N'100-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 30, N'3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 30, N'Sprite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'ACL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'ACM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'AT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'C / DC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'Construcktor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'DK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'DS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 31, N'S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'DC-64')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'Xpeditor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'Xpeditor WX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'Xpeditor WXLL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'Xpeditor WXR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'Xpert')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'Xspotter Off Road')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 32, N'Xspotter On Road')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 33, N'Avanti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 33, N'II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'BJ20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'BJ40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'D20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'M50S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'X25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'X30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'X35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 34, N'X65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'3 1/2-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'3-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'4 1/2-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'4 1/4-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'4-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'8-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Arnage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Azure')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Bentayga')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Bentayga EWB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Brooklands')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Continental')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Corniche')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Flying Spur')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Mark V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Mk VI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Mulsanne')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'R Type')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'S1 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'S2 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'S3 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'T1 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'T2 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 35, N'Turbo R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 36, N'HD67MX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 36, N'LD15A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 36, N'MD23M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 36, N'MD26M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 37, N'328')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 37, N'B105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 37, N'B95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 37, N'QB105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 37, N'QB95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 37, N'Sports 500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 38, N'X-1/9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 39, N'Model B-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 39, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 40, N'GT America')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 40, N'GT Strada 5300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 41, N'L-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 41, N'L-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'All American FE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'All American RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'Commercial Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'SHL All American')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'SHL Commercial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'SHL TC2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'TC1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'TC2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'Vision School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 42, N'Wanderlodge')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1 Series M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'118i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'120i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'125i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'128i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'128ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'130i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'135i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'135is')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1600-2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1600ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1602')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1800ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'1802')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2.8 Bavaria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2000c')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2000cs')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2000ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2000tii')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2002')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2002ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2002tii')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'220i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'220i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'228i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'228i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'228i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'228i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'230i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'230i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'235i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'2800CS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'3.0CS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'3.0CSi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'3.0CSL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'3.0S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'3.0Si')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'303')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'315')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'318i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'318is')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'318ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'3200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'3200CS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'320i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'320i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'323Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'323i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'323is')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'323ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325es')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325is')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325iX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'325xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'326')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'327')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328d')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328d xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328i GT xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328is')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'328xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'330Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'330e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'330e xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'330i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'330i GT xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'330i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'330xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'335')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'335d')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'335i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'335i GT xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'335i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'335is')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'335xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'340i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'340i GT xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'340i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'420i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'420i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'428i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'428i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'428i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'428i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'430i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'430i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'430i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'430i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'435i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'435i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'435i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'435i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'440i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'440i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'440i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'440i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'501A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'501B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'502')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'503')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'507')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'520i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'524td')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'525i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'525iT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'525xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'528e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'528i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'528i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'528xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'530e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'530e xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'530e xDrive iPerformance')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'530i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'530i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'530xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'533i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535d')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535d xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535i GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535i GT xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535is')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'535xi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'540d xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'540i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'540i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'545i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'550i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'550i GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'550i GT xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'550i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'630CSi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'633CSi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'635CSi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'640i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'640i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'640i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'640i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'640i xDrive Gran Turismo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'645Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'650Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'650i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'650i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'650i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'650i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'733i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'735i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'735iL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740e xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740iL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740Ld xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740Le xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740Li')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'740Li xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'745e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'745e xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'745i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'745Le xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'745Li')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'750i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'750i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'750iL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'750Li')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'750Li xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'760i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'760i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'760Li')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'840Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'840i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'840i Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'840i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'840i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'850Ci')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'850CSi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'850i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'ActiveHybrid 3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'ActiveHybrid 5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'ActiveHybrid 7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina B6 Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina B6 xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina B7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina B7 xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina B7L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina B7L xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina B8 Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Alpina XB7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Bavaria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Dixi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'i3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'i3s')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'i4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'i7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'i8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Isetta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'iX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'iX xDrive40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'iX xDrive50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'iX3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'L6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'L7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M135i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M140i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M235i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M235i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M235i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M240i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M240i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M340i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M340i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M440i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M440i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M440i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M550i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M6 Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M760i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M760Li xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M8 Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M850i xDrive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'M850i xDrive Gran Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Mar-20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Wartburg')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'X1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'X2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'X3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'X4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'X5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'X6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'X7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Z3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Z4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 43, N'Z8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 44, N'Mark B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 44, N'Mark C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 44, N'Mark D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 44, N'Mark E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 45, N'Hansa 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 45, N'Hansa 1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 45, N'Hansa 2400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 45, N'Isabella')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 46, N'SV-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'401')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'402')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'403')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'404')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'405')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'406')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'407')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'408')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'409')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'410')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 47, N'411')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Chiron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Divo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 37A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 43A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 57')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 57C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Type 57SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 48, N'Veyron 16.4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Allure')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Apollo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Cascada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Centurion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Century')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Century Series 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Commercial Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Electra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Enclave')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Enclave Avenir')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Encore')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Encore GX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Envision')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Estate Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Gran Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'GS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'GS 350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'GS 400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'GS 455')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Invicta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'LaCrosse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'LeSabre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Limited Series 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Limited Series 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Lucerne')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Model 10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Model 16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Model 31')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Model 6A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Opel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Park Avenue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Rainier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Reatta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Regal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Regal Sportback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Regal TourX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Rendezvous')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Riviera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Roadmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Roadmaster Series 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Roadmaster Series 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Roadmaster Series 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Series 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Series 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Series 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Series 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Series 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Series K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Skyhawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Skylark')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Somerset')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Somerset Regal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Special 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Special Series 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Special Series 40-A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Special Series 40-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Sportwagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Standard Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Super Series 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Terraza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Verano')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 49, N'Wildcat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 50, N'Falcon 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 51, N'30FT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 51, N'35FT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 51, N'40FT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 51, N'60FT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'341')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'341 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'341 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'353')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'355 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'355 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'355 C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'355 D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'370 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'370 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'370 C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'370 D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'452')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'452 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'452 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'452 C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'452 D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'60 Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Allante')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'ATS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'BLS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Brougham')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Calais')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Catera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Cimarron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Commercial Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'CT4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'CT5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'CT6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'CTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'DeVille')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'DTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Eldorado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'ELR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Escalade')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Escalade ESV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Escalade EXT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Fleetwood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'LYRIQ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Model T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 60 Fleetwood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 60 Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 60 Special Fleetwood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 61')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 62')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 63')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 67')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 70 Fleetwood Eldorado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 75 Fleetwood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Series 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Seville')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'SRX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'STS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Type 51')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Type 53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Type 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Type 57')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Type 59')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'Type 61')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'V-63')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'XLR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'XT4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'XT5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'XT6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 52, N'XTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 53, N'Phett')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 53, N'Sabre 5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 53, N'TJ5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 53, N'TJ6500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 53, N'TJ7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 53, N'TJ9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Jay-Eye-See')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model 25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model 35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model O')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model V-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model W')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 54, N'Model Y')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 55, N'CT660')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 55, N'CT680')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 55, N'CT681')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'AH-28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'AMTV-COACH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'AMTV-PM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'AMTV-TM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'CNG-28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'Power Tram')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'RT-52')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'Street Car')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 56, N'Sunliner-COACH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 57, N'Model 32A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 57, N'Model 33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 57, N'Model 35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (58, N'Alsvin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (58, N'CS35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (58, N'CS55 Plus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (59, N'V8100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A11E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A8B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'A9L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'Aerobus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'Marathon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'Superba')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (60, N'Taxicab')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'3B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'3C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'3D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'3E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'3F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'3G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'490')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'AE Independence Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'AJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'AK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'AL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'AM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'AN')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Astra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Astro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Avalanche')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Avalanche 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Avalanche 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Aveo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Aveo5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'B60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'B7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Beat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Bel Air')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Beretta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'BG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Biscayne')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'BJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'BK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'BL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (61, N'Blazer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'BM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'BN')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Bolt EUV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Bolt EV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Brookwood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Bruin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C10 Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C10 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C10 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C20 Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C20 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C20 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C30 Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C30 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C3500HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C4500 Kodiak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C5500 Kodiak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C60 Kodiak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C6500 Kodiak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C70 Kodiak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C7500 Kodiak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'C8500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Camaro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Capitol')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Capitol Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Caprice')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Captiva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Captiva Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Cargo Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Cavalier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Celebrity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Chevelle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Chevette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Chevy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Chevy II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Chevy Monza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Chevy Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Cheyenne')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Citation')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Citation II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'City Express')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'CK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Cobalt')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Colorado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Commercial Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Confederate')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Confederate BB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Corsa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Corsica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Corvair')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Corvair Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Corvette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Cruze')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Cruze Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Cruze NG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'DB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Del Ray')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'DJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'DP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'DR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'DS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Eagle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Eagle CB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'El Camino')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Epica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Equinox')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Estate')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Express 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Express 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Express 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Express 4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Express Cargo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Express Pasajeros')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'FB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Fleetline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Fleetline Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Fleetmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Fleetmaster Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'G10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'G10 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'G20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'G20 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'G30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'G30 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'GC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'GD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'GE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'GP3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Groove')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Grove')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'H70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'H80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'H90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'HC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'HE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'HHR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Impala')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Impala Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'International')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'International AC Series Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'J70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'J80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'J90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'JA Master Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'JC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'JD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K10 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K10 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K20 Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K20 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K20 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K30 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'K5 Blazer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'KC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'KD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'KF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Kingswood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'KP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'L30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Laguna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 3500HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 4500HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 4500XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 5500HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 5500XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LCF 6500XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LLV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Lumina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Lumina APV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Lumina Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'LUV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Luv Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Malibu')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Malibu Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Master')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Master 85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Master Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Master Deluxe Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Master Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Matiz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Mercury')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Meriva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Metro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Model T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Monte Carlo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Monza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'National')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'National Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Nomad')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Nova')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Nuevo Aveo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'One-Fifty Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Onix')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Optra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Orlando')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P10 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P10 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P20 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P20 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P30 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P30 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'P6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Parkwood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Prizm')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R10 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R20 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'R3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'S10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'S10 Blazer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'S10 Max')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'S7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 1500 Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 1500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 1500 HD Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 1500 LD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 1500 LTD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 1500 Nueva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 2500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 2500 HD Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 3500 Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 3500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 4500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 5500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Silverado 6500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Sonic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Sonora')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Spark')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Spark Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Spark EV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Special Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Spectrum')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Sprint')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'SS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'SSR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Standard Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Styleline Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Styleline Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Stylemaster Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Suburban 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Suburban 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Suburban 3500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Superior')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Superior Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'T6500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'T7500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'T8500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Tahoe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Tigra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Tornado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Tornado Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Townsman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Tracker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Trailblazer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Trailblazer EXT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Traverse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Trax')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Two-Ten Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Universal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Universal Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Uplander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V10 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V20 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'V3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'VA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Vectra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Vega')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Venture')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Volt')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'W3500 Tiltmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'W4500 Tiltmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'W5500 Tiltmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'W5500HD Tiltmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'W6500 Tiltmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'W7500 Tiltmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'WA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Yeoman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'YR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 61, N'Zafira')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 62, N'Tiggo 7PRO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 62, N'Tiggo 8PRO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'300M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airflow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airflow Series C-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airflow Series CU')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airstream Deluxe Series C-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airstream Deluxe Series CZ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airstream Series C-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airstream Series C-7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Airstream Series CZ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Aspen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Breeze')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C23')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C26')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C34')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'C37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Chrysler R/T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Cirrus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Concorde')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Conquest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Cordoba')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Crossfire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Crown Imperial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Custom Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Daytona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Deluxe Series CD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Dynasty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'E Class')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Executive Limousine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Executive Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Fifth Avenue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Grand Caravan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Grand Voyager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Airflow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Airflow Series C-2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Airflow Series CV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial C-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Custom Airflow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Custom Airflow Series C-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Custom Airflow Series CW')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Custom Airflow Series C-W')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Custom Airflow Series CX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Custom Series CL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Imperial Series CQ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Intrepid')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Laser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'LeBaron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'LHS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Model B-70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Nassau')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Neon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'New York Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'New Yorker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Newport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Pacifica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Phantom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Prowler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'PT Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Royal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Royal Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Royal Series CT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Royal Windsor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Saratoga')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Saratoga Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Sebring')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 52')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 58')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 62')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 77')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series 80 L Imperial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series CP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series E-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series E-80 Imperial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series Finer 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series G-70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series H-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series I-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Series Six CM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Shadow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Spirit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'St Regis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Standard Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Stratus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'TC Maserati')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Town & Country')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Traveler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Valiant')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Volare')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Voyager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Windsor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 63, N'Windsor Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 64, N'202')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 64, N'202MM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 64, N'D46')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'2CV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'AMI-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'D Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'D21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'DS19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'DS21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'DS21 Pallas')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'ID19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 65, N'SM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 66, N'Model 31')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 66, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 66, N'Model 41')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 66, N'Model 42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 66, N'Model 43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 67, N'Arriva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 67, N'Platinum')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 67, N'Platinum III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Concord')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Encounter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Freelander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Freelander Premier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Galleria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Leprechaun')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Leprechaun Premier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Mirada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Mirada Select')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Nova')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Orion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Prism Elite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Pursuit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Sportscoach RD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 68, N'Sportscoach SRS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 69, N'Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Aero Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Apr-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Aug-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Fifty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Forty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Jun-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Jun-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Model 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Series 870')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Series 890')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 70, N'Sixty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 71, N'Ace')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 71, N'Beacon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 71, N'Flyer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 72, N'810')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 72, N'812')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 72, N'L-29')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Affinity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Allure')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Allure 470')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Concept')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Inspire 330')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Inspire 360')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Intrigue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Intrigue 530')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Intrigue 550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Intrigue LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Magna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 73, N'Magna 630')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'Affinity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'Allure')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'Inspire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'Intrigue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'Islander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'LEXA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'LTC Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'Magna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 74, N'Tribute')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Centurion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Century II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Drill Rig')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Equipment Carrier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Glider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'IFL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'IRL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'ISL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Low Entry')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Low Entry Drop Frame')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'Recycling Equipment')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 75, N'School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Crosley')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Farm-O-Road')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Hot Shot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Super Shot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 76, N'Super Sports')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 77, N'Motorhome')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 77, N'School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Continental')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Model J')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Model R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Series V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Series V-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Series V-5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Series V-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 78, N'Series V-7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 79, N'Lanos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 79, N'Leganza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 79, N'Nubira')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 80, N'44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 80, N'55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 80, N'600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 80, N'750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 80, N'American')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 80, N'Daffodil')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 81, N'Charade')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 81, N'Rocky')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'104')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'4.5-Liter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Conquest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'DB18')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'DE27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'DE36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'DK400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Empress')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Majestic Major')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Regency')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Regina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Sovereign')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'SP250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Special Sports')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 82, N'Sportsman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 83, N'Challenger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 83, N'Daybreak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 83, N'Escaper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 83, N'Tuscany')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 83, N'Ultrasport LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 84, N'Darrin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'200SX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'240Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'260Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'280Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'280ZX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'410')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'411')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'510')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'520 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'521 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'610')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'620')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'620 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'710')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'720')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'810')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'B110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'B210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Bluebird')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'F10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Maxima')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Patrol')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Sakura')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Samurai')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 85, N'Station Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 71')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 91')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 92')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 93')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 98')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 86, N'Series 99')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 87, N'Mangusta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 87, N'Pantera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 87, N'Vallelunga')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 88, N'Continental')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-6 64')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-6 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-6 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-8 105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-8 120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-8 15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-8 85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-8C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 89, N'D-8S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'134')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'135')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'135M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'135MS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'148L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'175')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'178')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 90, N'235')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 91, N'MK I')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 91, N'MK IIC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 91, N'MK IIE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 91, N'MK III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 91, N'MK V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 91, N'Mk VI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 92, N'DMC 12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 93, N'ProView')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 94, N'1300 Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 94, N'1500 Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Adventurer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Airflow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Airflow III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Airstream')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Deluxe Airstream')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'DeSoto')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Firedome')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Fireflite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Firesweep')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Model CF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Model CK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Model SA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Model SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Model SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'Powermaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'S-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 95, N'SS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 96, N'750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 96, N'850')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 97, N'C116')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 97, N'C120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 98, N'Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Brighter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Buller')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Hustler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Linner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Outsider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Picker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Ridder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 99, N'Runner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 100, N'Viaggio 1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 101, N'03-Jun')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 101, N'1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 101, N'4CV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 101, N'750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 101, N'F11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 101, N'F12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 101, N'Junior Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'2000 GTX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'330')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'440')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'880')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'A100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'A100 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'A100 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'A108 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Aries')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Aspen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Atos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Attitude')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Avenger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B-1 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B100 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B-2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B200 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B-3 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B300 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'B-4 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C-1 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'C900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Caliber')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Caravan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'CB300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Challenger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Charger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Colt')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Conquest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Coronet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'CT700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'CT800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'CT900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Custom Series D-19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Custom Series D-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D100 Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D100 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D100 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D100 Town Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D100 Town Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D200 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D200 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D300 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D300 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'D700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Dakota')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Dart')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Daytona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Deluxe Series D-19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Deluxe Series D-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Diplomat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'DM350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Durango')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Dynasty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Grand Caravan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'H100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'H100 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Hornet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'i10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Intrepid')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Journey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'L600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'L700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Lancer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'M300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'M350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'M375')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'M400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Magnum')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Matador')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'MB300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Meadowbrook')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Mini Ram')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Mirada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Model 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Model 30-35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Monaco')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'NC900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'NCT1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'NCT900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Neon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Nitro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Omni')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P100 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P200 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P300 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P300 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P310 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P320 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P375')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P400 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P410 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P420 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'P450 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'PC500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'PC600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'PD500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'PD600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Phoenix')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Pioneer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Polara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Power Ram 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Power Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'R300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'R400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Raider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 1500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 2500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 3500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 4000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ram 5500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Ramcharger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Rampage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'RD200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'RM300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'RM350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'RM400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Royal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Royal Monaco')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'S500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'S600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Seneca')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Series D2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Series DK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Shadow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Sierra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Spirit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Sprinter 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Sprinter 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'St. Regis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Stealth')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Stratus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'SX 2.0')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Texan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Van 1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'VC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'VD15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'VD20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'VD21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Verna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Victory Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Viper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Vision')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W100 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W100 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W100 Town Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W200 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W200 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W300 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W300 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'W500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Wayfarer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'WC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'WD15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'WD20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'WD21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'WDX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'WF-31')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'WFA-31')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Wm300 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 102, N'Wm300 Power Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 103, N'Doretti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 104, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 104, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 104, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 104, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 104, N'Model E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 104, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 105, N'240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 105, N'500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 105, N'L6.4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 106, N'Model J')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 106, N'Model JN')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 106, N'Model SJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D8400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D9400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D9500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D960')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D9600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'D9800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 107, N'L100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 610')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 612')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 614')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 617')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 619')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 621')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model A22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model B22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model M2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 108, N'Model M4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 109, N'Duryea')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Carri-Go')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'DX3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Dynaquest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Dynaquest XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Grand Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Grand Sport GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Grand Sport GT Toy Hauler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Grand Sport M2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Grand Sport Ultra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Isata 3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Isata 5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 110, N'Isata F-Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 111, N'2000 GTX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 111, N'Medallion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 111, N'Premier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 111, N'Summit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 111, N'Talon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 111, N'Vision')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 111, N'Vista')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 112, N'Eagle 10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 112, N'Eagle 15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 112, N'Eagle 15S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 112, N'Eagle 20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 112, N'Eagle 35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 112, N'Eagle 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 113, N'Bermuda')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 113, N'Citation')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 113, N'Corsair')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 113, N'Pacer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 113, N'Ranger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 113, N'Roundup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 113, N'Villager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 114, N'Axess')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 114, N'Escort RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 114, N'E-Z Rider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 114, N'E-Z Rider II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 114, N'E-Z Rider II Max')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 114, N'Transmark RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 114, N'Transmark XHF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 22-7-R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 22-K-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 4-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 4-55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 6-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 6-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 6-65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 6-70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 75A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 86')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 8-78')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 8-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 8-81')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 8-82')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 8-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 8-91')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model 96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 115, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 116, N'Competition')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 116, N'Courier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 117, N'Emergency One')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Accolade')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Accolade XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Anthem')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Aspire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Emblem')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Ethos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Ethos LI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Insignia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Odyssey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Reatta XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 118, N'Vision XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 119, N'Model 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 119, N'Model 51')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 119, N'Model 52')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 119, N'Model 53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 120, N'Challenger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 120, N'Essex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 120, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 120, N'Pacemaker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 120, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 120, N'Super Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 120, N'Terraplane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 121, N'S 215 HDH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 121, N'S 407')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 121, N'S 417')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 122, N'Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 122, N'Phaeton')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'Excellence')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'Facel 6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'Facel II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'Facel III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'Facellia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'FV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'FV1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'FVS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 123, N'HK500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 124, N'Atom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 124, N'Atomata')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 124, N'Electrina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 124, N'Electron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 124, N'Zeta Super Sports')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 125, N'Model 12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'A100 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'A108 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'B100 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'B200 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'B300 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'D100 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'D100 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'D110 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'D200 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'D200 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'D210 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'F100 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'F100 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'F1B Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'F2B Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'F3B Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'F4B Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC1B Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC1B Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC1C Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC3B Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC3B Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC3C Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC4B Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC4B Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FC4C Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FD1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FE1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FE1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FE1 Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FE2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FG1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FG1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FG1 Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FG2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FH1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FH1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FH2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FJ1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FJ1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FJ2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FK1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FK1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FK2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FK6 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FK6 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FK8 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FK8 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FL1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FL1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FL2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FL6 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FL6 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FL8 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FL8 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FM1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FM1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FN1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FN1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FO1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FO1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FO2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FP1 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FP1 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FP2 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FW100 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'FW100 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'P100 Parcel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'P200 Parcel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'P300 Parcel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'W100 Panel Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'W100 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'W110 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 126, N'W200 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'420G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'460D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'ELAM 1305D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'ELAM 1607D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'ELAM 2211D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'ELAM HANG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'ELAM SKY V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'F1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'F4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'F5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'GF3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'GF5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 127, N'GF5000T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 128, N'Federal Motors')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 129, N'Fire Apparatus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'166')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'195')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'212')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'250 Europa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'250 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'250 GTE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'250 LM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'275 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'275 GTB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'275 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'275 LM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'296 GTB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'296 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'308 GTB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'308 GTBi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'308 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'308 GTSi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'328 GTB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'328 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'330 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'330 GTC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'330 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'340 America')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'342 America')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'348 GTB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'348 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'348 Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'348 TB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'348 TS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'360')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GT4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GT4 BB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GTB/4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GTC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GTC/4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'365 GTS/4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'375 America')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'400 Superamerica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'410 Superamerica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'412')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'456 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'456 GTA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'456 M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'456 M GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'456 M GTA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'458 Italia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'458 Speciale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'458 Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'488 GTB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'488 Pista')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'488 Pista Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'488 Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'500 Superfast')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'512 BB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'512 M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'512 TR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'550 Maranello')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'575 M Maranello')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'599 GTB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'599 GTO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'612 Scaglietti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'812 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'812 Superfast')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'California')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'California T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Dino 206 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Dino 246 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Dino 246 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Dino 308 GT4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Enzo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F12 Berlinetta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F12tdf')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F355')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F355 Berlinetta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F355 F1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F355 GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F355 Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F8 Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'F8 Tributo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'FF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'GTC4Lusso')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'GTC4Lusso T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'GTO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'LaFerrari')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Mondial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Mondial 3.2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Mondial 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Mondial t')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Portofino')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Portofino M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Roma')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'SF90 Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'SF90 Stradale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Superamerica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 130, N'Testarossa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'1100D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'124')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'124 Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'128')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'131')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'1900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'2100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'500L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'500X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'600D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'850')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'8V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Albea')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Argo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Brava')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Bravo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Ducato')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Idea')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Linea')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Mobi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Palio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Panda')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Pulse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Punto')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Stilo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Strada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Tipo Zero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'Uno')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 131, N'X-1/9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 132, N'Karma')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Bounder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Bounder Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Discovery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Discovery LXE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Excursion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Expedition')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Fiesta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Flair')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Jamboree')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Jamboree Searcher')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Jamboree Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Jamboree Sport DSL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Pace Arrow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Pace Arrow LXE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Providence')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Revolution LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Southwind')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Southwind Storm')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Storm')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Terra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Terra LX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Terra Premium Edition')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Tioga')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 133, N'Tioga Ranger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Junior')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Junior Z-18')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Model 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Model 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Model B-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Model E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Model E-55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Model E-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 134, N'Model H-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 135, N'870')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 135, N'Metro 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 135, N'Metro 35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 135, N'Metro 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'1 Ton Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'1/2 Ton Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'3/4 Ton Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'A9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'A9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Aerostar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Anglia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Aspire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'AT9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'AT9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B-100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B-150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B-200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B-200 Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'B800F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Bronco')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Bronco II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Bronco Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'C600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'C700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'C7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'C800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'C8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'C900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Capri')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CF6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CF7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CF8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CFT8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CL9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CLT9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Club')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Club Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'C-Max')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Consul')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Contour')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Cortina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Cougar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Country Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Country Squire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Courier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Courier Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Crestline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Crown Victoria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CT8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'CT800D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Custom 300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Custom 500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Customline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Del Rio Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-100 Econoline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-100 Econoline Club Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-150 Club Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-150 Econoline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-150 Econoline Club Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-200 Econoline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-250 Econoline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-250 Econoline Club Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-300 Econoline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-350 Club Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-350 Econoline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-350 Econoline Club Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-350 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-450 Econoline Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-450 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-550 Econoline Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-550 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Econoline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Econoline Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Econoline Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Econoline Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'EcoSport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Edge')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Elite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Escape')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Escort')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'E-Transit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Excursion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'EXP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Expedition')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Explorer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Explorer Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Explorer Sport Trac')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-100 Ranger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-150 Heritage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-150 Lightning')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-250 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-250 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-350 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-450 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-550 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F59')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F600 LPO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F-600 Super Duty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F650')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F700 LPO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F800 LPO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'F8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Fairlane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Fairmont')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Falcon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Falcon Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Festiva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Fiesta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Fiesta Ikon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Figo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Five Hundred')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Flex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Focus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Ford')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Freestar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Freestyle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'FT800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'FT8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'FT900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Fusion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'G-100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Galaxie')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Galaxie 500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Ghia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'GPW')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Gran Torino')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Granada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Grand Marquis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'GT40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Ikon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Ka')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L8000F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L8501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L8511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L8513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L9501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L9511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'L9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LA8000F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LA9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LCF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LL9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LLA9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LLS9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LN600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LN700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LN7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LN800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LN8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LN900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LN9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LNT800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LNT8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LNT8000F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LNT900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LNT9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Lobo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LS8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LS8000F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LS9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT8000F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT8501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT8511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT8513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT9501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT9511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LT9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTA9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTD Crown Victoria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTD II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTL9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTLA9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTLS9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTS8000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTS8000F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'LTS9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'M-400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'M-450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Mainline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Maverick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 1 GA Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 11 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 18')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 2 GA Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 21 A Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 40 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 46')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 67')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 68')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 74')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 78')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 81 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 82 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model 85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model AA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model AC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model BB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Model TT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Mondeo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Mustang')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Mustang II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Mustang Mach-E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Mystique')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'P-100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'P-350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'P-400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'P-500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'P600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'P800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Park Lane Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Pinto')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Police Interceptor Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Police Interceptor Utility')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Police Responder Hybrid')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Prefect')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Probe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Ranch Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Ranchero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Ranger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Sable')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Skyliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Special Service Police Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Sprint')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Squire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'SSV Plug-In Hybrid')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Starliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Station Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Sunliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Super Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Taunus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Taurus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Taurus X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Tempo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Thunderbird')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Topaz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Torino')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit Connect')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit Courier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit-150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit-250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit-350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Transit-350 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Victoria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Windstar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Zephyr')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 136, N'Zodiac')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Berkshire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Berkshire XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Charleston')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Forester')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Forester GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Forester LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Forester MBS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Georgetown')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Georgetown GT3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Georgetown GT5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Georgetown VE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Lexington')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Lexington GTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Sunseeker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Sunseeker LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Sunseeker MBS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 137, N'Sunseeker TS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 138, N'Motorhome Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 1724')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 1839')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 1935')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 1938')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 1944')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 2544')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 3344')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Auman 3938')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 1015')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 1116')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 1217')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 1319')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark 7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark S1016')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark S613')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark S614')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Aumark S815')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'AUV Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Forland')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'Ollin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'OLN Aumark 4000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'OLN Aumark 5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'OLN Aumark 6500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 139, N'OLN Aumark 7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Chateau')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Chateau Citation')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Chateau Kodiak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Dutchmen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Four Winds')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Hurricane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Magellan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Serrano')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Siesta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 140, N'Windsport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Airman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 10 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 10 C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 11 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 11 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 135')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 137')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 145')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 147')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model 9B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model K6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Model Six 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Olympic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Series 15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Series 15 Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Series 9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Twelve')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 141, N'Type H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 142, N'Frazer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 142, N'Manhattan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Continental')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Fast Roadster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Foursome Cabriolet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Le Mans Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Le Mans Replica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Mille Miglia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Sebring')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 143, N'Targa Florio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'108SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'114SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'122SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Argosy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'B2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Business Class M2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Cascadia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Century Class')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Classic XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Columbia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Condor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Coronado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'EconicSD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FB65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FC70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FC80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FL106')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FL112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FL360')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FL50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FL60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FL70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FL80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLA086')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLC112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLC120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLD112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLD120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLD120SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLD132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLL086')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FLT086')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'FS65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'M2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'M2 100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'M2 106')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'M2 112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'M2 T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MB Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MB60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MB70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MC Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MCL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MT35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MT45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'MT55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'S2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'S2C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'S2G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'S2RV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Sport Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Sprinter 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Sprinter 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Sprinter 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Sprinter 3500XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'Sprinter 4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'V Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XB Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XB Raised Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XB Straight Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XBA ARBOC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XC Formed Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XC Lowered Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XC Modular Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XC Raised Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 144, N'XC Straight Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 145, N'Badger FWD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 145, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 146, N'America')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 146, N'BXU')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 146, N'C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 146, N'Cranecarrier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 146, N'R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Line 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 136')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 140')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 148')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 158')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 6 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 8-75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 8-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 8-85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 8-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model 8-95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 147, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 148, N'G70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 148, N'G80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 148, N'G90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 148, N'GV60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 148, N'GV70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 148, N'GV80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 149, N'3000 FE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 149, N'Genesis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 149, N'Genesis RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 150, N'Metro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 150, N'Prizm')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 150, N'Spectrum')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 150, N'Storm')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 150, N'Tracker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 151, N'2WMX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 151, N'C116')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF3600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 152, N'GF900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 153, N'City Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 153, N'City Transit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 153, N'Low Floor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 153, N'Motorhome')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 153, N'School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 153, N'Shuttle Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'1204')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'1300 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'1304')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'1600 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'1700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'1700 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'2600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 154, N'3000 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'1000 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'100-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'100-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'102-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'1500 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'150-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'150-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'2500 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'250-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'250-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'253-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'280-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'300-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'350-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'350-27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'350-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AC100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AC150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AC250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AC252')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AC300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Acadia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Acadia Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AF230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AF240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AFP230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'AFP240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Astro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'B3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'B6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'B7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Brigadier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C15 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C15/C1500 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C15/C1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C25 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C25/C2500 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C25/C2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C35/C3500 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C3500HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C4500 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C5000 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C5500 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C6000 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C6500 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C7000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C7000 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C7500 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'C8500 Topkick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Caballero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Canyon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CC100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CC101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CC102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CC150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CC250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CC260')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CC300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CCV100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'CCX250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC152')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC251')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC252')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC282')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC283')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EC350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EF240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EF241')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EF242')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EF350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'EFP240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Envoy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Envoy XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Envoy XUV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'F350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'F350-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'F350-27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'F370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC100-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC152')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC251')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC252')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC253')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC281')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC283')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FC350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FCS300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FCS350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FF350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FM340')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FM350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'FP152')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G1000 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G15/G1500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G25/G2500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G35/G3500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'G3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'General')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Hummer EV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'I1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'I1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'I2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'I3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Jimmy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K1000 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K15 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K15/K1500 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K15/K1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K25 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K25/K2500 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K25/K2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K35/K3500 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'K3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'L3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'LI3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'M300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'M340')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'M350-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'M350-27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P15/P1500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P150-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P152')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P25/P2500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P252')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P253')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P35/P3500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'P6500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PB1000 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PB15 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PB1500 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PB25 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PB2500 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PB2500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PB3500 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM150-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM150-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM151')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM152')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM152-22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM153')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM250-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM251')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM252')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PM253')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'PV1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'R1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'R1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'R2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'R2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'R3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'S15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'S15 Jimmy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'S300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'S300-24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'S370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Safari')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Savana 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Savana 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Savana 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Savana 4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 1500 Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 1500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 1500 HD Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 1500 Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 2500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 2500 HD Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 3500 Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra 3500 HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sierra Nueva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sonoma')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Sprint')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Syclone')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T145')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T14A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T14B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T155')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T16L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T6500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'T7500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Terrain')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Tracker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Transit Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Transmode')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Typhoon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'V1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'V1500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'V2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'V2500 Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'V3000 Forward Control')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'V3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'W3500 Forward')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'W4500 Forward')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'W5500 Forward')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'W5500HD Forward')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'W6500 Forward')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'W7500 Forward')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Yukon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Yukon XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Yukon XL 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 155, N'Yukon XL 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 156, N'T300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 156, N'T400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 156, N'T700 Royal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 156, N'TS300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 156, N'TS400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 157, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 157, N'GP700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 157, N'GP900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 157, N'Tiger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 158, N'GK1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 158, N'IT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Cavalier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Cavalier Model 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Crusader')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Crusader Model 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom  57 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom 834')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom 8-71')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom Hollywood Model 113')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom Model 107')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom Model 108')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom Model 69')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom Model 97')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Custom Special 96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Deluxe Model 107')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Deluxe Model 108')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Graham')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 57')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 57 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 621')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 64')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 67')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 68')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 69')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 74')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Model 97')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Prosperity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Series 116')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Series 120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Special 820')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Special 822')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Special Model 96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 159, N'Standard Model 96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 610')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 612')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 614')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 615')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 619')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 621')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 629')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 827')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 835')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 160, N'Model 837')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 161, N'27 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 161, N'30 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 161, N'33 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 161, N'35 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 161, N'38 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 162, N'EV250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 162, N'EV350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 162, N'EVC210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 162, N'EVS300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 163, N'200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 163, N'Griffith')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Bounty Hunter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'BT Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest B-Touring Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest B-Touring GX2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest Limited Edition')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest Ultra Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Conquest Yellowstone')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Crescendo SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Independence')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Independence Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Sun Voyager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Sunsport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Super Nova')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Tour Master')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 164, N'Yellowstone')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 165, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 46')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 57')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 166, N'Model 77')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 167, N'Series II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 167, N'Series III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 167, N'Series IV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 167, N'Series VI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 168, N'Healey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 168, N'Silverstone')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'Bullet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'Bullet Glider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'Crane/Drill Rig')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'Dockmaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'FC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'Firetruck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'T-Glider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'VT 100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 169, N'VT Glider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 170, N'Corsair')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 170, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 170, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 170, N'Vagabond')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 171, N'D-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 172, N'Husky')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 172, N'Minx')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 172, N'Super Minx')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'145')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'155')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'165')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'185')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'195')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'195DC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'195h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'195h DC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'198')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'238')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'258')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'258ALP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'258LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'268')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'268A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'308')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'338')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'338CT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'358')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'BF1524M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'BF918G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'BF918K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'BR1425S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FA14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FA1415')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FA15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FA1517')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FB14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FB15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FB1715')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FB1817')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FD16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FD17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FD20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FD2218')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FD2218LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FD2220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FD2320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FE16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FE17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FE19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FE20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FE2618')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FE2620')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FF17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FF19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FF20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FF23')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FF3018')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FF3020')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FFC1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FG19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'FG22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'GC17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'GC20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'L6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'L7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'L8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SF17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG23')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG231')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG3320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG3323')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG3325')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'SG5523')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'XL7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 173, N'XL8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 174, N'H6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 174, N'H6B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 174, N'H6C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 174, N'J12 Type 68')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 174, N'K6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Admiral')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Admiral SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Admiral SVE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Ambassador')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Arista')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Armada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Atlantis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Atlantis SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Augusta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Augusta B+')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Augusta Touring Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Endeavor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Imperial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Navigator')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Neptune')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Scepter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Vacationer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Vacationer XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 175, N'Vesta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Accord')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Accord Crosstour')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'BR-V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'City')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Civic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Civic del Sol')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Clarity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Clarity Plug-In Hybrid')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Crosstour')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'CR-V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'CRX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'CR-Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Element')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'EV Plus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Fit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'HR-V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Insight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Odyssey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Passport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Pilot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Prelude')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Ridgeline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'S2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 176, N'Wagovan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 177, N'Gregoire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 178, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 178, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Big Boy Series 18')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Big Boy Series 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Big Boy Series 96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Challenger Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Custom Series 15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Custom Series 17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Custom Series 25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Series 12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Series 14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Series 22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Series 24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Commodore Series 27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Country Club Eight Series 47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Country Club Series 43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Country Club Series 87')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Country Club Series 93')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Country Club Series 95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Custom Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Custom Eight Series 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Custom Eight Series 77')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Custom Series 83')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Custom Series 85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Custom Series 97')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Custom Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Country Club Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Eight Series 66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Eight Series 74')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Eight Series 76')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Series 112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Series 20 P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Series 40 P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Series 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Series 84')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Deluxe Series 89')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Hornet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Hornet Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Italia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Jet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Jetliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Major Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model 20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model 33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model 37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model 54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model O')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Model U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Pacemaker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Pacemaker Major')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Pacemaker Series 91')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Pacemaker Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Pacemaker Super Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Rambler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Series 44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Series 92')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Series L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Series T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Series U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Special Country Club Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Special Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Jet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Series 11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Series 21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Series 41')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Super Wasp')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Terraplane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Traveler Series 10 T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Traveler Series 20 T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Traveler Series 40 T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Utility Series 10 C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Utility Series 89')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 179, N'Wasp')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 180, N'Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 180, N'Imperial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 180, N'Pullman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 180, N'Snipe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 180, N'Super Snipe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 181, N'H1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 181, N'H2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 181, N'H3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 181, N'H3T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Century Eight  Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Century Series 125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Century Series A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Century Series M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Century Six Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model 20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model 20-E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model 32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model A-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model E-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model E-2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model R-14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model R-15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Model U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 417-W')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 421-J')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 427-T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 517-W')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 518-D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 521-J')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 521-O')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 527-T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 618-D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 618-G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 621-N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 621-O')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 822-E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 822-ES')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series 825-H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series B-216')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series C-221')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series E-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series F-222')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series F-322')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series F-442')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series H-225')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series I-226')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series I-326')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series I-426')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series K-321')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series K-421')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series KK-321A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series KK-421A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series L-218')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series S-214')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Series V-237')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 182, N'Skylark')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Accent')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Azera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Creta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Creta Grand')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Elantra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Elantra Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Elantra GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Elantra N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Entourage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Equus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'EX6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'EX8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Excel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Genesis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Genesis Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Grand i10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'H200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'H300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'H400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'H500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'HD55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'HD65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'HD78')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'HLD 150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'HMD 230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'HMD 260')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Ioniq')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Ioniq 5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'ix35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Kona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Kona Electric')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Kona N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Nexo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Palisade')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Pony')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Santa Cruz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Santa Fe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Santa Fe Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Santa Fe XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Scoupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Sonata')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Starex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Stellar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Tiburon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Tucson')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Veloster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Veloster N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Venue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'Veracruz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'XG300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 183, N'XG350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'1000 SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'1300 FBC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'1652 SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'3000 Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'3000 IC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'3200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'3300 Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'3800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'AC Commercial Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'AE School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'AR School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'BE Commercial Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'BE School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'CE Commercial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'CE Integrated')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'CE School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'FE Commercial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'FE Integrated')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'FE School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'HC Integrated Commercial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'RE Commercial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'RE Integrated')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'RE School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 184, N'TC Commercial Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 185, N'10 Yard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 185, N'10.5 Yard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 185, N'11 Yard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'EX35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'EX37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'FX35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'FX37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'FX45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'FX50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'G20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'G25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'G35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'G37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'I30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'I35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'J30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'JX35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'M30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'M35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'M35h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'M37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'M45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'M56')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'Q40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'Q45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'Q50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'Q60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'Q70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'Q70L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX56')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 186, N'QX80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1000A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1000B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1000C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1000D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1010')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1100A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1100B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1100C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1100D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1200A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1200B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1200C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1200D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1300A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1300B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1300C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1300D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1310M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1452SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1500A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1500B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1500C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1500D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1552SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1652SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1652UPS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1654')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1724')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1754')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1824')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1854')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1924 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1925 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1954')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'1955')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2155')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2275')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2276 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2375 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2554')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2574')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2575')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2654')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2674')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'2675')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3000FE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3000IC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3000RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'3900FC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4100 SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4200LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4300LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4400LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4600LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4600UH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4700LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4700LPX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'4900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'5000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'5070')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'5070-RHD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'5500i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'5600i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'5900i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'7100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'7300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'7400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'7500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'7600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'7700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'8100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'8200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'8300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'8500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'8500 TranStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'8600 SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'8600 TranStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'900A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'908B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'908C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9100 SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9100i SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9200 SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9200i SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9400i SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9800 SBA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9900 SFA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9900i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9900i SFA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9900ix')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'9900ix SFA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A100 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'A132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AB120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AB1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AB140')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AB1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AM120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AM130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AM132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AM150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AM80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'AW')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'B132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'C900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Cargostar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CF500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CF600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CityStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CM110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CM75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CM80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CO180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CO190')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CO200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CO220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CO4000 Transtar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CO9670')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'COF5870 Paystar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'COF9670')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CV515')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'CXT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'D1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'D1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'D1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'D1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'D300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'D900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Durastar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F1924')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F1954')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2275')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2276 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2375 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2554')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2574')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2575')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2654')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2674')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F2675')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F5070')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F5070-RHD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F5070-SF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F5070-SF/RHD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F5070-SF/WW')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F5070-WW')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'F9370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G1904')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G1954')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G2105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G2504')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G2554')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G2604')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G2654')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G4700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G4900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G5070')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'G8200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Genesis RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HV507')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HV513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HV607')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HV613')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HX515')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HX520')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HX615')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'HX620')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L111')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L121')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L151')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'L153')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LB140')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LM120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LM121')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LM122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LM150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LM151')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LM153')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LoneStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'LT625')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M Series Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M1400 Metro II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M1600 Metro II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M800 Navy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'M800 Post Office')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MA1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MHC1310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MS1210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MV607')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MV60E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MW')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'MXT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'ProStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R111')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R121')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R131')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'R132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RA120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RA121')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RA122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RH613')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RM120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RM121')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RM122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'RXT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S112')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1624')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1654')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1654LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1723')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1724')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1753')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1754')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1823')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1824')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1853')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1853FC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1854')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1924')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1925')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1954')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S1955')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S2125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S2155')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S2276')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S2375')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S2524')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'S2554')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'SA120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'SA122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Scout')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Scout II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'SM120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'SM122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'SM130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'SM132')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'TerraStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'TranStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Travelall')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'Traveler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'UrbanStar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'WorkStar 7300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'WorkStar 7400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'WorkStar 7600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 187, N'WorkStar 7700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 188, N'Grifo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 188, N'Lele')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 188, N'Rivolta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 188, N'S4 Fidia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 189, N'Tipo 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 189, N'Tipo 8A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 189, N'Tipo 8A S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 189, N'Tipo 8A SS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Amigo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Ascender')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Axiom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Bellel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'ELF 100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'ELF 200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'ELF 300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'ELF 400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'ELF 500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'ELF 600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'ELF 600-BUS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'EVR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Forward 1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Forward 1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Forward 800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'FRR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'FSR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'FTR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'FVR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'FXR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Hombre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'HTR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'HVR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'HXR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'i-280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'i-290')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'i-350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'i-370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'I-Mark')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Impulse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'LT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'MR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'NPR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'NPR-HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'NPR-XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'NQR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'NRR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Oasis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Reach')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Rodeo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Rodeo Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Stylus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'Trooper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 190, N'VehiCROSS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Ellipse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Impulse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Meridian')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Navion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Navion iQ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Reyo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Spirit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Spirit Silver')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Suncruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Sunova')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Sunrise')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Sunstar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 191, N'Tribute')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'Euro 110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'Euro 220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'EuroTurbo 120TA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'EuroTurbo 220T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'EuroTurbo 230T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'EuroTurbo 335T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'EuroTurbo 340T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'EuroTurbo 435T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'EuroTurbo 450T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'Z340T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 192, N'Z450T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'E Sunray')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'E X350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'E10X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'EJ4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'EJ7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'ESEI 1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'ESEI 2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'ESEI 4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'Frison')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'J4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'J7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'SEI 2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'SEI 3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'SEI 4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'SEI 7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'Sunray')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'X200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'X250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 193, N'X350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'2.4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'3.4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'3.8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'340')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'420')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'C-Type')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'D-Type')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'E-Pace')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'F-Pace')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'F-Type')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'I-Pace')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Mark IV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Mark IX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Mark V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Mark VII')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Mark VIII')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Mark X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'MK V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'SS100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'S-Type')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Super V8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'V12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'Vanden Plas')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XFR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XFR-S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJ12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJ6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJ8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJR575')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJRS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XJS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XK120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XK140')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XK150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XK8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XKE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XKR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XKR-S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'XKSS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 194, N'X-Type')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Alante')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Designer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Eagle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Greyhawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Melbourne')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Melbourne Prestige')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Precept')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Precept Prestige')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Redhawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Redhawk SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Seneca')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 195, N'Seneca Prestige')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'475')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'6-226')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'6-230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Cherokee')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'CJ3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'CJ5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'CJ5A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'CJ6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'CJ6A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'CJ7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Comanche')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Commander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Commando')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Compass')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Dispatcher')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'DJ3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'DJ5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'DJ6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'F-134')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'F4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'F4-134')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'FA-134')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'FC150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'FC170')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'FC170HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'FJ3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'FJ3A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'FJ6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Gladiator')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Grand Cherokee')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Grand Cherokee L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Grand Cherokee WK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Grand Wagoneer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-2600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-2700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-2800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-330')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-3600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-3700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-3800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-4600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-4700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'J-4800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Jeepster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Liberty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'M151')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Patriot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Renegade')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Scrambler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'TJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Tornado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Universal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Universal Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Utility')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Utility Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Wagoneer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Willys')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Wrangler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 196, N'Wrangler JK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 197, N'Chesterfield Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 197, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 197, N'Model 472')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 197, N'Model 671')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 197, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 198, N'541')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 198, N'541R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 198, N'541S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 198, N'C-V8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 198, N'Healey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 198, N'Interceptor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 199, N'New Day')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 199, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 200, N'Vigus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Air Line Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Great Line Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Line Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model 6RE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model 8G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model 8JE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model 8T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model MX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Model R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 201, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 202, N'Javelin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 202, N'Jupiter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Carolina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Darrin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Dragon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Manhattan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Traveler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Vagabond')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 203, N'Virginian')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 204, N'Ottawa 4 X 2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 204, N'Ottawa 6 X 4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 204, N'Ottawa T2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 204, N'T2E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 204, N'YT30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 204, N'YT50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 204, N'YT60T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 205, N'GS-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 205, N'GSe-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 205, N'Revero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'13-210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'22-210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'548CH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'C500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'C540')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'C550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K100E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K270')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'K370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'KW45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'KW55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'L700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T170')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T270')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T370')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T380')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T460')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T480')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T600A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T660')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T680')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'T880')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'W900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 206, N'W990')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Amanti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Borrego')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Cadenza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Carnival')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'EV6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Forte')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Forte Koup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Forte5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'K5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'K900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Magentis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Niro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Niro EV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Optima')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Rio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Rio5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Rondo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Sedona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Seltos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Sephia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Sorento')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Soul')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Soul EV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Spectra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Spectra5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Sportage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Stinger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 207, N'Telluride')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 208, N'KF3200C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 209, N'Model 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 209, N'Model 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 209, N'Series 6-73')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 209, N'Series 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 209, N'Series 8-126')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 209, N'Series 8-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 209, N'Series 8-95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 210, N'Agera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 210, N'One:1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 210, N'Regera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 211, N'Firetruck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 212, N'500M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 213, N'1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 213, N'Niva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 213, N'Samara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 213, N'Signet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 214, N'Laforza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'2 1/2 Liter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'3 Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'DHC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'LG6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'LG6 DHC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'M45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'Rapide')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 215, N'Touring')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'350GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'400GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Aventador')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Centenario')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Countach')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Diablo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Espada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Gallardo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Huracan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Islero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Jalpa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Jarama')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'LM American')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'LM002')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Miura')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Murcielago')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Silhouette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Urraco')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Urus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 216, N'Veneno')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 217, N'Leda')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 217, N'Ten')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Appia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Aurelia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Beta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Flaminia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Flavia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Fulvia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Scorpion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Stratos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 218, N'Zagato')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Defender')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Defender 110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Defender 130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Defender 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Discovery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Discovery Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Freelander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Land Rover')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'LR2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'LR3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'LR4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Range Rover')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Range Rover Evoque')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Range Rover Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 219, N'Range Rover Velar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Fleetcliffe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Fleetlands')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Fleetway')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Fleetwind')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 303')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 328')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 340')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 345A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 345B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 345C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Series 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 220, N'Special Series 52')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 221, N'Eighteen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 221, N'Fourteen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 222, N'Free Flight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 222, N'Free Spirit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 222, N'Serenity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 222, N'Unity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 222, N'Wonder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 223, N'Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 224, N'Concord')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 224, N'Minute Man')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 224, N'Model 23')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 224, N'Model 6-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'CT200h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'ES250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'ES300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'ES300h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'ES330')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'ES350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS200t')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS450h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GS460')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GX460')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'GX470')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'HS250h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'IS F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'IS200t')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'IS250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'IS300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'IS350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'IS500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LC500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LC500h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LFA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LS400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LS430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LS460')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LS500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LS500h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LS600h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LX450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LX470')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LX570')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'LX600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'NX200t')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'NX250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'NX300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'NX300h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'NX350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'NX350h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'NX450h+')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RC F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RC200t')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RC300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RC350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RX300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RX330')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RX350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RX350L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RX400h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RX450h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RX450hL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'RZ450e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'SC300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'SC400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'SC430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'UX200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'UX250h')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 225, N'UXh')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'66H Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'76H Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'876H Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'9EL Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Aviator')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Blackwood')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Brunn')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Capri')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Continental')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Corsair')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Cosmopolitan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Lincoln')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Lincoln Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'LS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark IV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark LT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark VI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark VII')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Mark VIII')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'MKC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'MKS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'MKT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'MKX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'MKZ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Model KA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Model KB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Nautilus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Navigator')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Premier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Series K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Town Car')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Versailles')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 226, N'Zephyr')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 227, N'LionC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 228, N'Alexander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 228, N'Arabella')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 228, N'L/600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Gasoline Car')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Gasoline Car Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Gasoline Car Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Junior 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 38 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 8-70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 8-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Model I')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 229, N'Steam Car')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'BI Loader')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'ECO 3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'ECO 3030')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'ECO SA-31')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'ECO SA-33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'ECO SA-33-3070')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO 320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO 3800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO Combo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO D-3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO D-320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO DS-3400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO DS-3800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO MAG-20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO T-25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 230, N'EVO T-28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Eclat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Elan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Eleven')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Elise')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Elite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Emira')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Esprit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Europa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Evora')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Evora GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Exige')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Seven')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 231, N'Super Seven')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 232, N'Air')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'Anthem')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CHN')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CHU')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CS200P Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CS250P Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CS300P Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CS300T Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CTP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CXN')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CXP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'CXU')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'DM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'DMC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'DMM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'FDM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'Granite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'Granite 8 X 4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'GU4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'GU5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'GU7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'GU8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'LC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'LEU')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'LR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'LR600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MD6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MD7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MRE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MRU')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MS200P Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MS250P Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MS300P Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MS300T Mid-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'MV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'Pinnacle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RW')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RWL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'RWS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'TD700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'TerraPro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'Vision')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'WL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 233, N'WS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 234, N'500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 234, N'700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 235, N'RR2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 235, N'RR4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 235, N'TGS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 235, N'TGX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 236, N'Corsaire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 236, N'Pirate')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 237, N'Model 100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 237, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 238, N'GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Big Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'E-75 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Little Marmon Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 34')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 41')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 8-69')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 8-79')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Model D-74')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Roosevelt')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Series 125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Series 16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Series 68')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Series 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Series 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 239, N'Series 78')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'103P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'103PA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'125P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'125PA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'57 Glider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'57L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'57P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'57PA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 240, N'86P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 241, N'Series 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 242, N'SmartBus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'228i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'3200 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'3500GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'3500GTI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'4200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'425')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'430i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'A6/1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'A6G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'A6G/2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'A6GCM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'A6GCS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Biturbo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Bora')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Ghibli')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'GranCabrio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'GranSport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'GranTurismo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Grecale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Indy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Indy America')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Khamsin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Levante')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'MC20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Merak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Mexico')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Mistral')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Quattroporte')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Sebring')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 243, N'Spyder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 244, N'MXT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 245, N'530 LX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 245, N'530 SX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 245, N'Djet5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 245, N'Djet6 Luxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 246, N'Maxim')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Model 22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Model 25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Model 25-C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Model 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Model 35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Model 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 247, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 248, N'57')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 248, N'62')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'3 Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'323')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'616')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'618')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'626')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'808')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'929')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B2200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B2300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B2600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'B4000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Cosmo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'CX-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'CX-30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'CX-5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'CX-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'CX-7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'CX-9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'GLC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Miata')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Millenia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Mizer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'MPV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'MX-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'MX-30 EV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'MX-5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'MX-5 Miata')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'MX-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Navajo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Protege')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Protege5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'R100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Rotary Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'RX-2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'RX-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'RX-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'RX-7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'RX-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 249, N'Tribute')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'540C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'570GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'570S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'600LT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'650S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'675LT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'720S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'765LT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'Artura')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'MP4-12C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 250, N'P1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'10/20 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'10/25 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'10/40/65 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'12/16 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'12/32 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'12/55 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'130 H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'14/30 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'14/60 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'15/20 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'15/70/100 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'170')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'170 D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'170 H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'170 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'170 V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'170S-V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'18/22 HP Simplex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'18/28 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'180A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'180b')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'180C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'180D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190DB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190DC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'190SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'20 HP Simplex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'20/35 HP Landaulet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'200/260 Stuttgart')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'200D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'21/35 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'219')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'220a')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'220b')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'220D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'220S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'220Sb')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'220SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'230S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'230SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'24/100/140 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'240D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'25/65 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'250C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'250S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'250SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'250SEC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'250SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'26/45 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'260 D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'260E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'28 HP Simplex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'28/50 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'28/60 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'28/95 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280CE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'280SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'290')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300 K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300CD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300CE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300SDL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300TD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'300TE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'35 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'350SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'350SDL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'350SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'36/65 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'37/90 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'37/95 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'370 Manheim')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'38/70 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'38/80 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'380SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'380SEC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'380SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'380SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'380SLC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'40 HP Simplex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'400E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'400SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'400SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'420SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'450SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'450SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'450SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'450SLC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'460/500 Nurburg')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'500 K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'500E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'500SEC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'500SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'500SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'540 K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'560SEC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'560SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'560SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'6/25/40 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'60 HP Simplex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'600SEC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'600SEL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'600SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'75 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'770 Grand Mercedes')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'8/11 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'8/18 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'8/20 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'8/22 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'8/38 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A160')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A190')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A35 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A45 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'A45 AMG S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Allegro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Alliado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT 43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT 53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT 63')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT 63 S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT Black Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT R Pro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'AMG GT S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Andare')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'B Electric Drive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'B180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'B200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'B250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'B250e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Boxer 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Boxer 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Boxer 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Boxer OF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Busstar 380')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C32 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C350e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C36 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C43 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C450 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'C63 AMG S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Citaro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CL65 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLA180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLA200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLA250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLA35 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLA45 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLK63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS53 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS53 AMG S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'CLS63 AMG S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Coraza S2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E350e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E420')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E43 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E53 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'E63 AMG S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQA300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQB 250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQB 300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQB 350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQC400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQS 450+')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQS 53 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'EQS 580')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'FS65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'G500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'G55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'G550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'G550 4x4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'G63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'G65 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GL320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GL350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GL450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GL500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GL550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GL63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLA180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLA200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLA250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLA35 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLA45 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLB200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLB250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLB35 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLC250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLC300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLC300e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLC350e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLC43 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLC63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLC63 AMG S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE300d')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE350d')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE43 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE450 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE500e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE53 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE550e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE580')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLE63 AMG S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLK250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLK280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLK300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLK350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLS350d')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLS450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLS500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLS550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLS580')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'GLS63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Gran Viale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Gran Viale Articulado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Gran Viale LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Gran Viale RF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Grosser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'HDX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Knight 10/30 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1013')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1113')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1116')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1117')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1316')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1317')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1319')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1413')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'L1418')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'LO 915')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'LO 916')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'LP1219')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'LP1419')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'LPS1525')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Marco Polo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Maybach GLS600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Maybach S550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Maybach S560')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Maybach S580')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Maybach S600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Maybach S650')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Maybach S680')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'MBO 1018')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'MBO 12000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'MBO 1218')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'MBO 1221')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'MBO 14000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'MBO 1421')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Metris')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'ML63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Model SS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Model SSK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Model SSKL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'MP60 Express')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Multego')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'O400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'O500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OC 500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OF 1118')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OF 1318')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OF 1321')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OH 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OH 1518')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OH 1524')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OH 1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OH 1621')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OH 1624')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OH 1625')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OMC 1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'OMC 1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Paradiso 1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Paradiso 1350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Paradiso 1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'R320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'R350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'R500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'R550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'R63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S 417')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S400L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S420')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S450L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S500L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S550e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S560')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S560e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S560L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S580')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S580e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S600L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S63L AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S65 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'S65L AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Safety Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL550')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL60 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL63 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SL65 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLC180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLC200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLC300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLC43 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK230')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK32 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLK55 AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLR McLaren')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'SLS AMG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Sprinter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Sprinter 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Sprinter 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Sprinter 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Sprinter 3500XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Sprinter 4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Toreto 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Toreto 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Torino')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Tres Ejes')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'V220d')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'V250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Viaggio 1050')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Viaggio 900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Viale BRT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Viano')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 251, N'Vito')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Bobcat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Brougham')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Caliente')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Capri')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Colony Park')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Comet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Commuter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Cougar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Country Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Cyclone')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Grand Marquis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'LN7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Lynx')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'M-47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Marauder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Mariner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Marquis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Medalist')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Mercury')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Meteor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Milan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Monarch')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Montclair')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Montego')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Monterey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Mountaineer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Mystique')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Park Lane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Sable')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Series 19A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Series 29A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Series 99A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Series O9A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Topaz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Tracer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Turnpike Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Villager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Voyager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 252, N'Zephyr')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 253, N'Scorpio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 253, N'XR4Ti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 254, N'KR175')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 254, N'KR200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 255, N'Series 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 255, N'Series A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 255, N'Series B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'HS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'Magnette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'MG GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'MG5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'MGA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'MGB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'MGC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'Midget')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'NA Magnette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'NB Magnette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'PA Midget')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'PB Midget')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'RX8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'SA Drophead')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'TA Drophead')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'TB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'TC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'TD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'TDC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'TF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'VA Drophead')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'WA Drophead')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'YA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'YB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'YT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'ZA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'ZB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'ZR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'ZS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 256, N'ZT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 257, N'Cooper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 257, N'Cooper Clubman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 257, N'Cooper Countryman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 257, N'Cooper Paceman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'3000GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'ASX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Cordia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Diamante')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Eclipse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Eclipse Cross')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Endeavor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Expo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Expo LRV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (5305, 258, N'Galant')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Grandis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'i-MiEV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'L200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Lancer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Mighty Max')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Mirage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Mirage G4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Montero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Montero Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Outlander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Outlander PHEV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Outlander Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Precis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Raider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'RVR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Sigma')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Space Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Starion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Tredia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 258, N'Xpander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'Canter FE125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'Canter FE160')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'Canter FE180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'Canter FG4X4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE120')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE140')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE145')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE145CC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE180')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE-CA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE-HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FE-SP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FG140')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FK200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FK260')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FM260')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FM330')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FM-HR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FM-MR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FM-SP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 259, N'FM-SR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 260, N'MV-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Camelot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Cayman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Diplomat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Dynasty')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Esquire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Executive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Knight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'La Palma')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'La Palma Diesel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Marquis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Monarch')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Monarch SE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Monarch SVE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Riptide')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Signature Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 261, N'Windsor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 262, N'375')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 262, N'450 SS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'London')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-58')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-68')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 6-75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model 8-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 263, N'Series A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 264, N'1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 264, N'600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 264, N'750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'04-Apr')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'4/4 Series I')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'4/4 Series II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'4/4 Series III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'4/4 Series IV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'4/4 Series V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'Aero 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'Plus 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'Plus Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 265, N'Roadster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Cambridge')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Eight Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Marina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Minor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Minor MM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Oxford')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Oxford MO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 266, N'Ten Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 267, N'402')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 267, N'407')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102A2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102A3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102AW3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102B3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102C3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102D3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102DL3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102EL3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'102GL3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'96A3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'96B3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'D4005')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'D4505')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'F3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'J3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'J4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'MC-12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 268, N'MC-9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 269, N'Vignale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'400 Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'600 Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'600 Super Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Advanced')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Ambassador')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Ambassador 600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Ambassador Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Ambassador Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Ambassador Super')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Ambassador Super Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Big Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Custom Ambassador')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'LaFayette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Light Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Nash-Healey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Rambler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 480')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 490')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 660')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 680')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 690')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 870')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 880')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 890')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 960')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 970')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 980')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Series 990')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 270, N'Statesman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Dolphin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Dolphin LX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Islander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Sea Breeze')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Sea Breeze LX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Sea View')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Surf Side')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Tradewinds')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Tropi-Cal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 271, N'Tropi-Cal LX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 272, N'Advanced DSN')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 272, N'Cityliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 272, N'Jetliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 272, N'Skyliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 272, N'Spaceliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'C30LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'C35LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'C40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'C40LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D30LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D35LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D40LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D45HF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'D60LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'L35LF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'L40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 273, N'Xcelsior')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Bay Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Bay Star Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Canyon Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Dutch Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Essex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'King Aire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Kountry Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'London Aire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Mountain Aire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Super Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Ventana')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 274, N'Ventana LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 275, N'Phantom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 275, N'Triumph')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 275, N'Viper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 275, N'Wraith')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'200SX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'240SX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'300ZX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'350Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'370Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'720')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Almera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Altima')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Altra EV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Aprio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Ariya')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Armada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Axxess')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Cabstar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Cabstar E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Cube')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'D21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Frontier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'GT-R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Hikari')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Ichi Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Juke')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Kicks')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Kicks e-Power')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'LEAF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Lucino')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'March')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Maxima')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Micra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Multi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Murano')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Note')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NP300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NP300 Frontier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NT400 Cabstar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NV1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NV200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NV2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NV350 Urvan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NV3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'NX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Pathfinder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Pathfinder Armada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Platina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Pulsar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Pulsar NX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Qashqai')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Quest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Rogue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Rogue Select')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Rogue Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Sakura')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Samurai')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Sentra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Stanza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Tiida')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Titan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Titan XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Tsubame')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Tsuru')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Urvan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'V-Drive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Versa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Versa Note')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Xterra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'X-Trail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 276, N'Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 277, N'35 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 277, N'40 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 277, N'416')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 277, N'436')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'Classic 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'LFS 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'Low Floor 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'RTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'T602')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'T606')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'T702')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'T706')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'T802')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 278, N'T806')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'110')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'1200C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'Prinz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'Ro 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'Spider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'Sport Bertone')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'TT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 279, N'TTS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Greater Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Greyhound 6-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 212')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 301')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 34')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 34-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 34-C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 38 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 49')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 6-44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 6-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 6-54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model 6-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 280, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'442')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'98')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Achieva')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Alero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Aurora')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Autocrat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Bravada')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Calais')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Classic 98')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Custom Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Cutlass')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Cutlass Calais')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Cutlass Ciera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Cutlass Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Cutlass Salon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Cutlass Supreme')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Cutlass Tiara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Defender')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Delmont 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Delta 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Deluxe 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Dynamic 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'E-47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'F-35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'F-36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'F-37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'F-38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'F-39')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'F-47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'F85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Fiesta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Firenza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'G-39')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'G-47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Golden Rocket 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Intrigue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'J-47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Jetfire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Jetstar 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Jetstar I')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'L-35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'L-36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'L-37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'L-38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'L-39')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'L-47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'LSS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 30-A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 30-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 30-C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 30-D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 30-E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 37-A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 37-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 43-A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 44-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 45-A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 45-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 46')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model 6C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model DR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F-28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F-29')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F-30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F-31')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F-32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F-33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model F-34')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model L-32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model L-33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model L-34')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model MR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Model Z')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Omega')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Regency')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 68')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 76')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 78')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Series 98')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Silhouette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Standard 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Starfire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Super 88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Toronado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Viking')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 281, N'Vista Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 282, N'Omega')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 283, N'Orion I')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 283, N'Orion II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 283, N'Orion V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 283, N'Orion VI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'1900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Caravan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Kadett')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Kapitan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Manta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Olimpico')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Olympia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Olympia Rekord')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Opel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Rallye')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 284, N'Rekord')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 285, N'Orion II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 285, N'Orion V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 285, N'Orion VI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 285, N'Orion VII')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 286, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 286, N'1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 286, N'1700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'FCM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'FF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'Highland')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'J Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'M Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'MPT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'NK')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'NL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'S Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'T Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'V Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 287, N'X Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 288, N'Firetruck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 288, N'LERL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 288, N'LESL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 288, N'YT30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 288, N'YT50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 288, N'YT50 ROLOC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 288, N'YT60T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Caribbean')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Cavalier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Clipper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Custom Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Deluxe Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Executive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Four-Hundred')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1001')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1002')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1003')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1004')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1005')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1006')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1103')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1104')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1106')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1107')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1108')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 115-C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 120 C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1201')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1202')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1203')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1204')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1205')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1207')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1208')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 120-A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 120-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 120-CD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1-38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1401')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1402')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1403')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1404')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1405')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1407')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1408')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1502')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1506')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1507')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1508')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1601')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1601-D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1602')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1603')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1604')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1605')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1607')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1608')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1701')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1702')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1703')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1705')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1707')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1708')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1801')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1803')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1804')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1805')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1806')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1807')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1808')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1901')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1903')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1904')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1905')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1906')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1907')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1908')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 1951')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2001')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2003')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2004')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2005')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2006')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2007')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2008')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2010')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2011')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2020')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2021')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2023')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2030')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2055')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2103')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2106')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2111')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2126')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2130')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2201')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2202')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2206')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2211')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2222')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2226')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2233')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2301')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2302')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2306')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2322')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2332')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2333')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2-38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 2-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 3-38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 3-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 4-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 5-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 626')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 633')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 640')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 645')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 726')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 733')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 734')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 740')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 745')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 826')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 833')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 840')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 901')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 902')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 903')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 904')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 905')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model 906')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model N')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model NA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model NB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model NC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model NE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UBS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UCS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UDS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Model UE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Packard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Patrician')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Single Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Single Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Standard Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Super Deluxe Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Super Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 289, N'Twin Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-26')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-46')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-51')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 6-75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Model 8-85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 290, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 291, N'Dyna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 291, N'PL-17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 292, N'AIV Roadster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 292, N'Esperante')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 293, N'DeVille')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 293, N'J-72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Custom 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Master 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 56')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-61')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-81')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 6-91')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 8-67')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Model 8-69')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 294, N'Standard 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 295, N'Z-102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 295, N'Z-102B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 295, N'Z-102BS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 295, N'Z-102BSS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'210')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'220')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'224')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'227')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'265')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'270')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'282')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'325')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'330')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'335')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'337')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'340')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'348')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'349')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'352')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'353')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'357')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'359')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'362')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'365')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'367')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'372')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'375')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'376')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'377')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'378')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'379')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'382')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'384')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'385')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'386')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'387')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'388')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'389')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'397')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'520')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'536')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'537')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'548')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'567')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'579')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 296, N'587')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'2008')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'202')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'203')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'206')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'207')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'207 Compact')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'208')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'208 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'3008')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'301')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'304')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'306')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'307')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'308')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'403')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'404')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'405')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'406')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'407')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'5008')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'504')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'505')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'508')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'604')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'607')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'Expert')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'Grand Raid')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'Landtrek')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'Manager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'Partner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'RCZ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'Rifter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 297, N'Traveller')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Arrow XT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Dash')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Dash CF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Enclosed Cab')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Enforcer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Impel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Lance')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Non Crew Cab')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Open Cab')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Quantum')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Saber')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 298, N'Velocity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Deluxe 8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Great Arrow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1236')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1240A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1242')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1245')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1247')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1248A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1250A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 1255')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 126')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 33')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 36')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 36T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 38 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 38-C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 41')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 43')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 48-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 48-B-5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 48T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 51')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 66-A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 66T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 81')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 836')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 836A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 840A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model 845')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Motorette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Salon Twelve')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 299, N'Silver Arrow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 300, N'Excel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 300, N'Lexor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 300, N'Ontour')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 300, N'Plateau')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 300, N'Traverse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Acclaim')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Arrow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Arrow Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Barracuda')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Belvedere')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Belvedere II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Breeze')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Cambridge')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Caravelle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Champ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Colt')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Concord')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Conquest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Cranbrook')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Cricket')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Cuda')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Deluxe PE Model')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Deluxe PJ Model')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Duster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Expo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Fleet Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Fury')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Fury I')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Fury II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Fury III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Gran Fury')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Grand Voyager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'GTX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Horizon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Laser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Model PA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Model PB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Model PC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Model PD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Model PJ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Model Q')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Model U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Neon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P1 Business Line')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P10 Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P11 Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P11 Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P12 Special Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P14C Special Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P14S Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P15 Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P15 Special Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P2 Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P7 Roadking')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P8 Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'P9 Roadking')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB100 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB150')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB200 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB300 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PB350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Plaza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Prowler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PT-105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PT-125')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PT-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PT-57')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'PT-81')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Reliant')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Road Runner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Roadking')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Sapporo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Satellite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Savoy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Scamp')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Special Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Sport Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Standard PF Model')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Standard PG Model')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Suburban')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Sundance')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Superbird')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'TC3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Trailduster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Turismo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Turismo 2.2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Valiant')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'VIP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Volare')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 301, N'Voyager')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 302, N'Polestar 1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 302, N'Polestar 2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'6000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Acadian')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Astre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Aztek')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Beaumont')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Bonneville')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Catalina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Chieftain')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Deluxe Model 6CA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Deluxe Model 6DA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Deluxe Model 8CA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Deluxe Model 8DA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Deluxe Series 26')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Deluxe Series 28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Deluxe Series Silver Streak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Executive')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Fiero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Firebird')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Firefly')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'G3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'G3 Wave')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'G4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'G5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'G6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'G8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Grand Am')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Grand LeMans')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Grand Prix')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Grand Safari')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Grandville')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'GTO')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'J2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'J2000 Sunbird')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Laurentian')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'LeMans')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Matiz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 302')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 401')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 402')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 601')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 603')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 6-26')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 6-27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 6-28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 6-29 A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Model 6-30 B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Montana')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Optima')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Parisienne')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Pathfinder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Phoenix')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Pursuit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Safari')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Series 605')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Series 701')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Silver Streak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Solstice')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Special Series 25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Star Chief')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Strato-Chief')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Streamliner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Sunbird')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Sunburst')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Sunfire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Sunrunner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Super Chief')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'T1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Tempest')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Torpedo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Torpedo Series 29')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Torrent')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Trans Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Ventura')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Vibe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Wave')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 303, N'Wave5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'356')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'356A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'356B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'356C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'356SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'718 Boxster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'718 Cayman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'718 Spyder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'911')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'912')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'914')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'918 Spyder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'924')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'928')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'930')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'944')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'968')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Boxster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Carrera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Carrera GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Cayenne')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Cayman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Macan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Panamera')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 304, N'Taycan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'Champion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'Entertainer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'High Decker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'Le Mirage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'Marathon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'Prestige')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'Shell')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'X3 Coach')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 305, N'XL2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 306, N'35 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 306, N'40 Foot')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 307, N'Mangusta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'1500 Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'4000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'4500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'5500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'C/V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'Dakota')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'H100 Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'ProMaster 1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'ProMaster 2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'ProMaster 3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'ProMaster City')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 308, N'ProMaster Rapid')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 31')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 34')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 41')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 47')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 63')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 64')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model J')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Rambler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Type 1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Type 2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 309, N'Type 3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 310, N'Rebel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 310, N'Regal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 310, N'Sabre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 310, N'Scimitar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'4CV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Alliance')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Captur')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Caravelle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Clio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Dauphine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Duster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Encore')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Euro Clio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Fluence')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Fregate')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Fuego')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Gordini')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Juvaquatre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Kangoo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Kangoo Express')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Kangoo ZE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Koleos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'KWID')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Laguna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'LeCar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Logan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Megane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Oroch')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R18')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R18i')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'R8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Safrane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Sandero')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Scala')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Scenic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Scenic II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Stepway')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 311, N'Trafic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'Garage Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'Ikon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'Motorhome')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'Sport Deck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'Verona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'Vienna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 312, N'XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'25 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'30 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'35 HP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'Flying Cloud')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'Model T-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'Reo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'Royale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 313, N'The Fifth')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 314, N'Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 314, N'Model 6-70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 314, N'Model 8-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 314, N'Model 8-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 314, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 314, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 314, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'1 1/2 Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'1.5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'2 1/2 Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'2.6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'Apr-68')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'Apr-72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'Elf I')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 315, N'Pathfinder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 316, N'R1S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 316, N'R1T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 316, N'RCV-500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 316, N'RCV-700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'AE-Stacked Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'A-Straight Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'D-Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'Dyanaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'Executive Signature')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'LF-Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'M-Series')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'R-Raised Rail')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 317, N'S-Monocoque')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 318, N'CS Adventurous')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 318, N'E-Trek')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 318, N'Popular')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 318, N'SS Agile')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 318, N'Versatile')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model 4-75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model 4-75-E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model 6-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model 6-54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model 8-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model 8-88')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model C-6-54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Model D-4-75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 319, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 320, N'Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 320, N'Model 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 320, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 321, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Camargue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Corniche')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Corniche II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Corniche IV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Corniche S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Cullinan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Dawn')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Flying Spur')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Ghost')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Park Ward')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Phantom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Cloud')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Dawn')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Seraph')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Shadow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Shadow II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Spirit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Spur')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Wraith')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Silver Wraith II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Touring Limousine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 322, N'Wraith')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 323, N'Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 324, N'Municipal')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 324, N'RIV Fire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'105')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'3500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'3500S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'3-Litre')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 325, N'Mini')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 326, N'Condor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 326, N'Trail-Aire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 326, N'Trail-Lite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 326, N'Trail-Lite LE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'09-Mar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'09-May')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'9000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'92')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'92B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'9-2X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'93')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'93B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'93F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'9-3X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'9-4X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'95')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'96 GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'96 Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'9-7x')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'99')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'GT750')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'GT850')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'Monte Carlo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'Shrike')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 327, N'Sonett')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 328, N'Sports')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 328, N'Sussita')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 329, N'S7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 330, N'2300 Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 330, N'Randonee')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'Astra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'Aura')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'Ion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'L100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'L200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'L300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'LS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'LS1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'LS2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'LW1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'LW2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'LW200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'LW300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'Outlook')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'Relay')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SC1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SC2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'Sky')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SL1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SL2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SW1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'SW2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 331, N'Vue')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 332, N'10 Cubic Yard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 332, N'9 Cubic Yard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K280')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K320')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K360')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K410')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K440')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K460')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'K490')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'SERIE F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'SERIE G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'SERIE K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'SERIE L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'SERIE P')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'SERIE R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 333, N'SERIE S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'FR-S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'iA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'iM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'iQ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'tC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'xA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'xB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 334, N'xD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 335, N'Series B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 336, N'H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 336, N'J')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 336, N'L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 336, N'M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 336, N'S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 336, N'T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 336, N'W')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Alhambra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Altea')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Altea XL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Arona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Ateca')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Cordoba')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Exeo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Formentor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Freetrack')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Ibiza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Leon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Nuevo Ibiza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Tarraco')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 337, N'Toledo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 338, N'Cobra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 338, N'Series 1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 339, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'200CS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'208S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'Amica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'Daina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 340, N'Spring')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'1000S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'1118')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'1204')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Ariane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Aronde')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Cinq')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Huit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Series 5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Series 6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 341, N'Vedette')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 342, N'Gazelle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 342, N'Nine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 342, N'SM1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'1000 MB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'1101')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'1102')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'1201')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'440')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'Felicia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'Octavia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'S440')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'S445')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 343, N'SS450')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 344, N'Cabrio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 344, N'City-Coupe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 344, N'Crossblade')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 344, N'EQ fortwo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 344, N'Forfour')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 344, N'Fortwo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 344, N'Roadster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Advantage')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Alpine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Baron')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'BC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'BC2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Bus Chassis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'BV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Charger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'CV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Diamond')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'EC2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'EXP-2001')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Force')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Forward Control')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Front Discharge Mixer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Furion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Gladiator')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'GT-One')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Highlander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Intermediate')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'K2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'K3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'K4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'KC1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Kicker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Metro Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Metro Star X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Monarch')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Motorhome')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Mountain Master')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Mountain Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Rangemaster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'Travel Ride III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 345, N'WC2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 346, N'C12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 346, N'C8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 347, N'Viper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 348, N'Rexton')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 349, N'Sportsman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 349, N'Vanguard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 350, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 351, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 351, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 351, N'Model F-25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 351, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model 4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model 6-C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model 6-S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model D-6-85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model F-6-85')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model G-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model H-8-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model J')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model J-8-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model M-6-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model N-6-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model SK6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Model SKL4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 352, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 353, N'825')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 353, N'827')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'360')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'A9500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'A9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'A9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Acterra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Acterra 5500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Acterra 6500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Acterra 7500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Acterra 8500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'AT9500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'AT9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'AT9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Bullet 45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Bullet 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Car Hauler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'Condor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L7500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L7501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L8500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L8501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L8511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L8513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L9500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L9501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L9511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'L9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT7500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT7501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT8500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT8501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT8511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT8513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT9500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT9501')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT9511')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT9513')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'LT9522')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'SC7000 Cargo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'SC8000 Cargo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 354, N'ST9500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model AA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model C-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model CC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model D-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model G-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model U')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model XXX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Model Y')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 355, N'Tourer AA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 356, N'H30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 356, N'H40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 356, N'T30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R16A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R17A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'2R6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+01')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+05')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+06')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+07')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3.00E+14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3E11D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3E12D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3E6D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3E7D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'3R6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+01')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+02')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+03')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+05')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+07')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4.00E+14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4E11D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4E12D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4E2D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4E3D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'4E7D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5.00E+05')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5.00E+06')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5.00E+07')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5.00E+11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5.00E+12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5.00E+13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5E12D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5E13D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'5E7D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6.00E+05')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6.00E+07')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6.00E+10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6.00E+11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6.00E+12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6.00E+13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6E12D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6E13D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'6E7D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7.00E+05')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7.00E+07')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7.00E+10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7.00E+11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7.00E+12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7.00E+13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7E12D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'7E13D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+05')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+06')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+07')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8.00E+15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8E12D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8E13D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'8E7D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Avanti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Big Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Challenger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Champ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Champion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Commander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Commander Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Commander Model 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Commander Model 71')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Commander Model 73')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Commander Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Daytona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Dictator')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Dictator Model 61')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Dictator Model 62')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Dictator Model FC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Dictator Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E11')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E12')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E13')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E14')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E38')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'E7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Flight Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Golden Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Gran')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'J5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'K5 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'L5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Lark')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Light Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Light Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'M15')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'M15A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'M16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'M17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'M5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model 9502')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model 9503')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model AA-35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model G-10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model G-7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model G-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model L')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Model SA-25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Police Car')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Power Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President FE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President FH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President Model 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President Model 82')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President Model 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President Model 91')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'President Speedway Model 92')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Rockne Model 10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Rockne Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Rockne Model 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Scotsman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Silver Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Six Model 53')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Six Model 54')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Six Model 55')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Six Model 56')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Sky Hawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Special Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Standard Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'State Commander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'State President')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Taxi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Transtar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 357, N'Wagonaire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Blackhawk')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Bulldog Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Duplex')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Limousine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model 4E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model 4F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model 693')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model 694')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model 695')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model 6E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model 6F')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model DV-32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model H.C.S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model LA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model LAA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model MA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model MB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Model SV-16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series BB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series G')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series H')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series K')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series KLDH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Series S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Special Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Speedway Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Speedway Six')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Touring')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 358, N'Vertical Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'360')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Ascent')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'B9 Tribeca')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Baja')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Brat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'BRZ')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Crosstrek')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'DL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'FE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Forester')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'GF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'GL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'GL-10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'GLF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Impreza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Justy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Legacy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Loyale')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Outback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'RX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Solterra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Star')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'SVX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'Tribeca')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'WRX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'WRX STI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'XT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'XV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 359, N'XV Crosstrek')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'Alpine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'Arrow')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'Imp')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'MK III')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'Rapier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'Sunbeam-Talbot 80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'Sunbeam-Talbot 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 360, N'Tiger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 361, N'Aerial')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 361, N'Pumper')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 361, N'Special')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Aerio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Baleno')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Ciaz')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Equator')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Ertiga')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Esteem')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Forenza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Forsa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Grand Vitara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Ignis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Jimny')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Kizashi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'LJ81')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Reno')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'SA310')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Samurai')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'S-Cross')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Sidekick')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'SJ410')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'SJ413')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Swift')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Swift+')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'SX4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'SX4 Crossover')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Verona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'Vitara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 362, N'X-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (362, N'XL-7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (363, N'Doretti')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (364, N'Record')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (364, N'T150C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (364, N'T150C-SS Figoni')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (364, N'T150SS Tear Drop')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (365, N'Tatraplan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (366, N'TS30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (366, N'TS35')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (366, N'TS45')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (367, N'Glider')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (367, N'Terex Advance Mixer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (368, N'3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (368, N'Roadster')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (368, N'S')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (368, N'X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (368, N'Y')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (369, N'City')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (370, N'Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (370, N'Saf-T-Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (370, N'School Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (370, N'Transit Liner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'A.C.E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Aria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Astoria')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Challenger')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Chateau')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Chateau Citation')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Chateau Super C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Citation Sprinter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Coleman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Daybreak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Delano')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Echelon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Four Winds')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Four Winds Siesta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Four Winds Super C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Freedom Elite')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Freedom Traveler')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Hurricane')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Omni')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Outlaw')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Palazzo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Quantum')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Quantum LC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Serrano')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Siesta Sprinter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Synergy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Tellaro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Tuscany')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Tuscany XTE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (371, N'Venetian')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Allegro Bay')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Allegro Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Allegro Open Road')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Allegro Red')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Allegro Red 340')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Breeze')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Phaeton')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Wayfarer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (372, N'Zephyr')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (373, N'Crown')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (373, N'Tiara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'2000GT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'4Runner')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'86')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Avalon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Avanza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'bZ4X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Camry')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Carina')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Celica')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'C-HR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Corolla')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Corolla Cross')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Corolla iM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Corona')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Cressida')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Crown')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Echo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'FJ Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'GR Corolla')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'GR Supra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'GR86')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Hiace')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Highlander')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Hilux')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Hi-Lux')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Land Cruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Mark II')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Matrix')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Mirai')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'MR2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'MR2 Spyder')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Paseo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Previa')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Prius')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Prius AWD-e')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Prius C')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Prius Plug-In')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Prius Prime')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Prius V')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Raize')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'RAV4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'RAV4 Prime')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Rush')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Sequoia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Sienna')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Solara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Starlet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Stout')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Supra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'T100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Tacoma')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Tercel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Tiara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Tundra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Van Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Venza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Yaris')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Yaris iA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (374, N'Yaris R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'102A3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'102C3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'96A2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'96A3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'MC-9')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'T702')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'T706')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'T802')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (375, N'T806')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'GT6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'Herald')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'Mayflower')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'Renown')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'Spitfire')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'Stag')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR250')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR3A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR3B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR4A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR7')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (376, N'TR8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (377, N'48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (378, N'803')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (378, N'950')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (378, N'Coventry Climax')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (378, N'SPR60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (378, N'Sprint')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'2500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'2500M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'3000M')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'Grantura')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'Griffith')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'Tuscan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (379, N'Vixen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (380, N'Bukhara')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (380, N'Hunter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (380, N'Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (380, N'Profi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'1100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'1200')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'1300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'1400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'1800CS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'1800HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'2000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'2300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'2300DH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'2300LP')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'2600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'2800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'3000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'3000HD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'3000SD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'3300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'550T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (381, N'600T')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (382, N'3350')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (382, N'3900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (383, N'Step Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (384, N'American')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (384, N'Classic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (384, N'Gremlin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (384, N'Javelin')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (384, N'Lerma')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (384, N'Pacer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (384, N'Rally')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (385, N'C2045')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (385, N'Commuter Coach CX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (385, N'T2100')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (385, N'T800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (385, N'T809')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (385, N'T815')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 385, N'T900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 385, N'T915')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 385, N'TD925')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 385, N'TDX Double Decker Coach')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 385, N'Tourist Coach TX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 385, N'Urban Bus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 386, N'Fourteen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 386, N'Ten')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 386, N'Twelve')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 386, N'Velox')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 386, N'Victor')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 386, N'Wyvern')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 387, N'Biltwel Six-27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 387, N'Biltwel Six-28')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 387, N'Model 38 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 387, N'Model 39')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 388, N'400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 389, N'Eight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'411')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'412')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Amarok')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Arteon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Atlantic')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Atlas')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Atlas Cross Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Beetle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Beetle Cabrio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Bora')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Brasilia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Cabrio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Cabriolet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Caddy')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Campmobile')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Caravelle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Caribe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'CC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Clasico')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Combi')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Constellation')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Corrado')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Corsar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Crafter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Crafter Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Cross Sport')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'CrossFox')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Dasher')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Derby')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'e-Golf')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Eos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'EuroVan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Fastback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Fox')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'GLI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Gol')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Gol Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Golf')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Golf Alltrack')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Golf City')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Golf R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Golf SportWagen')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'GTI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Hormiga')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'ID.4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Jetta')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Jetta City')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Karmann Ghia')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Lupo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Multivan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Nivus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Nuevo Gol')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Panel')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Passat')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Passat CC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Phaeton')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Pointer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Pointer Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Polo')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Quantum')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'R32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Rabbit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Rabbit Convertible')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Rabbit Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Robust')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Routan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Safari')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Saveiro')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Scirocco')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Sharan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'SportVan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Squareback')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Standard')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Super Beetle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Taos')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'T-Cross')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Teramont')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Thing')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Tiguan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Tiguan Limited')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Touareg')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Transporter')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Up!')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Van')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Vanagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Vento')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Virtus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Volksbus')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Worker')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 390, N'Workline')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'122')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'142')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'144')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'145')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'164')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'240')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'242')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'244')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'245')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'262')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'264')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'265')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'444')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'445')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'544')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'7300 BRT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'740')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'745')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'760')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'780')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'7900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'8300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'850')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'940')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'960')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'9700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'9700 Grand')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'9800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'Access')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'ACL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'ALD Enviro500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'B11R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'B13R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'B290R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'B410R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'B8R')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'B8RLE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'C30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'C40 Recharge')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'C70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'DL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'FE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'GLE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'Hibrido')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'ProCity')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'PV 444')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'S40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'S60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'S60 Cross Country')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'S70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'S80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'S90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V40 Cross Country')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V60 Cross Country')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'V90 Cross Country')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VAH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VAH 300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VAH 400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VAH 430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VAH 640')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VHD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VN')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 430')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 630')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 670')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 740')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 760')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNL 860')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNR 300')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNR 400')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNR 640')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VNX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'VT')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'WAH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'WC')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'WG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'WH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'WI')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'WX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'XC40')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'XC40 Recharge')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'XC60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'XC70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 391, N'XC90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 392, N'MV-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 393, N'1000')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 393, N'311')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 393, N'Wartburg')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 394, N'Model A-44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 394, N'Model B-44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 394, N'Model D-48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 394, N'Model H-44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 394, N'Model H-60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 395, N'Alpine')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'3700')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'3800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4700SB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4700SF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'47X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4800SB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4800SF')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4900E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4900EX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4900FA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'4900SA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'49X')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'5700XE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'5800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'5900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'6900')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'6900XD')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 396, N'WSH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 397, N'Model 96A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 397, N'Model 98A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WCA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WCL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WCM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WCS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WHL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WHM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WHS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WIA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WIL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WIM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WIS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 398, N'WXLL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'ACL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'ACM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'J8C0')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'J9C0')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WAH')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WCA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WCL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WCM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WCS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WG')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WHEB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WHL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WHLB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WHM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WHR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WHS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WIA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WIL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WIM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WIS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WXLL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WXLM')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 399, N'WXR')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'439')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'440')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'441')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'442')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'4-63 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'4-73 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'4-73 Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'4-75 Pickup')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'4-75 Sedan Delivery')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Aero Ace')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Aero Comet')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Aero Eagle')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Aero Falcon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Aero Lark')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Aero Wing')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Americar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Apr-63')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Bermuda')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'CJ2A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Custom')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight 88-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight 88-8')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight K-17')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight K-19')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 27')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 56')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 64')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 66')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 66A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 66B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 66D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 66E')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 67')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 6-87')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 70')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 70A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 70B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Knight Model 95 Deluxe')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Light Four 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'MA')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'MB')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 37')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 38 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 39')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 39 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 48')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 48 Truck')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 6-87')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 6-90A Silver Streak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 77')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 8-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 8-80D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 88-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 8-88 Silver Streak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 8-88A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 89')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 90 Silver Streak')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 91')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 92')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 93')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 97')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 98B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Model 98D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Light Four')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 65')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 69')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 75')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 79')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 83')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 83B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 83-B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 90B')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Model 91CE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Overland Series 91CE')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Plainsman')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Speedway')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Station Sedan')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Station Wagon')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Whippet Model 93A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Whippet Model 96')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Whippet Model 96A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Whippet Model 98')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 400, N'Whippet Model 98A')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 401, N'Model 6-69')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 401, N'Model 6-72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 401, N'Model 6-79')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 401, N'Model 8-82')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 401, N'Model 8-92')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Access')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Access Premier')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Adventurer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Aspect')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Boldt')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Brave')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Destination')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Era')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Forza')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Impulse')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Journey')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Journey Express')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Meridian')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Minnie')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Navion')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Sightseer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Solis')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Spirit')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Suncruiser')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Sundancer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Sunflyer')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Sunova')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Sunrise')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Sunstar')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Tour')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Vectra')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'View')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'View Profile')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 402, N'Vista')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 403, N'15/50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 403, N'15/60')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 403, N'1500')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 403, N'Apr-44')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 403, N'Apr-50')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 403, N'Jun-80')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 403, N'Jun-90')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1061')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1260')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1261')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1460')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1461')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1600')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1601')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1800')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1801')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT1802')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'FasTrack FT931')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'LF72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'P30')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'P32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'P42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'R26')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'R32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W16')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W18')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W21')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W25')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 404, N'W62')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'P32')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'P42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'R20')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'R26')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'W18')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'W22')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'W24')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'W42')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'W52')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'W62')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 405, N'W72')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 406, N'SA01')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Drive-it-Yourself')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model A-2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model D')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model D-1')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model D-10')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model O')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model O-2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model O-3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model O-4')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model O-5')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 407, N'Model O-6')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 408, N'Cabrio')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 408, N'GV')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES ( 408, N'GVL')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (408, N'GVS')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (408, N'GVX')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (409, N'M2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (409, N'M3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (409, N'MX2')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (409, N'MX3')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (410, N'G-744')
GO
INSERT MakeModels ( MakeID, ModelName) VALUES (411, N'Janus 250')
-------------------

-- Countries
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Afghanistan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Albania')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Algeria')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Andorra')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Angola')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Antigua and Barbuda')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Argentina')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Armenia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Austria')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Azerbaijan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bahrain')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bangladesh')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Barbados')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Belarus')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Belgium')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Belize')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Benin')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bhutan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bolivia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bosnia and Herzegovina')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Botswana')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Brazil')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Brunei')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bulgaria')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Burkina Faso')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Burundi')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cabo Verde')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cambodia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cameroon')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Canada')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Central African Republic')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Chad')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Channel Islands')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Chile')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'China')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Colombia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Comoros')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Congo')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Costa Rica')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'CÙte d''Ivoire')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Croatia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cuba')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cyprus')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Czech Republic')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Denmark')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Djibouti')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Dominica')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Dominican Republic')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'DR Congo')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ecuador')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Egypt')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'El Salvador')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Equatorial Guinea')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Eritrea')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Estonia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Eswatini')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ethiopia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Faeroe Islands')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Finland')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'France')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'French Guiana')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Gabon')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Gambia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Georgia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Germany')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ghana')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Gibraltar')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Greece')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Grenada')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guatemala')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guinea')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guinea-Bissau')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guyana')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Haiti')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Holy See')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Honduras')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Hong Kong')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Hungary')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Iceland')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'India')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Indonesia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Iran')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Iraq')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ireland')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Isle of Man')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Israel')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Italy')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Jamaica')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Japan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Jordan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kazakhstan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kenya')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kuwait')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kyrgyzstan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Laos')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Latvia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Lebanon')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Lesotho')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Liberia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Libya')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Liechtenstein')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Lithuania')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Luxembourg')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Macao')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Madagascar')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Malawi')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Malaysia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Maldives')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Mali')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Malta')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Mauritania')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Mauritius')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Mayotte')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Mexico')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Moldova')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Monaco')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Mongolia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Montenegro')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Morocco')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Mozambique')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Myanmar')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Namibia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Nepal')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Netherlands')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Nicaragua')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Niger')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Nigeria')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'North Korea')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'North Macedonia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Norway')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Oman')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Pakistan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Panama')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Paraguay')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Peru')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Philippines')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Poland')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Portugal')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Qatar')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'RÈunion')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Romania')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Russia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Rwanda')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Saint Helena')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Saint Kitts and Nevis')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Saint Lucia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Saint Vincent and the Grenadines')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'San Marino')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Sao Tome & Principe')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Saudi Arabia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Senegal')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Serbia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Seychelles')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Sierra Leone')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Singapore')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Slovakia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Slovenia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Somalia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'South Africa')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'South Korea')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'South Sudan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Spain')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Sri Lanka')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'State of Palestine')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Sudan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Suriname')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Sweden')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Switzerland')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Syria')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Taiwan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Tajikistan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Tanzania')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Thailand')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'The Bahamas')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Timor-Leste')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Togo')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Trinidad and Tobago')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Tunisia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Turkey')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Turkmenistan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Uganda')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Ukraine')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'United Arab Emirates')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'United Kingdom')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'United States')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Uruguay')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Uzbekistan')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Venezuela')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Vietnam')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Western Sahara')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Yemen')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Zambia')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES ( N'Zimbabwe')
