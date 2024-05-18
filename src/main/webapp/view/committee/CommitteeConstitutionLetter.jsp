<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="com.vts.pfms.FormatConverter"%>

<%
String email=(String)request.getAttribute("email");  
if(!email.equals("Y")){ %>
<!DOCTYPE html>
<html>
<head>
<title>Committee Formation Letter</title>




<style type="text/css">

.break
{
	page-break-after: always;
}
p{
  text-align: justify;
  text-justify: inter-word;
}
 
@page {    
          
          	size: 790px 1120px;
              margin-top: .4in;
              margin-left: .5in;
              margin-right: .5in;
              margin-buttom: .4in;
              border: 1px solid black;
                       
         
 }
 
 </style>
 <body>

<%}%>





<%
List<Object[]> committeeallmemberslist = (List<Object[]>) request.getAttribute("committeeallmemberslist");
Object[] committeeedata = (Object[]) request.getAttribute("committeeedata");
Object[] projectdata = (Object[]) request.getAttribute("projectdata");
Object[] initiationdata = (Object[]) request.getAttribute("initiationdata");
Object[] labdetails = (Object[]) request.getAttribute("labdetails"); 
Object[] committeedescription = (Object[]) request.getAttribute("committeedescription");
Object[] committeemaindata = (Object[]) request.getAttribute("committeemaindata");
String projectid=committeemaindata[2].toString() ;
String divisionid=committeemaindata[3].toString() ;
String initiationid=committeemaindata[4].toString() ;
List<Object[]> constitutionapprovalflow=(List<Object[]>)request.getAttribute("constitutionapprovalflow");
String flag = (String)request.getAttribute("flag");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdf = fc.getRegularDateFormat();
SimpleDateFormat sdf1 = fc.getSqlDateFormat();
SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");

List<String>memtypes=Arrays.asList("CH","PS","CS");
List<Object[]>committeeallmemberslistwithoutMs=committeeallmemberslist.stream().filter(i->!memtypes.contains(i[8].toString())).collect(Collectors.toList());
List<Object[]>committeeallmemberslistwithMs=committeeallmemberslist.stream().filter(i->memtypes.contains(i[8].toString())).collect(Collectors.toList());
committeeallmemberslistwithoutMs=committeeallmemberslistwithoutMs.stream()
	.sorted(Comparator.comparingInt(e -> Integer.parseInt(e[11].toString()))).collect(Collectors.toList());
