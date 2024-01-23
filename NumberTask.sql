CREATE FUNCTION dbo.FormatPhoneNumber
(
    @PhoneNumber NVARCHAR(15)
)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @FormattedNumber NVARCHAR(20);

    SET @PhoneNumber = REPLACE(REPLACE(REPLACE(REPLACE(@PhoneNumber, '+', ''), '(', ''), ')', ''), ' ', '');

    IF LEN(@PhoneNumber) < 9
        RETURN NULL;

    SET @FormattedNumber = CONCAT('+994 (', SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 8 + 1, 3), ') ', SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 5 + 1, 2), ' ', SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 3 + 1, 2), ' ', SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 1 + 1, 2));

    RETURN @FormattedNumber;
END;



DECLARE @Result NVARCHAR(20);


SET @Result = dbo.FormatPhoneNumber('0501112222');
PRINT 'Formatted Number: ' + ISNULL(@Result, 'Invalid Input');


SET @Result = dbo.FormatPhoneNumber('9940501112222');
PRINT 'Formatted Number: ' + ISNULL(@Result, 'Invalid Input');


SET @Result = dbo.FormatPhoneNumber('+994 050 111 22 22');
PRINT 'Formatted Number: ' + ISNULL(@Result, 'Invalid Input');


SET @Result = dbo.FormatPhoneNumber('12345');
PRINT 'Formatted Number: ' + ISNULL(@Result, 'Invalid Input');


SET @Result = dbo.FormatPhoneNumber('ABC123456');
PRINT 'Formatted Number: ' + ISNULL(@Result, 'Invalid Input');
