<%@page import="java.util.Base64"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
.id1:hover {
  background-color: #555555;
  color: white;
 
}
.id1{
 border-radius: 8px;
}
#products {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#products td, #products th {
  border: 1px solid #ddd;
  padding: 8px;
}

#products tr:nth-child(even){background-color: #f2f2f2;}

#products  tr:hover {background-color:black;color: white;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
#button{
 border-radius: 50%;
 font-size: 10px;
}
</style>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<!--Get your own code at fontawesome.com-->
</head>
<a href="AdminWelcome.jsp"><i class="fa fa-arrow-circle-left" style="font-size:24px"></i></a>
<div style="color: black; text-align: center; font-size: 30px;">All Products & Edit Products <i class='fab fa-elementor'></i></div>
<%
String msg=request.getParameter("msg");
if("done".equals(msg))
{
%>
<h3 class="alert">Product Successfully Updated!</h3>
<%} %>
<%if("worng".equals(msg)) 
{
%>
<h3 class="alert">Some thing went wrong! Try again!</h3>
<%} %>




<div class="col-md-8">

<div>
<hr>
</div>
</div>

   
       <table class="table table-dark" id="products">

      
        <thead>
          <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Category</th>
            <th scope="col"><i class="fa fa-inr"></i> Price</th>
            <th>Active</th>
            <th>Description</th>
            <th>Photo</th>
            <th scope="col"><i class='fas fa-edit' style='font-size:24px'></i></th>
          </tr>
        </thead>
        <tbody>
       <%
       try
       {
    	   Class.forName("com.mysql.jdbc.Driver");  
    		Connection con=DriverManager.getConnection(  
    				"jdbc:mysql://localhost:3306/vastracollection","root","");  
    	   PreparedStatement ps=con.prepareStatement("select * from dress");
    	   ResultSet set=ps.executeQuery();
    	   while(set.next())
			{
				 Blob blob = set.getBlob(7);
                
               InputStream inputStream = blob.getBinaryStream();
               ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
               byte[] buffer = new byte[4096];
               int bytesRead = -1;
                
               while ((bytesRead = inputStream.read(buffer)) != -1)
               {
                   outputStream.write(buffer, 0, bytesRead);                  
               }
                
               byte[] imageBytes = outputStream.toByteArray();
               String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                
               pageContext.setAttribute("base64Image", base64Image);
           
               inputStream.close();
               outputStream.close(); 
    	   
    
       %>
       
      

          <tr>
         
            <td><%=set.getString(1)%></td>
            <td><%=set.getString(2)%></td>
            <td><%=set.getString(3)%></td>
            <td><i class="fa fa-inr"></i> <%=set.getString(4)%></td>
            <td><%=set.getString(5)%></td>
            <td><%=set.getString(6)%></td>
            <td> <img src="data:image/jpg;base64,${base64Image}"  class="card-img" alt="..." width="120" height="150"/></td>
            <td><a href="Edit.jsp?id=<%=set.getString(1)%>"> <button  class="id1" type="button" >Update</button> </a> <a href=Deleteproduct.jsp?id=<%=set.getString(1)%>"><button  class="id1" type="button" >Delete</button></a></td>
          </tr>
         <%}}
       catch(Exception e)
       {
    	   e.printStackTrace();
       }
       %>
        </tbody>
      </table>
      <br>
      <br>
      <br>

</body>
</html>