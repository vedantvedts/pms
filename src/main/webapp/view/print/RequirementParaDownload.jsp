<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Para Details</title>
<%
String lablogo=(String)request.getAttribute("lablogo");
Object[]PfmsInitiationList=(Object[])request.getAttribute("PfmsInitiationList");
Object[]LabList=(Object[])request.getAttribute("LabList");
List<Object[]>ParaDetails=(List<Object[]>)request.getAttribute("ParaDetails");
%>
<style>
td{
	padding : -13px 5px;
}
 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
		@page{             
          size: 790px 1050px;
          margin-top: 49px;
          margin-left: 49px;
          margin-right: 49px;
          margin-buttom: 49px; 	
          border: 2px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          
          @top-right {
         	 content : "Project : <%=PfmsInitiationList[6].toString() %>";
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
   		   
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
          <%--   content: "<%=Labcode%>"; --%>
          }  
          @top-center { 
          font-size: 13px;
          margin-top: 30px;
          
          }  
          @bottom-center { 
          font-size: 13px;
           margin-bottom: 30px;
         
          }
          @bottom-left { 
           font-size: 13px;
	        margin-bottom: 30px;
	      content: "<%=PfmsInitiationList[5].toString()%>"; 
          }   
 }
  .border-black{
 border:1px solid black !important;
 border-collapse: collapse !important;
 }
 .border-black td th{
 padding:0px !important;
 margin: 0px !important;
 }
 p{
 text-align: justify !important;
 padding:12px;
 }
 span{
 background: white !important;
 color:black;
 }
 #tablediv>table{
 width:100px;
 		@page{             
         size: 1120px 1080px;
         }
 }
 .border-black{
 border:1px solid black;
 border-collapse: collapse;
 }
</style>
</head>
<body>
		<div style="page-break-before:always"></div> 
		<div style="text-align: center;">
		<h1 style="font-size: 20px !important;" class="heading-color">SQR Para </h1>
		<hr style="width:80%;">
		<%if(!ParaDetails.isEmpty()) {
			int count=0;
		for(Object[]obj:ParaDetails){
		%>
		<div align="left" style="padding:10px"><span style="font-weight: 600; ">Para<%="-"+(++count) %>- <%=obj[3].toString() %> </span></div>
		<%if(obj[4]!=null){ %><%=obj[4].toString()%><%}else {%>No Details added<%} %>
		<%} }%>
		</div>
</body>
</html>