List<Object[]>tempList=new ArrayList<>();
tempList.addAll(committeeallmemberslistwithoutMs);
tempList.addAll(committeeallmemberslistwithMs);
%>


 <div style="text-align: center;" align="center">
 	<div style="text-align: center;" ><h3 style="margin-bottom: 2px;" align="center"><%=labdetails[2]+"("+labdetails[1]+")" %> </h3></div>  
 	
	<div style="text-align: center;" ><h3 style="margin-bottom: 2px;" align="center"> Sub :   <u>Formulation of Committee for creating <%=committeeedata[1]%> <%if(Long.parseLong(projectid)>0) {%> for Project:<%=projectdata[4] %>    <%}else if(Long.parseLong(initiationid)>0){ %>Initiated Project: <%=initiationdata[1]%><%} %></u> </h3></div>
	<br>
	<div  align="center">
	<table style=" margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse:collapse;" >
		<tr>
			<td>
				<div style="text-align: center;" ><h3 style="margin-bottom: 2px; max-width: 650px;" align="center">Committee constitution </h3></div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="text-align: center;" >
					<p style="margin-bottom: 2px; max-width: 650px;text-align: justify;text-justify: inter-word;text-align: justify;text-justify: inter-word;" align="center">
						<%if(Long.parseLong(projectid)>0 || Long.parseLong(divisionid)>0 || Long.parseLong(initiationid)>0){ %>
								<%if(committeedescription[1]!=null){ %><%=committeedescription[1] %> <%}else{ %>No Data <%} %>
						<%}else { %>
								<%if(committeeedata[10]!=null){ %><%=committeeedata[10] %> <%}else{ %>No Data <%} %>
						<%} %>
					</p>
				</div>
			</td>
		</tr>
	</table>
	<br><br>
	<!-- -------------------------------------------members-------------------------------- -->
	<table style=" margin-top: 10px; margin-bottom: 10px; margin-left: 15px; width: 650px; font-size: 16px; border-collapse:collapse; " >
	<thead>
	<tr >
	<td style="text-align: left">Reference No. : <%if(committeemaindata[11]!=null) {%> <%=committeemaindata[11].toString()%><%}else{ %> -<%} %> </td>
	<td style="text-align: right">Date: <%if(committeemaindata[12]!=null){ %>  <%=sdf.format(sdf1.parse(committeemaindata[12].toString()))%><%} %></td>
	</tr>
	</thead>
	</table>
	<table style=" margin-top: 10px; margin-bottom: 10px; margin-left: 15px; width: 650px; font-size: 16px; border-collapse:collapse; " >
		<tr >
			<td colspan="5" style="text-align: center;padding-bottom:15px; ">Director,<%=labdetails[1].toString() %> has constituted the  following committee </td>
		</tr>
		
		<% int i=0;
			for(Object[] member : tempList){
				i++; %>
			<tr>				
				<td  style="max-width:40px;text-align: center; padding: 5px 0px 5px 0px "><%=i %> .&nbsp;</td>
				<td style="max-width: 35px;text-align: center;padding: 5px 0px 5px 0px "> &nbsp; </td>
				<td style="max-width: 300px;text-align: left; padding: 5px 0px 5px 0px">&nbsp;<%=member[2] %> (<%=member[4] %>) <%if(member[8].toString().equals("CW")){ %>(<%=member[9]%>)<%}  %>&nbsp;</td>
				<td style="max-width: 20px;text-align: center;padding: 5px 0px 5px 0px">&nbsp;: &nbsp;</td>
				<td style="max-width: 200px;text-align: left; padding: 5px 0px 5px 0px">&nbsp; 
				<%if(member[8].toString().equals("CC")){ %>Chairperson<%}
				else if(member[8].toString().equals("CH")){ %>Co-Chairperson<%} 
		 		else if(member[8].toString().equals("CS")){ %>Member Secretary<%} 
		 		else if(member[8].toString().equals("PS")){ %>Member Secretary (Proxy)<%} 
		 		else if(member[8].toString().equals("CI")){ %>Internal Member<%} 
		 		else if(member[8].toString().equals("CW")){ %>External Member<%} 
		 		else if(member[8].toString().equals("CO")){ %>Expert Member<%}%>			
				 &nbsp;</td>
				
			</tr>		
		<%} %>	
	</table>
	<!-- -------------------------------------------members-------------------------------- -->
		<table style=" margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse:collapse;" >
		<tr>
			<td>				
				<div style="text-align: center;" ><h3 style="margin-bottom: 2px; width: 650px;" align="center">Terms of Reference </h3></div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="text-align: center;" >
					<p style="margin-bottom: 2px; max-width: 650px;text-align: justify;text-justify: inter-word;text-align: justify;text-justify: inter-word;" align="center">
						
					<%if(Long.parseLong(projectid)>0 || Long.parseLong(divisionid)>0 || Long.parseLong(initiationid)>0){ %>
						<%if(committeedescription[2]!=null){ %><%=committeedescription[2] %> <%}else{ %>No Data <%} %>
														
					<%}else if(projectid!=null && Long.parseLong(projectid)==0){ %>
								<%if(committeeedata[11]!=null){ %><%=committeeedata[11] %> <%}else{ %> No Data <%} %>
					<%} %>
					
					</p>
				</div>
			</td>
		</tr>
	</table>
	</div>
</div>
					 	<div class="row mt-3"  style="text-align: center; padding-top: 10px;" >
				                <table  align="center" <%if(flag!=null && flag.equalsIgnoreCase("Y")) {%>  style="float:right" <%}else{ %> style="margin-left:55%;"<%} %>>
				                	<tr>
				                		<td class="trup" style="">
				                			Constituted By
				                		</td>
				                	
				                			                		
				                	</tr>			   
				                	
				                	<tr>
				                		<td class="trdown" style=" " >	
				                			<%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     
								                     		<%=obj[0] %>,<%=obj[1] %>
								                     	
								                     <%} %>
								               <%} %>
				                		</td>
				                	</tr>             	
				                </table>			             
						 	</div>
	<div class="row " style="text-align: left; padding-top: 10px;margin-top:10px;">
	<div style="margin-top:30px;margin-left:10px;">Recommended Officer :- </div>
	<div style="margin-top:10px;margin-left:10px;">Approving Officer :-</div>
	</div>
	<%
	if (!email.equals("Y")) {
	%>

</body>
</html>

<%}%>