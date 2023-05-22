<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Requirement Document</title>
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
          size: 790px 1080px;
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
          	 
          <%-- 	 content : "Project : <%=ProjectTitle %>"; --%>
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
         <%--    content: "<%=Labcode%>"; --%>
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
          <%--   content: "<%=Labcode%>"; --%>
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
</style>
</head>
<body>
	<div align="center" ><h1 style="font-size:20px !important;color: ;" class="heading-color"><br>APPROVAL PAGE</h1><hr style="width:80%;"></div>
		<div style="text-align:center;">
	<table class="border-black"style="margin-left:20px;border:0px solid black;font-family:FontAwesome; width:650px;">
		<tr>
	<td class="border-black" style="width:650px;text-align: center;"><h4>DOCUMNET APPROVAL SHEET</h4></td>
	</tr>
	</table>
	</div>
</body>
</html>