<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String email=(String)request.getAttribute("email");  
List<Object[]> committeeallmemberslist = (List<Object[]>) request.getAttribute("committeeallmemberslist");
List<Object[]> constitutionapprovalflowData = (List<Object[]>) request.getAttribute("constitutionapprovalflowData");

String RecommendedBy ="";

if(constitutionapprovalflowData!=null && constitutionapprovalflowData.size()>0){
	for(Object[]obj:constitutionapprovalflowData){
		if(obj[2].toString().equalsIgnoreCase("RDO")){
			RecommendedBy = obj[0].toString()+", "+obj[1].toString();
		}
	}
}

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


String projectCode="";
if(!projectid.equalsIgnoreCase("0")){
	projectCode = projectdata[4].toString();
}

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdf = fc.getRegularDateFormat();
SimpleDateFormat sdf1 = fc.getSqlDateFormat();
SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
Object[]CommitteMainEnoteList = (Object[])request.getAttribute("CommitteMainEnoteList");
List<String>memtypes=Arrays.asList("PS","CS");
List<Object[]>committeeallmemberslistwithCC=committeeallmemberslist.stream().filter(i->i[8].toString().equalsIgnoreCase("CC")).collect(Collectors.toList());
List<Object[]>committeeallmemberslistwithoutMs=committeeallmemberslist.stream().filter(i->!memtypes.contains(i[8].toString()) && !i[8].toString().equalsIgnoreCase("CC")).collect(Collectors.toList());
List<Object[]>committeeallmemberslistwithMs=committeeallmemberslist.stream().filter(i->memtypes.contains(i[8].toString())).collect(Collectors.toList());
committeeallmemberslistwithoutMs=committeeallmemberslistwithoutMs.stream()
	.sorted(Comparator.comparingInt(e -> Integer.parseInt(e[11].toString()))).collect(Collectors.toList());
List<Object[]>tempList=new ArrayList<>();
tempList.addAll(committeeallmemberslistwithCC);
tempList.addAll(committeeallmemberslistwithoutMs);
tempList.addAll(committeeallmemberslistwithMs);
if(!email.equals("Y")){ %>
<!DOCTYPE html>
<html>
<head>
<title>Committee Formation Letter</title>
<spring:url value="/resources/css/committeeModule/CommitteeConstitutionLetter.css" var="CommitteeConstitutionLetter" />
<link href="${CommitteeConstitutionLetter}" rel="stylesheet" />
<style type="text/css">
@page {    
          
          	size: 790px 1120px;
              margin-top: .4in;
              margin-left: .5in;
              margin-right: .5in;
              margin-buttom: .4in;
              /* border: 1px solid black; */
         <%if(constitutionapprovalflowData!=null && constitutionapprovalflowData.size()>0){%>
           @bottom-left { 
             font-size: 13px;
	          margin-bottom: 30px;
<%-- 	          content: "Initiated By : <%= constitutionapprovalflow.get(0)[0]%>,  <%= constitutionapprovalflow.get(0)[1]%>"; 
 --%>          	} 
          <%}%>
          
          <%if(RecommendedBy.length()>1){%>
           @bottom-right { 
             font-size: 13px;
	          margin-bottom: 30px;
	           margin-right: 20px;
	       <%--    content: "Recommended By :- <%=RecommendedBy%>";  --%>
          }               
          <%}%>
         
 }
</style>
<body>
<%}%>
 <div class="text-center" align="center">
 <div  >
 <span class="refNoStyle">Ref No. - <%if(committeemaindata[11]!=null) {%><%= projectCode.length()>1?projectCode+"/ ":"" %><%=committeemaindata[11].toString()%><%}else{ %> -<%} %> </span>
 <span class="dateStyle">Date :  <%if(committeemaindata[12]!=null){ %>  <%=sdf.format(sdf1.parse(committeemaindata[12].toString()))%><%} %></span>
 </div>  
