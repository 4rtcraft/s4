<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<title>List of available classes</title>
</head>
<%@page import="java.sql.*"%>
<%
try{
Class.forName("com.mysql.jdbc.Driver");
Connection conexion = DriverManager.getConnection("jdbc:mysql://127.0.0.1/s4","root","");
//out.println("Conexión realizada con éxito a: "+conexion.getCatalog());
Statement consulta = conexion.createStatement(
ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

String cname = request.getParameter("cname"); 

if (cname != null){
	consulta.executeUpdate("insert into sclass(classname,status)values('"+cname+"',1)");
	out.println("Data is successfully inserted!");
}
ResultSet rs=consulta.executeQuery("SELECT * FROM sclass");
rs.afterLast();
boolean seguir = rs.previous();

%>
<body>
	<h1>List of classes</h1>
	<%
	if (!seguir){
		%>
	<tr>
		<td colspan="2">There is not information yet</td>
	</tr>
	<% 
	}
	%>
	<table class="table">
		<thead>
			<tr>
				<th>Class</th>
				<th>State</th>
			</tr>

		</thead>
		<tbody>
			<form action="#" method="post">
				<tr>
					<td><input type="text" name="cname" id="cname"
						class="form-control" placeholder="Class Name"></td>
					<td><input type="submit" class="btn btn-default"
						value="Save Class"></td>
				</tr>
			</form>
			<%
		
	while(seguir){ %>
			<tr>
				<td><a href="SStudent.jsp?class=<%= rs.getString(1) %>"><%=rs.getString(2)%></a>
				</td>
				<td><%= rs.getString(3) %></td>
			</tr>
			<% seguir = rs.previous(); 
	} 
	%>
		</tbody>
	</table>
	<%
	
rs.close();
consulta.close();
conexion.close();
} catch(SQLException ex)
{ %>
	<%="Se produjo una excepción durante la conexión:" + ex%>
	<%} catch(Exception ex){ %>
	<%="Se produjo una excepción:"+ex%>
	<%}
finally{}%>
</body>
</html>