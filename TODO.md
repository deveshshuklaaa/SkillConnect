# Admin Features Implementation TODO - Breakdown

Based on the approved plan for enhancing the admin dashboard.

## Steps:

- [x] 1. Edit AdminServlet.java: Add imports for CategoryDAO, ServiceDAO, BookingDAO, RatingDAO, StatsDAO, Category, Service, Booking, Rating, StatsDAO.TopRatedWorker, StatsDAO.PopularService.

- [x] 2. Edit AdminServlet.java: In doGet method, add handling for actions: addCategory (create Category from params, call CategoryDAO.addCategory), editCategory (update Category), deleteCategory (call CategoryDAO.deleteCategory), addService (create Service, call ServiceDAO.addService), editService (update Service), deleteService (call ServiceDAO.deleteService), filterBookings (get params, call BookingDAO.getBookingsByFilter, set request attribute), reassignBooking (update booking.worker_id), deleteRating (call RatingDAO.deleteRating), getStats (call StatsDAO methods, set request attributes: totalUsers, activeBookings, topRatedWorker, popularServices).

- [x] 3. Edit adminDashboard.jsp: Add imports for StatsDAO, CategoryDAO, RatingDAO, Category, Rating, StatsDAO.TopRatedWorker, StatsDAO.PopularService, List.

- [x] 4. Edit adminDashboard.jsp: In scriptlet, fetch stats: UserDAO.getTotalUsers(), StatsDAO.getActiveBookingsCount(), StatsDAO.getTopRatedWorker(), StatsDAO.getMostPopularServices(), CategoryDAO.getAllCategories(), RatingDAO.getAllRatings().

- [x] 5. Edit adminDashboard.jsp: Add stats cards section at top: total users, active bookings, top-rated worker, most popular services.

- [x] 6. Edit adminDashboard.jsp: Add Manage Categories section with table displaying categories, and modals for add/edit/delete category (forms submitting to /admin?action=addCategory etc.).

- [x] 7. Edit adminDashboard.jsp: Enhance All Bookings section with filter form: status dropdown, start/end date inputs, workerId/customerId inputs, submit button to /admin?action=filterBookings. Display filtered bookings if attribute set.

- [x] 8. Edit adminDashboard.jsp: Add Manage Feedback section with table of ratings (include customer, worker, rating, feedback), delete buttons for each rating.

- [x] 9. Edit adminDashboard.jsp: For bookings table, add Reassign Provider column with button/modal to select new worker from dropdown (workers list), submit to /admin?action=reassignBooking&bookingId=...&newWorkerId=...

- [x] 10. Compile the project: Run `mvn clean compile` to check for errors.

- [ ] 11. Test: Login as admin, verify all new features (add/edit/delete categories/services, filter bookings, reassign worker, delete rating, stats display). Add sample data if needed.

- [x] 12. Package: Run `mvn package` to build WAR.

- [ ] 13. Update this TODO.md as each step is completed (mark [x]).
