package servlet;

import service.ActivityService;
import service.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "JoinOrCancelServlet", urlPatterns = {"/JoinOrCancelServlet"})
public class JoinOrCancelServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        String activityID = request.getParameter("activity_id");
        String username = request.getParameter("username");
        String type = request.getParameter("type");

        ActivityService activityService = new ActivityServiceImpl();
        if (type.equals("J")) {
            int result = activityService.userJoinActivity(username, Integer.parseInt(activityID));
            out.print(result + "J");
            out.flush();
        } else {
            int result = activityService.userDeregisterActivity(username, Integer.parseInt(activityID));
            out.print(result + "D");
            out.flush();
        }
    }
}
