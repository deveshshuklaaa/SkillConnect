# SkillConnect Project TODO

## 1. Project Structure
- [x] Create src/main/java/com/skillconnect/ directory structure
- [x] Create src/main/webapp/ directory
- [x] Create src/main/webapp/WEB-INF/ directory
- [x] Create src/main/webapp/jsp/ directory
- [x] Create src/main/webapp/css/ directory
- [x] Create src/main/webapp/js/ directory

## 2. Database
- [x] Create skillconnect.sql with schema and tables
- [x] Add sample data to skillconnect.sql

## 3. Models
- [x] Create User.java
- [x] Create WorkerSkill.java
- [x] Create Service.java
- [x] Create Booking.java
- [x] Create Rating.java
- [x] Create Admin.java

## 4. DAO Classes
- [x] Create UserDAO.java
- [x] Create WorkerSkillDAO.java
- [x] Create ServiceDAO.java
- [x] Create BookingDAO.java
- [x] Create RatingDAO.java
- [x] Create AdminDAO.java

## 5. Utils
- [x] Create DBConnection.java

## 6. Servlets
- [x] Create RegisterCustomerServlet.java
- [x] Create RegisterWorkerServlet.java
- [x] Create LoginServlet.java
- [x] Create BookingServlet.java
- [x] Create ProfileServlet.java (for updates)
- [x] Create AdminServlet.java (for admin actions)

## 7. JSP Pages
- [x] Create index.jsp (homepage)
- [x] Create register.jsp (popup or redirect) - modal in index.jsp
- [x] Create customerRegister.jsp
- [x] Create workerRegister.jsp
- [x] Create login.jsp
- [x] Create customerDashboard.jsp
- [x] Create workerDashboard.jsp
- [x] Create adminDashboard.jsp
- [x] Create serviceList.jsp
- [x] Create bookingHistory.jsp
- [x] Other modular JSPs as needed (logout.jsp)

## 8. Configuration
- [x] Create web.xml with servlet mappings

## 9. Styling and Scripts
- [x] Create styles.css
- [x] Create scripts.js (if needed)

## 10. Testing and Deployment
- [x] Verify all files created
- [x] Ensure no syntax errors
- [x] Provide instructions for setup

## 11. Navigation Updates
- [x] Remove "Home" link from about.jsp
- [x] Remove "Home" link from contact.jsp
- [x] Remove "Home" link from profile.jsp
- [x] Remove "Home" link from customerHome.jsp
- [x] Remove "Home" link from rate.jsp
- [x] Change logo href to index.jsp in profile.jsp
- [x] Change logo href to index.jsp in customerHome.jsp
- [x] Change logo href to index.jsp in rate.jsp
- [x] Delete customerHome.jsp
