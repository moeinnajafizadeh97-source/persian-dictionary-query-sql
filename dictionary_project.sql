ALTER PROCEDURE GenerateWords
    @characters NVARCHAR(MAX),
    @length VARCHAR(MAX)
AS
BEGIN

    DECLARE @LengthT TABLE (Length INT)

    INSERT INTO @LengthT (Length)
    SELECT value
    FROM STRING_SPLIT(@length, ',');

    WITH RecursiveCTE AS 
	(
        SELECT  CAST(SUBSTRING(@characters, Numbers.Number, 1) AS NVARCHAR(MAX)) AS [Word], 
				1 AS [Level], 
				Length
        FROM (
			  SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Number
			  FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Numbers(Number)
			  WHERE Number <= LEN(@characters)
			 ) AS Numbers
        CROSS JOIN @LengthT
        UNION ALL
        SELECT  CAST(Word + SUBSTRING(@characters, Numbers.Number, 1) AS NVARCHAR(MAX)),
				[Level] + 1,
				Length
        FROM RecursiveCTE
        CROSS JOIN (
					SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Number
					FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Numbers(Number)
					WHERE Number <= LEN(@characters)
					) AS Numbers
        WHERE [Level] < Length
	)
    SELECT DISTINCT RC.Word
    FROM RecursiveCTE as RC
	RIGHT JOIN Dictionary AS D ON (D.word = RC.word)
    WHERE [Level] = Length
	ORDER BY RC.Word
    OPTION (MAXRECURSION 0)

END
