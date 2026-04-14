CREATE VIEW People_View AS
SELECT 
	P.PersonID,
	CONCAT(P.FirstName, ' ', P.SecondName, ' ', (ISNULL(P.ThirdName,'')), P.LastName) AS FullName,
	CASE WHEN P.Gender = 0 THEN 'Male'	WHEN P.Gender = 1 THEN 'Female'	ELSE 'Unknow' END AS Gender,
	P.NationalNo,
	C.CountryName AS Nationality,
	P.DateOfBirth,
	P.Phone,
	P.Email
FROM People P
JOIN Countries C
ON P.Nationality = C.CountryID;
-------------------------------

CREATE VIEW Users_View AS
SELECT
	U.UserID, U.PersonID, 
	CONCAT(P.FirstName, ' ', P.SecondName, ' ', (ISNULL(P.ThirdName,'')), P.LastName) AS FullName,
	U.UserName, U.IsActive
FROM Users U
JOIN People P
ON U.PersonID = P.PersonID;
-------------------------------------

CREATE VIEW MakeModels_View AS
SELECT 
	MM.ModelID,
	MM.MakeID,
	M.MakeName,
	MM.ModelName
FROM MakeModels MM
JOIN Makes M
ON MM.MakeID = M.MakeID;
---------------------------

CREATE VIEW Vehicles_View AS
SELECT 
	V.VehicleID, M.MakeName, MM.ModelName,V.Year, V.Mileage,
	FT.FuelType, VC.CategoryName, V.IsAvailableForRent
FROM Vehicles V
JOIN Makes M
ON V.MakeID = M.MakeID
JOIN MakeModels MM
ON V.ModelID = MM.ModelID
JOIN VehicleCategories VC
ON V.CarCategoryID = VC.CategoryID
JOIN FuelTypes FT
ON V.FuelTypeID = FT.FuelTypeID;
-----------------------------------------


CREATE VIEW RentalBooking_View AS
SELECT 
	RB.BookingID, C.CustomerName, V.VehicleID, M.MakeName, MM.ModelName,
	RB.RentalStartDate, RB.RentalEndDate
FROM RentalBooking RB
JOIN Customers C
ON RB.CustomerID = C.CustomerID
JOIN Vehicles V
ON RB.VehicleID = V.VehicleID
JOIN Makes M
ON V.MakeID = M.MakeID
JOIN MakeModels MM
ON V.ModelID = MM.ModelID;

----------------------------------------
CREATE VIEW VehiclesReturn_View AS 
SELECT 
	VR.ReturnID,RB.BookingID, V.VehicleID, M.MakeName, MM.ModelName, FT.FuelType, VC.CategoryName,
	VR.ActualReturnDate, VR.Mileage
FROM VehicleReturns VR
JOIN RentalTransaction RT	ON VR.ReturnID = RT.ReturnID
JOIN RentalBooking RB		ON RT.BookingID = RB.BookingID
JOIN Vehicles V				ON RB.VehicleID = V.VehicleID
JOIN Makes M				ON V.MakeID = M.MakeID
JOIN MakeModels MM			ON V.ModelID = MM.ModelID
JOIN FuelTypes FT			ON V.FuelTypeID = FT.FuelTypeID
JOIN VehicleCategories VC	ON V.CarCategoryID = VC.CategoryID;
------------------------------------------------------------------

CREATE VIEW RentalTransaction_View AS
SELECT 
	RT.TransactionID, RT.BookingID, RT.ReturnID,C.CustomerName,
	V.VehicleID,
	M.MakeName, MM.ModelName, RT.TransactionDate
FROM RentalTransaction RT
JOIN RentalBooking RB ON RT.BookingID = RB.BookingID
JOIN Vehicles V ON RB.VehicleID = V.VehicleID
JOIN Customers C ON RB.CustomerID = C.CustomerID
JOIN Makes M ON V.MakeID = M.MakeID
JOIN MakeModels MM ON V.ModelID = MM.ModelID;