<br>
 	<div class="text-center"><h3 class="mb-2px" align="center"><%=labdetails[2]!=null?labdetails[2].toString(): " - "%> (<%=labdetails[1]!=null?labdetails[1].toString(): " - " %>) </h3></div>  
 	
	<div class="text-center"><h3 class="mb-2px" align="center">Formation of Committee  <%=committeeedata[2]!=null?committeeedata[2].toString(): " - "%> (<%=committeeedata[1]!=null?committeeedata[1].toString(): " - "%>) </h3></div>
	<br>
	<div  align="center">
	<table class="tblStyle">
		<tr>
			<td>			
			</td>
		</tr>
		<tr>
			<td>
				<div class="text-center">
					<div class="divDataStyle" align="center">
						<%if(Long.parseLong(projectid)>0 || Long.parseLong(divisionid)>0 || Long.parseLong(initiationid)>0){ %>
								<%if(committeedescription[1]!=null){ %><%=committeeedata[1].toString() %> <%}else{ %>No Data <%} %>
						<%}else { %>
								<%if(committeeedata[10]!=null){ %><%=committeeedata[10].toString()%> <%}else{ %>No Data <%} %>
						<%} %>
					</div>
				</div>
			</td>
		</tr>
	</table>
	
	<!-- -------------------------------------------members-------------------------------- -->

	<table class="membersTblStyle">
		<tr >
		</tr>
					<tr>				
				<td class="text-black tdHeaderSnStyle">SN .&nbsp;</td>
				<td class="text-black tdHeaderNameStyle">&nbsp;Name, Designation</td>
				<td class="text-black tdHeaderAgencyStyle">Estt. / Agency </td>
				<td class="text-black tdHeaderRoleStyle">&nbsp; Role
				</td>
				</tr>
		<% int i=0;
			for(Object[] member : tempList){
				i++; %>
			<tr>				
				<td class="tdHeaderSnStyle"><%=i %> .&nbsp;</td>
				<td class="tdHeaderNameStyle">&nbsp;<%=member[2]!=null?member[2].toString(): " - " %><%=member[4]!=null &&  member[4].toString().length()>1?", "+member[2].toString():"" %> <%-- <%if(member[8].toString().equals("CW")){ %><%=member[9]%><%}  %> --%>&nbsp;</td>
				<td class="tdHeaderAgencyStyle"><%=member[12].toString()%> </td>
				<td class="tdHeaderRoleStyle">&nbsp; 
				<%if(member[8].toString().equals("CC")){ %>Chairperson<%}
				else if(member[8].toString().equals("CH")){ %>Co-Chairperson<%} 
		 		else if(member[8].toString().equals("CS")){ %>Member Secretary<%} 
		 		else if(member[8].toString().equals("PS")){ %>Member Secretary (Proxy)<%} 
		 		else if(member[8].toString().equals("CI")){ %>Internal Member<%} 
		 		else if(member[8].toString().equals("CW") && committeeedata[1].toString().equalsIgnoreCase("SPRT")&& !member[12].toString().equalsIgnoreCase("DG-ECS")){ %>Nodal Lab<%} 
		 		else if(member[8].toString().equals("CW")){ %>External Member<%} 
		 		else if(member[8].toString().equals("CO")){ %>Expert Member<%}	
		 		else if(member[8].toString().equals("CIP")){ %>Industry Partner<%}%>	
				 &nbsp;</td>
				
			</tr>		
		<%} %>	
	</table>
	<!-- -------------------------------------------members-------------------------------- -->
		<table class="teamReferenceTblStyle">
		<tr>
			<td >				
				<h3 class="h3TeamReferenceStyle">Terms of Reference </h3>
			</td>
		</tr>
		<tr>
			<td>
				<div class="text-center">
					<p class="pTagStyle" align="center">
						
					<%if(Long.parseLong(projectid)>0 || Long.parseLong(divisionid)>0 || Long.parseLong(initiationid)>0){ %>
						<%if(committeedescription[2]!=null){ %><%=committeedescription[2].toString()%> <%}else{ %>No Data <%} %>
														
					<%}else if(projectid!=null && Long.parseLong(projectid)==0){ %>
								<%if(committeeedata[11]!=null){ %><%=committeeedata[11].toString()%> <%}else{ %> No Data <%} %>
					<%} %>
					
					</p>
				</div>
			</td>
		</tr>
	</table>
	</div>
</div>

	<div class="row text-left">
	<br>
	<div align="center" class="text-center">
	<%if(committeemaindata[9].toString().equalsIgnoreCase("A")){ %>
	 <%if(CommitteMainEnoteList!=null && !CommitteMainEnoteList[22].toString().equalsIgnoreCase((String)session.getAttribute("labcode"))){ %>
	 Committee Recommended by Director, <%=(String)session.getAttribute("labcode") %> for competent Approval Authority.
	 <%}else{ %>
	 Approved
	 <br>
	<br>
	<div align="center" class="text-center">
		<%if(committeemaindata[9].toString().equalsIgnoreCase("A")){ %>Director<%} %>
	</div>
	 <%} %>
	<%}else{ %>
	Approved /  Not Approved
	<br>
	<br>
	<%=CommitteMainEnoteList!=null && CommitteMainEnoteList[14]!=null?CommitteMainEnoteList[14].toString():"" %>
	<%} %>
	</div>
	<br><br>
	<div class="text-left fs-13px">
	Initiated By : <%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[18]!=null ){ %> <%=CommitteMainEnoteList[18].toString() %>, <%=CommitteMainEnoteList[19]!=null?CommitteMainEnoteList[19].toString(): " - " %>  <%}else{ %>  <%= constitutionapprovalflow.get(0)[0]!=null?constitutionapprovalflow.get(0)[0].toString(): " - "%>,  <%= constitutionapprovalflow.get(0)[1]!=null?constitutionapprovalflow.get(0)[1].toString(): " - "%> <%} %>
	</div>
	</div>
	<%
	if (!email.equals("Y")) {
	%>
</body>
</html>

<%}%>