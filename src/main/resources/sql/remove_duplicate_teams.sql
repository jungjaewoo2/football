-- team_info 테이블에서 중복되는 팀구단명 데이터 삭제
-- 중복 데이터 확인
SELECT team_name, COUNT(*) as count
FROM team_info 
GROUP BY team_name 
HAVING COUNT(*) > 1
ORDER BY count DESC;

-- 중복 데이터 중 가장 오래된 것(uid가 가장 작은 것)을 제외하고 삭제
DELETE t1 FROM team_info t1
INNER JOIN team_info t2 
WHERE t1.team_name = t2.team_name 
AND t1.uid > t2.uid;

-- 삭제 후 중복 확인
SELECT team_name, COUNT(*) as count
FROM team_info 
GROUP BY team_name 
HAVING COUNT(*) > 1
ORDER BY count DESC;

-- 최종 결과 확인
SELECT uid, category_name, team_name, city, stadium, created_at
FROM team_info 
ORDER BY team_name, uid; 