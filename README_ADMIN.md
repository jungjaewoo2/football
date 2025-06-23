# Football 프로젝트 - 관리자 로그인 시스템

## 개요
이 프로젝트는 Spring Boot를 사용한 Football 관리 시스템으로, 관리자 로그인 기능을 포함하고 있습니다.

## 설치 및 설정

### 1. 데이터베이스 설정
1. MySQL 데이터베이스에 `footBall` 데이터베이스를 생성합니다.
2. `src/main/resources/sql/create_admin_table.sql` 파일을 실행하여 admin 테이블을 생성합니다.

```sql
-- admin 테이블 생성
CREATE TABLE IF NOT EXISTS admin (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(50) NOT NULL UNIQUE,
    passwd VARCHAR(255) NOT NULL
);

-- admin 계정 데이터 삽입 (아이디: admin, 비밀번호: 1234)
INSERT INTO admin (id, passwd) VALUES ('admin', '1234');
```

### 2. 데이터베이스 연결 설정
`src/main/resources/application.properties` 파일에서 데이터베이스 연결 정보를 수정하세요:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/footBall?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8
spring.datasource.username=root
spring.datasource.password=your_password_here
```

### 3. 프로젝트 실행
```bash
mvn spring-boot:run
```

## 사용법

### 관리자 로그인
1. 웹 브라우저에서 `http://localhost:8080/admin/login` 접속
2. 기본 로그인 정보:
   - 아이디: `admin`
   - 비밀번호: `1234`

### 주요 기능
- **로그인**: 관리자 계정으로 로그인
- **대시보드**: 로그인 후 관리자 대시보드 접근
- **로그아웃**: 세션 종료 및 로그인 페이지로 이동

## 파일 구조

```
src/
├── main/
│   ├── java/football/
│   │   └── controller/
│   │       └── AdminController.java          # 관리자 컨트롤러
│   ├── resources/
│   │   ├── application.properties            # 애플리케이션 설정
│   │   └── sql/
│   │       └── create_admin_table.sql        # admin 테이블 생성 스크립트
│   └── webapp/
│       └── WEB-INF/
│           └── views/
│               └── admin/
│                   ├── login.jsp             # 로그인 페이지
│                   └── dashboard.jsp         # 대시보드 페이지
```

## 보안 고려사항

1. **비밀번호 암호화**: 현재는 평문으로 저장되어 있으므로, 실제 운영 환경에서는 BCrypt 등의 암호화 방식을 사용하세요.
2. **세션 관리**: 로그인 세션의 유효 시간을 설정하고, 보안을 강화하세요.
3. **SQL 인젝션 방지**: PreparedStatement를 사용하여 SQL 인젝션을 방지하고 있습니다.

## 추가 개발 사항

- [ ] 비밀번호 암호화 구현
- [ ] 관리자 권한 레벨 추가
- [ ] 로그인 시도 제한 기능
- [ ] 관리자 계정 관리 기능
- [ ] 비밀번호 변경 기능

## 기술 스택

- **Backend**: Spring Boot 3.5.2
- **Database**: MySQL 8.0
- **View**: JSP
- **Build Tool**: Maven
- **Java Version**: 21 