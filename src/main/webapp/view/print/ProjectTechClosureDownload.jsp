<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Technical Closure Report</title>
<%

String lablogo=(String)request.getAttribute("lablogo");

Object[]LabList=(Object[])request.getAttribute("LabList");


FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf3=fc.getRegularDateFormat();
SimpleDateFormat sdf=fc.getRegularDateFormatshort();
SimpleDateFormat sdf1=fc.getSqlDateFormat();
String labImg=(String)request.getAttribute("LabImage");
List<Object[]>MemberList=(List<Object[]>)request.getAttribute("MemberList");
List<Object[]> DocumentSummary=(List<Object[]>)request.getAttribute("DocumentSummary");
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");

int port=new URL( request.getRequestURL().toString()).getPort();
String path=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/";
String conPath=(String)request.getContextPath();
LocalDate d = LocalDate.now();
int contentCount=0;
Month month= d.getMonth();
int year=d.getYear();
String fontSize = "16";
String SubHeaderFontsize ="14";
String SuperHeaderFontsize="13";
String ParaFontSize ="12" ;
String ParaFontWeight="normal";
String HeaderFontWeight="Bold";
String SubHeaderFontweight="Bold";
String SuperHeaderFontWeight="Bold";
String FontFamily="Times New Roman";


List<Object[]> RecordOfAmendments=(List<Object[]>)request.getAttribute("RecordOfAmendments");
List<Object[]> AppendicesList=(List<Object[]>)request.getAttribute("AppendicesList");
String projectShortName =(String)request.getAttribute("projectShortName");

%>
<style>
    /* Define header and footer styles */
 .static-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        text-align: center;
    }
.static-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        text-align: center;
    }
    .logo-container {
        width: 33.33%;
    }

    .logo {
        width: 80px;
        height: 80px;
        margin-bottom: 5px;
    }
    /* Your existing styles... */
</style>
<style>
/* td {
	padding: -13px 5px;
} */
#pageborder {
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	border: 2px solid black;
}
@page {
	size: 770px 1050px;
	margin-top: 49px;
	margin-left: 49px;
	margin-right: 49px;
	margin-bottom: 69px;
	border: 2px solid black;
	
	 @ bottom-right { content : "Page " counter(page) " of " counter( pages);
	margin-bottom: 50px;
	width:100px;;
}
@
top-right {

	margin-top: 30px;
	margin-right: 10px;
}
@
top-left {
	margin-top: 30px;
	margin-left: 10px;
	content:
	
}
@
top-left {
	margin-top: 30px;
	margin-left: 10px; <%--
	content: "<%=Labcode%>";
	--%>
}
@
top-center {
	font-size: 13px;
	margin-top: 30px;
	content:"RESTRICTED"
}
@
bottom-center {
	font-size: 13px;
	/* margin-bottom: 30px; */
	margin-right:20px;
	content:"This information given in this document is not to be published or communicated either directly or indirectly , to the press  or to any personnel not authorized to recieve it."
}

.border-black {
	border: 1px solid black !important;
	border-collapse: collapse !important;
}
.border-black td th {
	padding: 0px !important;
	margin: 0px !important;
}
p {
	text-align: justify !important;
	padding: 5px;
}
span {
	background: white !important;
	color: black;
}

.border-black {
	border: 1px solid black;
	border-collapse: collapse;
	padding:5px;
}

.text-dark{
padding:5px;
}
.text-darks{
padding:5px;
text-align: left;
}
.heading-colors{
text-align: left;
margin-left:8px;
}

#table1{
margin-left:15x;
}  

.table.table-bordered{

border:1px solid black;
border-collapse:collapse;

}

.table-bordered th,td{

  border:1px solid black;
  padding: 8px;
}




