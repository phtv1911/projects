---Sales.SalePersonQuotaHistory
---Sales.SalesOrderHeade

SELECT 
	a.BusinessEntityID as Ma_NV, --LIST
	a.QuotaDate NgayHieuLuc, --LIST
	a.SalesQuota ChiTieu, --LIST
	SUM(b.SubTotal) TongDoanhSo, -- 1 Gia Tri
	FORMAT (SUM(b.SubTotal)/a.SalesQuota, 'P0') TyLePerc --Gia Tri

INTO #Table1

FROM
	Sales.SalesPersonQuotaHistory a
	JOIN Sales.SalesOrderHeader b
	ON a.BusinessEntityID = b.SalesPersonID

WHERE b.OrderDate > = a.QuotaDate and b.OrderDate < DATEADD(MONTH, 3, a.QuotaDate) and YEAR(b.OrderDate) = 2013

GROUP BY a.BusinessEntityID, a.QuotaDate, a.SalesQuota

SELECT
	Ma_NV,
	YEAR(NgayHieuLuc) Nam,
	SUM(ChiTieu) TongChiTieu,
	SUM(TongDoanhSo) DoanhThuTheoNam,
	FORMAT (SUM(TongDoanhSo)/SUM(ChiTieu), 'P0') TyLe
	
FROM #Table1

GROUP BY Ma_NV, YEAR(NgayHieuLuc)