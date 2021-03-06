package dao;

import bean.ActivityBean;
import bean.CommentBean;
import bean.UserPosition;
import bean.UserinfoBean;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public interface ActivityDao {
    int addActivity(ActivityBean activityBean) throws Exception;

    ActivityBean getActivity(int id) throws Exception;

    List<ActivityBean> fetchActivityList() throws Exception;

    boolean getRegisterState(String username, int activityID) throws Exception;

    int userJoinActivity(String username, int activityID) throws Exception;

    int userDeregisterActivity(String username, int activityID) throws Exception;

    int checkObserveAvailability(String username, int activityID) throws Exception;

    int setParticipantLocation(String username, int activityID, double x, double y) throws Exception;

    Map<String, UserPosition> getActivityLocations(int activityID, String lastUpdate) throws Exception;

    int addComments(int activityID, String username, String comments, LinkedList<String> urls) throws Exception;

    LinkedList<CommentBean> getComments(int activityID) throws Exception;
}