</style>
</head>
<body>
  <%
   // Default font size
        if (DocTempAtrr != null && DocTempAtrr[0] != null) {
        	fontSize=DocTempAtrr[0].toString();
       }
  //  SubHeader font size
        if (DocTempAtrr != null && DocTempAtrr[2] != null) {
              SubHeaderFontsize = DocTempAtrr[2].toString(); 
        }
     //  Super Header font size
      	if(DocTempAtrr!=null && DocTempAtrr[9]!=null){
        		SuperHeaderFontsize=DocTempAtrr[9].toString();
    	    	}
    	 if(DocTempAtrr!=null && DocTempAtrr[4]!=null){
        		ParaFontSize= DocTempAtrr[4].toString();
    	    	}
    	 if(DocTempAtrr!=null && DocTempAtrr[5]!=null){
    	    	ParaFontWeight=DocTempAtrr[5].toString();
    	    	}
    	  if(DocTempAtrr!=null && DocTempAtrr[1]!=null){
    	    		HeaderFontWeight= DocTempAtrr[1].toString();
    	    	}
        if(DocTempAtrr!=null && DocTempAtrr[3]!=null){
        		SubHeaderFontweight= DocTempAtrr[3].toString();
    	    	}
                if(DocTempAtrr!=null && DocTempAtrr[10]!=null){
        	SuperHeaderFontWeight= DocTempAtrr[10].toString();
        }
                if(DocTempAtrr!=null && DocTempAtrr[11]!=null){
                	FontFamily= DocTempAtrr[11].toString();
                }
                
                List<Object[]>  Content=(List<Object[]>)request.getAttribute("TechnicalClosureContent");       
                
                
                
    	        %>
    	        
    	        
  <div class="heading-container" style="text-align: center; position: relative;"></div>
  <br><br><br><br><br><br><br><br><br><br><br><br>
      <div align="center"></div>
			<div style="text-align: center; margin-top: 75px;">
				<h4 style="font-size: 18pt;;font-family:<%= FontFamily %>; !important;" class="heading-color ">TECHNICAL PROJECT CLOSURE REPORT</h4>
			
				
				<div align="center" >
					<img class="logo" style="width: 80px; height: 80px; margin-bottom: 5px"
						<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration"
						<%} else {%> alt="File Not Found" <%}%>>
				</div>
				
				<div align="center">
					<h4 style="font-size: 20px;font-family: <%= FontFamily %>;">
					
						<% if(LabList!=null && LabList[1] != null) { %>
						        <%=LabList[1].toString()+"("+LabList[0].toString()+")"%>
						<%}else{
						
						%>-<%}%>
				
					</h4>
					
					<h4 style="font-family: <%= FontFamily %>;">
						Government of India, Ministry of Defence<br>Defence Research
						& Development Organization
					
					</h4>
				</div>
				<h4 style="font-family: <%= FontFamily %>;">
					<%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %>
					<%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %>
					<%}else{ %>
					-
					<%} %>
				</h4>
				
<div style="text-align: right;margin-right:20px;">
            <span style="font-weight: bold;font-family: <%= FontFamily %>;"><%= month.toString().substring(0,3) %> <%= year %></span>
</div>
	  </div>
			<br>
			<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>	
		<!------------------------ page 2 -------Starts----------------------->
 
	<div class="heading-container" style="text-align: center; position: relative;"></div>
       <div style="text-align: center;font-family: <%= FontFamily %>;">
			<h5  class="heading-color">RECORD OF AMENDMENTS </h5>
				
				
	  </div>
			<table style="width: 650px;margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
				
				<tr>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">SL No.</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">Particulars of Amendment.</span></td>
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;"><span class="text-dark">Revision No.</span></td>
                    <td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black;width: 100px; text-align: center;"><span class="text-dark">Issue Date</span></td>
				</tr>
				
				<tbody id="blankRowsBody">
				
				<% 
				   int count=0;
				   if(RecordOfAmendments!=null && RecordOfAmendments.size()>0){
				   for(Object[] obj:RecordOfAmendments){ %>
						  
		      <tr>
                  <td align="center" class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span><%=++count%></td>
		          <td align="center" class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span><%=obj[1]%></td>
		          <td align="center" class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span><%=obj[2]%></td>
		          <td align="center" class="text-dark" style="border:1px solid black;font-family: <%= FontFamily %>;"><span class="text-dark"></span><%=fc.SqlToRegularDate(obj[3].toString())%></td>
             </tr>
        
         <%}} %> 
	</tbody>
