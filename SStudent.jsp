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
<title>Students for class</title>
</head>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<body>

	<%
String idClass = request.getParameter("class");
if (idClass == null){
	out.println("redireccionando");
	response.sendRedirect("SClass.jsp");
	response.setHeader("Connection", "close");
}

try{
Class.forName("com.mysql.jdbc.Driver");
Connection conexion = DriverManager.getConnection("jdbc:mysql://127.0.0.1/s4","root","");
//out.println("Conexión realizada con éxito a: "+conexion.getCatalog());
Statement consulta = conexion.createStatement(
ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
String name = request.getParameter("sname");
String lastname = request.getParameter("slastname");
if (name != null){
	
	consulta.executeUpdate("insert into student(name,lastname,status)values('" + name + "', '" + lastname + "',1)");
	ResultSet rsID = consulta.executeQuery("SELECT MAX(id) FROM student");
	rsID.afterLast();
	rsID.previous();
	consulta.executeUpdate("insert into class_student(id_class,id_student,status)values(" + idClass + ", " + rsID.getString(1) + ",1)");	
	out.println("Data is successfully inserted!");
}
ResultSet rs=consulta.executeQuery("select s.name, s.lastname from s4.student s "+
									" inner join s4.class_student cs " +
									"on s.id = cs.id_student where id_class = " + idClass);
rs.afterLast();
boolean seguir = rs.previous();
%>
	<h1>List of Students</h1>
	<button type="button" class="btn btn-default"
		onclick="document.location='SClass.jsp'">
		<i class="fa fa-book" aria-hidden="true"></i> Class List
	</button>
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
				<th>Name</th>
				<th>Last Name</th>
				<th>Status</th>

			</tr>

		</thead>
		<tbody>
			<form action="#" method="post">
				<tr>
					<td><input type="hidden" name="idClass" id="idClass"
						value="<%= idClass %>"> <input type="text" name="sname"
						id="sname"></td>
					<td><input type="text" name="slastname" id="slastname">
					</td>
					<td><input type="submit" class="btn btn-default"
						value="Add Student"></td>
				</tr>
			</form>
			<%
		
	while(seguir){ %>
			<tr>
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
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
	<%="Se produjo una excepción durante la conexión:"+ex%>
	<%} catch(Exception ex){ %>
	<%="Se produjo una excepción:"+ex%>
	<%}%>
</body>
</html>