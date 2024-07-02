<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Committe Enote</title>
<style type="text/css">
.break {
	page-break-after: always;
}

#pageborder {
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	border: 2px solid black;
}

@page {
size: 790px 1050px;
margin-top: 49px;
margin-left: 50px;
margin-right: 50px;
margin-buttom: 49px;
border: 2px solid black;

@bottom-right {
	counter-increment: page;
			counter-reset: page 2;
	content: "Page "counter(page) " of "counter(pages);
	margin-bottom: 30px;
	margin-right: 10px;
}

	@top-right {
		content: "";
		margin-top: 30px;
		margin-right: 10px;
	}

	@top-left {
		margin-top: 30px;
		margin-left: 10px;
	
	}

	@top-center {
		margin-top: 30px;
		content: "";

	}

	@bottom-center {
		margin-bottom: 30px;
		font-size: 12px;
		content: "This is computer generated statement no signature required";
	}
}

p {
	text-align: justify;
	text-justify: inter-word;
}

body
{
	font-size:14px !important;
}

div
{
	width: 650px !important;
}
table{
	align: left;
	width: 650px !important;
	max-width: 650px !important;
	margin-top: 10px; 
	margin-bottom: 10px;
	margin-left:10px;
	border-collapse:collapse;
	
}
th,td
{
	text-align: left;
	border: 1px solid black;
	padding: 4px;
	word-break: break-word;
	overflow-wrap: anywhere;
	
	 -ms-word-break: break-all;
     word-break: break-all;

     /* Non standard for WebKit */
     word-break: break-word;

-webkit-hyphens: auto;
   -moz-hyphens: auto;
        hyphens: auto;
	
}
.center{

	text-align: center;
}

.right
{
	text-align: right;
}
input{
border-width: 0 0 1px 0;
width:80%;
}
input:focus {
  outline: none;
}

.text-blue
{
	color: blue;
	font-weight:500px;
	font-size: 15px;
}
body{
background-color:DBEDC7;
}
</style>
</head>
<body>
<%
Object[]CommitteMainEnoteList = (Object[])request.getAttribute("CommitteMainEnoteList");
SimpleDateFormat rdf= new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdtf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat rdtf= new SimpleDateFormat("dd-MM-yyyy hh:mm a");
FormatConverter fc = new FormatConverter();
SimpleDateFormat sdf = fc.getRegularDateFormat();
SimpleDateFormat sdf1 = fc.getSqlDateFormat();
SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
List<Object[]>EnotePrintDetails = (List<Object[]>)request.getAttribute("EnotePrintDetails");
String path=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/";

%>
<div align="center">
<div style="width: 100%;border: 0;text-align: center;"><h3> <b style="font-size:18px;text-decoration:underline">Note&nbsp;:&nbsp;<%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[2]!=null){%>Note_<%=sdf.format(sdf1.parse(CommitteMainEnoteList[2].toString()))%><%} %></b></h3></div>
<div style="width: 100%;border: 0;text-align: center;"> <span style="float: left;"><b style="font-size:18px; margin-left: 14px;">Ref No&nbsp; : &nbsp;<span style="color: blue; font-size: 16px;"><%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[1]!=null){%><%=CommitteMainEnoteList[1].toString()%><%}else{%>-<%}%></span></b></span><span style="float: right;"><b style="font-size:16px;">Date : &nbsp;<%=sdf.format(sdf1.parse(CommitteMainEnoteList[2].toString()))%></b></span> </div>
<br><br><br>
	<table style="border-collapse: collapse;">
	<tr>
	<td style="border: none; width: 25%;"><span style="font-size: 14px; color: blue;"><b style="margin-left:20px; color:black; ">Subject :</b></span></td>
	<td style="border: none;"><span style="font-size: 14px; color: blue;"><%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[3]!=null){%><%=CommitteMainEnoteList[3].toString()%><%}else{%>-<%}%></span></td>
	</tr>
	<tr>
	<td style="border: none; width:25%;"><span style=" font-size: 14px; color: blue;"><b style="margin-left:20px; color: black;">Comment :</b></span></td>
	<td style="border: none;"><span style="font-size: 14px; color: blue;"><%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[4]!=null && CommitteMainEnoteList[4].toString().length()>0){%><%=CommitteMainEnoteList[4].toString().replaceAll("\n", "<br>")%><%}else{%>-<%}%></span> </td>
	</tr>
	<tr>
	<td style="border: none; width:25%;"><span style=" font-size: 14px; color: blue;"><b style="margin-left:20px; color: black;">Committee Letter :</b></span></td>
	<td style="border: none;"><span style="font-size: 14px; color: blue;"><%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[5]!=null){%><a href="<%=path%>CommitteeConstitutionLetterDownload.htm?committeemainid=<%=CommitteMainEnoteList[5].toString()%>&flag=<%="P"%>" target="_blank">Download</a><%}else{%>No Attachment!<%}%></span> </td>
	</tr>
	</table>
</div>
</body>
</html>