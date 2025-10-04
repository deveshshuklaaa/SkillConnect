# TODO: Fix Security and Best Practice Issues in SkillConnect

## Completed
- [x] Analyze project and identify problems

## Pending
- [x] Add bcrypt dependency to pom.xml for password hashing
- [x] Create Config.java class to load DB credentials from environment variables
- [x] Update DBConnection.java to use Config and enable SSL
- [x] Update RegisterServlet.java: add password hashing, server-side validation, improve error handling
- [x] Update LoginServlet.java: add hash verification, server-side validation, improve error handling
- [x] Implement CSRF protection: add tokens to HTML forms and validate in servlets
- [x] Update web.xml for session timeout and secure cookies
- [x] Test the application functionality after fixes (compiled successfully)
