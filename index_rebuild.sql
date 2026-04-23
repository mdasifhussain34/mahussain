SELECT 
    owner,
    index_name,
    table_name,
    blevel,
    leaf_blocks,
    status
FROM 
    dba_indexes
WHERE 
    blevel > 2
ORDER BY 
    blevel DESC;

-- Generate rebuild commands for fragmented indexes
SELECT 
    'ALTER INDEX ' || owner || '.' || index_name || ' REBUILD;' AS rebuild_statement
FROM 
    dba_indexes
WHERE 
    blevel > 2;
