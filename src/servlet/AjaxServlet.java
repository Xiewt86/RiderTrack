package servlet;

import com.google.gson.Gson;
import service.ActivityService;
import service.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AjaxServlet", urlPatterns = {"/AjaxServlet"})
public class AjaxServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        ActivityService activityService = new ActivityServiceImpl();
        String activityID = (String) request.getSession().getAttribute("activity_id");
        String lastUpdate = request.getParameter("lastUpdate");
        System.out.println(lastUpdate);

        // Download all the position info to servlet
        String jsonObject = activityService.getActivityLocations(Integer.parseInt(activityID), lastUpdate);
        System.out.println(jsonObject);
        out.print(jsonObject);
        out.flush();
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        ActivityService activityService = new ActivityServiceImpl();
        String username = (String) request.getSession().getAttribute("username");
        String activityID = (String) request.getSession().getAttribute("activity_id");
        String x = request.getParameter("v1");
        String y = request.getParameter("v2");

        // Upload position info to db
        activityService.setParticipantLocation(username, Integer.parseInt(activityID), Double.parseDouble(x), Double.parseDouble(y));
        out.flush();
    }


}