SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Junwei Hu
-- Create date: 01/31/2017
-- Description:	Load [dbo].[XIOStorageCPUShorttermForecast] data from [dbo].[stgXIOStorageCPUShorttermForecast]
-- Triggered by Cas job: XIOStorageCPUShorttermForecast
-- =============================================
CREATE PROCEDURE [dbo].[usp_LoadXIOStorageCPUShortTermForecast] 

AS
BEGIN
	
	DECLARE @RowCount int

	/*Load Storage Shortterm Forecast Data */

	SELECT @RowCount = COUNT(*)
	FROM [dbo].[stgXIOStorageCPUShorttermForecast]
	WHERE ClusterType = 'XIO STORAGE' AND ResourceUnit = 'CPU'

	IF (@RowCount >0)
		TRUNCATE TABLE [dbo].[XIOStorageCPUShorttermForecast]


	INSERT INTO [dbo].[XIOStorageCPUShorttermForecast] (SnapShotDate, Region, ClusterType, ForecastDate, ForecastValue)
	SELECT SnapShotDate, Region, ClusterType, ForecastDate, ForecastValue
	FROM [dbo].[stgXIOStorageCPUShorttermForecast]
	WHERE ClusterType = 'XIO STORAGE' AND ResourceUnit = 'CPU'

END
GO