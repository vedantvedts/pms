<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
<%

List<Object[]> committeeallmemberslist = (List<Object[]>) request.getAttribute("committeeallmemberslist");

Object[] committeeedata = (Object[]) request.getAttribute("committeeedata");
Object[] lastmeeting = (Object[]) request.getAttribute("lastmeeting");

String committeeShortName = committeeedata != null && committeeedata[1] != null ? committeeedata[1].toString() : "";
FormatConverter fc = new FormatConverter();

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

%>
<title>Attendance Sheet</title>
<style type="text/css">
table {
    font-size: 18px;
}

table th,
table td {
    font-size: 18px;
}
.break
{
	page-break-after: always;
}
p{
  text-align: justify;
  text-justify: inter-word;
}
 
 .header-details{
 	display: flex;
 	justify-content: space-between;
 	align-items: center;
 }
 
@page {    
	size: 790px 1120px;
    margin-top: .4in;
    margin-left: .5in;
    margin-right: .5in;
    margin-buttom: .4in;
    /* border: 1px solid black; */
 }
 .text-black{
 font-weight: bold;
 }
 
 li{
 text-align: left;
 }
 </style>
 <body>

 <div style="text-align: center;" align="center">

 	
	<div style="text-align: center;" ><h3 style="margin-bottom: 2px;text-decoration: none;" align="center"><%=committeeShortName %> Meeting Attendance Date: <%= lastmeeting != null && lastmeeting[2] !=null ? fc.sdfTordf(lastmeeting[2].toString()) : "" %> </h3></div>
	<br/>
	<div  align="center">
	<table style=" margin-bottom: 10px; margin-left: 15px; width: 650px; font-size: 13px; border-collapse:collapse;border:1px solid black; " >
		<tr >
			<%-- <td colspan="5" style="text-align: center;padding-bottom:15px; ">Director,<%=labdetails[1].toString() %> has constituted the  following committee </td> --%>
		</tr>
			<tr>
				<td class="text-black"  style="max-width:40px;text-align: center; padding: 5px ; border:1px solid black;">SN.&nbsp;</td>
				<td class="text-black"  style="max-width: 300px;text-align: center; padding: 5px ;border:1px solid black;">&nbsp;Name</td>
				<td class="text-black"  style="max-width: 150px;text-align: center; padding: 5px ; border:1px solid black;">Sign </td>
			</tr>
		<% int i=0;
			for(Object[] member : tempList){
				i++; %>
			<tr>				
				<td style="max-width:40px;text-align: center; padding: 5px ; border:1px solid black;"><%=i %>.&nbsp;</td>
				<td style="max-width:300px;text-align: left; padding: 5px ;border:1px solid black;">&nbsp;<%=member[2] %><%=member[4].toString().trim().length()>0?", "+member[4].toString():"" %> <%-- <%if(member[8].toString().equals("CW")){ %><%=member[9]%><%}  %> --%>&nbsp;</td>
				<td  style="max-width:150px;text-align: center; padding: 5px ; border:1px solid black;"></td>
				<%-- <td  style="max-width:150px;text-align: center; padding: 5px 0px 5px 0px; border:1px solid black;"><%=member[12].toString()%> </td> 
				<td style="max-width: 200px;text-align: left; padding: 5px 0px 5px 0px;border:1px solid black;">&nbsp; 
				<%if(member[8].toString().equals("CC")){ %>Chairperson<%}
				else if(member[8].toString().equals("CH")){ %>Co-Chairperson<%} 
		 		else if(member[8].toString().equals("CS")){ %>Member Secretary<%} 
		 		else if(member[8].toString().equals("PS")){ %>Member Secretary (Proxy)<%} 
		 		else if(member[8].toString().equals("CI")){ %>Internal Member<%} 
		 		else if(member[8].toString().equals("CW") && committeeedata[1].toString().equalsIgnoreCase("SPRT")&& !member[12].toString().equalsIgnoreCase("DG-ECS")){ %>Nodal Lab<%} 
		 		else if(member[8].toString().equals("CW")){ %>External Member<%} 
		 		else if(member[8].toString().equals("CO")){ %>Expert Member<%}	
		 		else if(member[8].toString().equals("CIP")){ %>Industry Partner<%}%>	
				 &nbsp;</td> --%>
				
			</tr>		
		<%} %>	
	</table>
	</div>
</div>

</body>
</html>