# SkillConnect — Example full-stack Java webapp

Stack:
- Frontend: HTML, CSS, JavaScript
- Backend: Core Java Servlets (jakarta.servlet)
- Database: MySQL
- Build: Maven (produces a WAR). Deploy to Apache Tomcat 10/11.

Important:
- Update MySQL credentials in `DBConnection.java` before running.
- For production, DO NOT store plaintext passwords. Use hashing (bcrypt) and TLS.
- This example is intentionally simple to help you get started.

How to build & run:
1. Install MySQL and create the database using `db/schema.sql`.
2. Adjust MySQL user/password in `src/main/java/com/skillconnect/servlets/DBConnection.java`.
3. Build: `mvn clean package`
4. Deploy `target/SkillConnect.war` to Tomcat's `webapps` (or use `mvn tomcat7:deploy` with plugin).
5. Open: http://localhost:8080/SkillConnect/

Files included:
- Java servlets (Register, Login, Logout)
- Simple JSP dashboard (requires sessions)
- HTML pages for register/login
- CSS + basic JS validation
