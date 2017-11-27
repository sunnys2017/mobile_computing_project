package edu.neu.final_app;

import java.io.IOException;
import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import DBController.DBManger;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	@ResponseBody 
	@RequestMapping(value = "/post", method = RequestMethod.POST)
	public void post(@RequestBody String id, HttpServletResponse resp) {
		//
		System.out.println("hello,hello___getposts_____"+id);
		ArrayList<String> posts = new ArrayList<String>();
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;
			
		//
	    String result="\n<package>\n<posts>\n";
	    String resultFinal = "";
	    String result2 = "<>";
	    String result3 = "##";
	    
		try{

			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT * FROM final_app.post WHERE groupNumber ='"+id.substring(3)+"';");
			
			while(rs.next()){
				//System.out.println("oh yeah!");
				result = result +"<post>\n";		
				result = result +"<postTitle>";				
				posts.add(rs.getString("postTitle"));
				result = result + rs.getString("postTitle");
				result = result +"</postTitle>\n<postBody>";
				posts.add(result2);
				
				posts.add(rs.getString("postBody"));
				result = result + rs.getString("postBody");
				result = result +"</postBody>\n<postDate>";
				posts.add(result2);
				
				posts.add(rs.getString("postDate"));
				result = result + rs.getString("postDate");
				result = result +"</postDate>\n<postID>";
				posts.add(result2);
				
				posts.add(rs.getString("postID"));
				result = result + rs.getString("postID");
				result = result +"</postID>\n<userName>";
				posts.add(result2);
				
     			posts.add(rs.getString("userName"));
				result = result + rs.getString("userName");
				result = result +"</userName>\n<name>";
				posts.add(result2);
				
				posts.add(rs.getString("name"));
				result = result + rs.getString("name");
				result = result +"</name>\n<postImage>";
				posts.add(result2);
				
				posts.add(rs.getString("postImage"));
				result = result + rs.getString("postImage");
				result = result +"</postImage>\n<groupNumber>";
				posts.add(result2);
				
				posts.add(rs.getString("groupNumber"));
				result = result + rs.getString("groupNumber");
				result = result +"</groupNumber>\n";
				result = result +"</post>\n";	
				posts.add(result2);
				posts.add(result3);
			}
			result = result +"</posts>\n</package>";
			for(int i =0;i<posts.size();i++){
				resultFinal = resultFinal +posts.get(i);
			}
			stmt.close();
			rs.close();
			connection.close();
			
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("test if connection is ok");
		}
		
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(resultFinal);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@ResponseBody 
	@RequestMapping(value = "/comment", method = RequestMethod.POST)
	public void comment(@RequestBody String id, HttpServletResponse resp) {
		//sql
		System.out.println("hello,hello___comment_____");
		ArrayList<String> posts = new ArrayList<String>();
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;

		
		//zuzhuang.
	    String result="\n<package>\n<comments>\n";
		String resultFinal = "";
	    String result2 = "<>";
	    String result3 = "##";
	    
		try{
			
			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT * FROM final_app.comment WHERE postID ='"+id.substring(3)+"' ;");
			
			while(rs.next()){
				//System.out.println("oh yeah!");
				result = result +"<comment>\n";		
				result = result +"<commentBody>";				
				posts.add(rs.getString("commentBody"));
				result = result + rs.getString("commentBody");
				result = result +"</commentBody>\n<postID>";
				posts.add(result2);
				
				posts.add(rs.getString("postID"));
				result = result + rs.getString("postID");
				result = result +"</postID>\n<commentID>";
				posts.add(result2);
				
				posts.add(rs.getString("commentID"));
				result = result + rs.getString("commentID");
				result = result +"</commentID>\n<commentDate>";
				posts.add(result2);
				
				posts.add(rs.getString("commentDate"));
				result = result + rs.getString("commentDate");
				result = result +"</commentDate>\n<userName>";
				posts.add(result2);
				
     			posts.add(rs.getString("userName"));
				result = result + rs.getString("userName");
				result = result +"</userName>\n<name>";
				posts.add(result2);
				
				posts.add(rs.getString("name"));
				result = result + rs.getString("name");
				result = result +"</name>\n";
				posts.add(result2);
				posts.add(result3);
				result = result +"</comment>\n";	
			}
			result = result +"</comments>\n</package>\n";
			
			for(int i =0;i<posts.size();i++){
				resultFinal = resultFinal +posts.get(i);
			}
			stmt.close();
			rs.close();
			connection.close();
			
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("test if connection is ok");
		}
		
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(resultFinal);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@ResponseBody 
	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public void authenticate(@RequestBody String id, HttpServletResponse resp) {
		//sql
		System.out.println("hello,hello___authenticate_____");
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;
		ArrayList<String> posts = new ArrayList<String>();
		String resultFinal = "";
	    String result2 = "<>";
	    String result3 = "##";	
		//zuzhuang.
	    String result="<package><users>";
	    
		try{
			System.out.println("i am here !~"+id);
			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT * FROM final_app.user WHERE userName ='"+id.substring(3)+"' LIMIT 1;");
			
			while(rs.next()){
				//System.out.println("oh yeah!");
				result = result +"<user>";		
				result = result +"<userName>";				
				
				result = result + rs.getString("userName");
				result = result +"</userName><password>";
				posts.add(rs.getString("userName"));
				posts.add(result2);

				result = result + rs.getString("password");
				result = result +"</password><name>";
				posts.add(rs.getString("password"));
				posts.add(result2);
				
				result = result + rs.getString("name");
				result = result +"</name><profile>";
				posts.add(rs.getString("name"));
				posts.add(result2);

				result = result + rs.getString("profile");
				result = result +"</profile><role>";
				posts.add(rs.getString("profile"));
				posts.add(result2);

				result = result + rs.getString("role");
				result = result +"</role><groupNumber>";
				posts.add(rs.getString("role"));
				posts.add(result2);

				result = result + rs.getString("groupNumber");
				result = result +"</groupNumber>";
				posts.add(rs.getString("groupNumber"));
				posts.add(result2);
				posts.add(result3);

				result = result +"</user>";	
			}
			result = result +"</users></package>";
			for(int i =0;i<posts.size();i++){
				resultFinal = resultFinal +posts.get(i);
			}
			stmt.close();
			rs.close();
			connection.close();
			
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("test if connection is ok");
		}
		
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(resultFinal);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@ResponseBody 
	@RequestMapping(value = "/authenticateWithP", method = RequestMethod.POST)
	public void authenticateWithPassword(@RequestBody String id, HttpServletResponse resp) {
		//sql
		System.out.println("hello,hello___authenticateWithPassword_____");
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;
			
		//zuzhuang.
		String re = id.substring(3);
		ArrayList<String> arr = new ArrayList<String>();
	    for (String retval: re.split("%24", 2)){
	        arr.add(retval); 
	    	System.out.println(retval);
	    }
	    String userName = arr.get(0);
	    String password = arr.get(1);
		int result=0;
	    
	    
		try{
			System.out.println("i am here !~"+id);
			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) AS rowcount1 FROM final_app.User WHERE userName ='"+userName+"' AND password ='"+password+"';");
			
			while(rs.next()){
				//System.out.println("oh yeah!");
				result = rs.getInt("rowcount1");
			}
			
			stmt.close();
			rs.close();
			connection.close();
			
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("test if connection is ok");
		}
		
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@ResponseBody 
	@RequestMapping(value = "/group", method = RequestMethod.POST)
	public void getGroupnumber(@RequestBody String id, HttpServletResponse resp) {
		//sql
		System.out.println("hello,hello__gert row count from_groupid_____");
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;
			
		//zuzhuang.
	    int result=0;
	    
		try{
			System.out.println("i am here !~"+id);
			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) AS rowcount1 FROM final_app.User WHERE groupNumber ='"+id.substring(3)+"';");
			
			while(rs.next()){
				//System.out.println("oh yeah!");
			    result = rs.getInt("rowcount1");
				//posts.add(rs.getString("postTitle"));
			}
			stmt.close();
			rs.close();
			connection.close();
			
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("test if connection is ok");
		}
		
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@ResponseBody 
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public void register(@RequestBody String id, HttpServletResponse resp) {
		//sql
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;
		System.out.println("hello,hello___register_____");	
		//zuzhuang.
	    String result=id;
	    System.out.println(result);
	    String re = result.substring(3);
	    ArrayList<String> arr = new ArrayList<String>();
	    for (String retval: re.split("%24", 5)){
	        arr.add(retval); 
	    	System.out.println(retval);
	    }
	    String userName = arr.get(0);
	    String password = arr.get(1);
	    String groupNumber = arr.get(2);
	    String nickName = arr.get(3);
	    String role = arr.get(4);
		try{
			System.out.println("i am here !~"+id);
			stmt = connection.createStatement();
			connection.setAutoCommit(false);
			stmt.addBatch(
					"INSERT INTO final_app.User " +
		            "VALUES(\""+userName+"\",\""+password+"\",\""+nickName+"\",\""+userName+"\",\""+role+"\",\""+groupNumber+"\")");
			int [] updateCounts = stmt.executeBatch();	
			result ="ok";
			stmt.close();
			//rs.close();
			connection.commit();
			
			connection.setAutoCommit(true);
			connection.close();
		}catch(BatchUpdateException b) {
	        //JDBCTutorialUtilities.printBatchUpdateException(b);
			System.out.println("BatchUpdateException is ok");
	    }catch(SQLException e){
			e.printStackTrace();
			System.out.println("SQLException:test if connection is ok");
		}
		
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

	@ResponseBody 
	@RequestMapping(value = "/postNews", method = RequestMethod.POST)
	public void postNews(@RequestBody String id, HttpServletResponse resp) {
		//sql
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;
		System.out.println("hello,hello___post news by upload param_____");	
		//zuzhuang.
	    String result="";
	    System.out.println(id);
	    String re = id.substring(3);
	    ArrayList<String> arr = new ArrayList<String>();
	    for (String retval: re.split("%23%24")){
	        arr.add(retval); 
	    	System.out.println(retval);
	    }
	    
	    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    Date date1 = new Date();
	    String s = dateFormat.format(date1);

	    String replaceStr = " ";    
	    String userName = arr.get(0);
	    String postTitle = arr.get(1);
	    postTitle =postTitle.replaceAll(Pattern.quote("+"), replaceStr);
	    
	    String postID = arr.get(1)+" "+ s;    //arr.get(2);
	    
	    postID =postID.replaceAll(Pattern.quote("+"), replaceStr);
	    String date = s ; //arr.get(3);
	    String postBody = arr.get(2);

	    postBody = postBody.replaceAll(Pattern.quote("+"), replaceStr);
	    
	    String name = arr.get(3);
        String groupID = arr.get(4);
        String image = arr.get(5);

		try{
			System.out.println("i am here !~"+id);
			
			stmt = connection.createStatement();
			connection.setAutoCommit(false);
			
			stmt.addBatch(
					"INSERT INTO final_app.Post " +
		            "VALUES(\""+postTitle+"\",\""+postBody+"\",\""+date+"\",\""+postID+"\",\""+userName+"\",\""+name+"\",\""+image+"\",\""+groupID+"\")");
			int [] updateCounts = stmt.executeBatch();	
			
			result =arr.get(5);
			System.out.println("i am here !~"+result);
			stmt.close();
			//rs.close();
			connection.commit();
			
			connection.setAutoCommit(true);
			connection.close();
		}catch(BatchUpdateException b) {
	        //JDBCTutorialUtilities.printBatchUpdateException(b);
			System.out.println("BatchUpdateException is ok");
	    }catch(SQLException e){
			e.printStackTrace();
			System.out.println("SQLException:test if connection is ok");
		}
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

	@ResponseBody 
	@RequestMapping(value = "/postComments", method = RequestMethod.POST)
	public void postComments(@RequestBody String id, HttpServletResponse resp) {
		//sql
		Connection connection = DBManger.getConnection();
		Statement stmt;
		ResultSet rs;
		System.out.println("hello,hello___post news by upload param_____");	
		//zuzhuang.
	    String result="";
	    System.out.println(id);
	    String re = id.substring(3);
	    ArrayList<String> arr = new ArrayList<String>();
	    for (String retval: re.split("%23%24")){
	        arr.add(retval); 
	    	System.out.println(retval);
	    }
	    
	    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	    Date date1 = new Date();
	    String s = dateFormat.format(date1);

	    String replaceStr =" ";
	    String postID = arr.get(0);
	    String commentBody = arr.get(1);
	    commentBody =commentBody.replaceAll(Pattern.quote("+"), replaceStr);
	    String name = arr.get(2);
	    //name =name.replaceAll(Pattern.quote("+"), replaceStr);
	    String date = s ; //arr.get(3);
        String n = "";


		try{
			System.out.println("i am here !~"+id);
			
			stmt = connection.createStatement();
			connection.setAutoCommit(false);
			
			stmt.addBatch(
					"INSERT INTO final_app.Comment " +
		            "VALUES(\""+commentBody+"\",\""+postID+"\",\""+n+"\",\""+date+"\",\""+n+"\",\""+name+"\")");
			int [] updateCounts = stmt.executeBatch();	
			
			result ="ok";
			System.out.println("i am here !~"+result);
			stmt.close();
			//rs.close();
			connection.commit();
			
			connection.setAutoCommit(true);
			connection.close();
		}catch(BatchUpdateException b) {
	        //JDBCTutorialUtilities.printBatchUpdateException(b);
			System.out.println("BatchUpdateException is ok");
	    }catch(SQLException e){
			e.printStackTrace();
			System.out.println("SQLException:test if connection is ok");
		}
		
		
		
		//model.addAttribute("result", result);
		try {
			resp.getWriter().print(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