</table>

		<p style="text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
       <div class="heading-container" style="text-align: center; position: relative;"></div>

				<div align="center">
					<div style="text-align: center;">
				<h5  class="heading-color; "style="font-family: <%= FontFamily %>;">DISTRIBUTION LIST </h5>
				
					</div>
					
			<table style="width: 650px;margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
				
				<tr>
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; width: 20px;text-align: center;"><span class="text-dark">S.No</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black; width: 250px;text-align: center;"><span class="text-dark">NAME</span></td>
					<td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;width: 150px;"><span class="text-dark">Designation</span></td>
					<td class="text-dark"   style="font-family: <%= FontFamily %>;border:1px solid black;width: 150px; text-align: center;"><span class="text-dark">Division/Lab</span></td>
					<%-- <td class="text-dark"  style="font-family: <%= FontFamily %>;border:1px solid black; text-align: center;width: 80px;"><span class="text-dark">Remarks</span></td> --%>
				</tr>
				
				<tbody id="blankRowsBody1"></tbody>
				
            <% 
			    if (MemberList != null) {
			        int i = 1;
			        for (Object[] mlist : MemberList) { %>
			        
         <tr>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;"><%=  i+++"."%></td>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;"><%= mlist[1] %></td>
                <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;"><%= mlist[2] %></td>
                 <td class="text-dark"  style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;"><%= mlist[3] %></td>
                 <%-- <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;">copy for Record</td> --%>
         </tr>
         
     <%}}%>
			</table>
			</div>
			
				<p style="font-family: <%= FontFamily %>;text-align: center; page-break-before: always;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
				<div class="heading-container" style="text-align: center; position: relative;"></div>

				<div style="text-align: center;">
				     <h4 style="font-size: 20px !important;font-family: <%= FontFamily %>;" class="heading-color">DOCUMENT SUMMARY </h4>
				</div>
	
				<table style="width: 650px; margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;font-family: <%= FontFamily %>;border-collapse: collapse;">
				
				<tr>
					  <td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;text-align:left">1.&nbsp; Title: <span class="text-darks">Technical Project Closure Report  - <% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[12] %><%} %></span></td>
			   </tr>
			   
				<tr>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">2.&nbsp; Type of Document:<span class="text-darks">Technical Closure Report for  <% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[12] %><%} %></span></td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">3.&nbsp; Classification: <span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[13] %><%} %></span></td>
			   </tr>
			   
			   <tr>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">4.&nbsp; Document Number:</td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">5.&nbsp; Month Year:&nbsp;<span style="font-weight: 600"><%=month.toString().substring(0,3) %></span> <%= year %></td>
			  </tr>
			  
			   <tr>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">6.&nbsp; Number of Pages: </td>
					<td class="text-darks" style="border:1px solid black;font-family: <%= FontFamily %>;">7.&nbsp; Related Document:</td>
			  </tr>
			  
			   <tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">8.&nbsp; Additional Information:<span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[0] %><%} %></span></td>
			   </tr>
			   
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">9.&nbsp; Project No & Name: <span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[11] %> - <%=DocumentSummary.get(0)[12] %><%} %> </span></td>
				</tr>
				
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">10.&nbsp; Abstract:<span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[1] %><%} %></span>
			   </tr>
			   
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">11.&nbsp; Keywords:<span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[2] %><%} %></span> </td>
				</tr>
				
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">12.&nbsp; Organization and address:
						<span class="text-darks" style="font-family: <%= FontFamily %>;"><%
										if (LabList!=null && LabList[1] != null) {
										%><%=LabList[1].toString() + "(" + LabList[0].toString() + ")"%>
										<%
										} else {
										%>-<%
										}
										%>
																	Government of India, Ministry of Defence,Defence
										Research & Development Organization
										<%
									if (LabList!=null && LabList[2] != null && LabList[3] != null && LabList[5] != null) {
									%>
									<%=LabList[2] + " , " + LabList[3].toString() + ", PIN-" + LabList[5].toString()+"."%>
									<%}else{ %>
									-
									<%} %>
						</span>
					</td>
				</tr>
				
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">13.&nbsp; Distribution:<span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[3] %><%} %></span></td>
				</tr>
				
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">14.&nbsp; Revision:</td>
				</tr>
				
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">15.&nbsp; Prepared by:<span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[10] %><%} %></span></td>
			   </tr>
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">16.&nbsp; Reviewed by: <span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[7] %><%} %></span> </td>
				</tr>
				
				<tr>
					<td  class="text-darks" colspan="2" style="border:1px solid black;font-family: <%= FontFamily %>;">17.&nbsp; Approved by: <span class="text-darks"><% if(DocumentSummary!=null && DocumentSummary.size()>0 ){%><%=DocumentSummary.get(0)[6] %><%} %></span> </td>
				</tr>
				
			</table>


	<div style="page-break-before: always"></div>

	<%
	int maincount = 0;
	for (Object[] obj : Content) {
		if (obj[1].toString().equalsIgnoreCase("0")) {
	%>
	<h1 style="font-family: <%= FontFamily %>; font-size: <%= fontSize %>pt; font-weight: <%= HeaderFontWeight %>;" class="heading-colors">
                                 <%=++maincount%>.&nbsp;<%=obj[3].toString() %>
                       </h1>
             <div>
				   <div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt;font-weight:<%=ParaFontWeight%>" >
					     <div style="text-align: justify;font-family: <%= FontFamily %>;font-weight:200;"><%if(obj[4]!=null) {%><%=obj[4]%><%}%>
				
					     </div>
					</div>
			</div>		
					
					
					
				<% if(obj[3].toString().equalsIgnoreCase("APPENDICES")) { %>
			
			
					<table style="width: 650px;margin-left:10px; margin-top: 10px; margin-bottom: 5px;border:1px solid black;border-collapse: collapse;">
						
						<tbody id=""></tbody>
						
			           <% 
					    if (AppendicesList != null) {
					        int i = 1;
					        for (Object[] alist : AppendicesList) { %>
					        
			        <tr>
			               <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;"><%=i+++"."%></td>
			               <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black;padding-left: 10px;"><% if(alist[1]!=null){ %><%=alist[1] %><%}%></td>
			               <td class="text-dark" style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;"><% if(alist[2]!=null){ %><%=alist[2] %><%}%></td>
			               <td class="text-dark"  style="font-family: <%= FontFamily %>;border: 1px solid black; padding-left: 10px;">
			               
			                <%if(alist[3]!=null && !alist[3].toString().isEmpty()) {%>
								<a  class="btn btn-sm" style="padding: 5px 8px;" href="AppendicesDocumentDownload.htm?attachmentfile=<%=alist[0]%>" >
									Download</a>
 											    
								<%}%>
								
			               </td>
			        </tr>
			        
			      <%}}%>
			      
					</table>
			
			<%} %>	
					
					
					
			
			
			<% 
			int level1count=0;
			for(Object[] obj1:Content){
				if(obj1[1].toString().equalsIgnoreCase(obj[0].toString())){ %>
			
			            <h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors">
					&nbsp; <%=maincount%>. <%=++level1count%>&nbsp;<%=obj1[3].toString() %>
				       </h2>
             <div>
				   <div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
					     <div style="text-align: justify;font-family: <%= FontFamily %>;font-weight:200;"><% if(obj1[4]!=null){%><%=obj1[4] %><%} %></div>
					</div>
					
		</div>
			
			<% 
			int level2count=0;
			for(Object[] obj2:Content){
				if(obj2[1].toString().equalsIgnoreCase(obj1[0].toString())){ %>
			
			            <h2 style="font-family: <%= FontFamily %>;margin-left: 10px;font-weight:<%=SubHeaderFontweight%>;font-size: <%= SubHeaderFontsize%>pt;"class="heading-colors">
					&nbsp; <%=maincount%>. <%=level1count%>. <%=++level2count%>&nbsp;<%=obj2[3].toString() %>
				       </h2>
             <div>
				   <div style="margin-left: 10px;font-family: <%= FontFamily %>;font-size:<%=ParaFontSize%>pt; text-align: justify;font-weight:<%=ParaFontWeight%>" >
					     <div style="text-align: justify;font-family: <%= FontFamily %>;font-weight:200;"><% if(obj2[4]!=null){%><%=obj2[4] %><%} %></div>
					</div>
			</div>
			
		<%}}%>
			
	<%}}%>
			
<%}}%> 
			
			
			
	       
	       
	
		
</body>
</html>