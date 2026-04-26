SELECT 
    s1.sid || ',' || s1.serial# AS blocker,
    s2.sid || ',' || s2.serial# AS blocked,
    s1.username,
    s1.machine,
    s1.program
FROM 
    v$lock l1
JOIN 
    v$session s1 ON l1.sid = s1.sid
JOIN 
    v$lock l2 ON l1.id1 = l2.id1 AND l1.id2 = l2.id2
JOIN 
    v$session s2 ON l2.sid = s2.sid
WHERE 
    l1.block = 1
    AND l2.request > 0;

-- Generate kill session commands
SELECT 
    'ALTER SYSTEM KILL SESSION ''' || sid || ',' || serial# || ''' IMMEDIATE;' AS kill_command
FROM 
    v$session
WHERE 
    blocking_session IS NOT NULL;
