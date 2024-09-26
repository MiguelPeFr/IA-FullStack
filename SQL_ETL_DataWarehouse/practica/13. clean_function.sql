CREATE OR REPLACE FUNCTION keepcoding.clean_integer(p_int INT64)
RETURNS INT64
AS (
  IFNULL(p_int, -999999)
);
