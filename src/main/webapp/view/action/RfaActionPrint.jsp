<%@page import="com.vts.pfms.utils.PMSLogoUtil"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RFA Print</title>

<style type="text/css">

#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
 @page {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 3px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
              font-size: 13px;
          }
      }

.border-black{
border: 1px solid black;
border-collapse: collapse;
}
.break
	{
		page-break-after: always;
	} 

.spanDate{
color: #007bff;
font-size: 12px;
}
 .std
 {
 	
 	border: 1px solid black;
 	padding: 3px 2px 2px 2px; 
 	
 }
 p{
 padding:5px;
 text-align: justify;
  }
</style>

</head>
<body>

<% 

Object[] LabList=(Object[])request.getAttribute("LabDetails");
String lablogo=(String)request.getAttribute("lablogo");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] RfaPrint=(Object[]) request.getAttribute("RfaPrint");
List<Object[]> AssigneeList=(List<Object[]>) request.getAttribute("AssigneeEmplList");
List<Object[]>  CCTdeEmplList=(List<Object[]>) request.getAttribute("CCTdeEmplList");

PMSLogoUtil pLU=new PMSLogoUtil();
String raisedBy2=null;
String risedDateFormatted=null;
if(RfaPrint[16]!=null){
String[] raisedBy =RfaPrint[16].toString().split(",");
 raisedBy2=raisedBy[0]+", "+raisedBy[1];
risedDateFormatted=pLU.formatD(raisedBy[2]);
}
String checkedBy2=null;
String checkedDateFormatted=null;
if(RfaPrint[17]!=null){
String[] checkedBy =RfaPrint[17].toString().split(",");
 checkedBy2=checkedBy[0]+", "+checkedBy[1];
 checkedDateFormatted=pLU.formatD(checkedBy[2]);
}
String approvedBy2=null;
String approvedDateFormatted=null;
if(RfaPrint[18]!=null){
String[] approvedBy =RfaPrint[18].toString().split(",");
approvedBy2=approvedBy[0]+", "+approvedBy[1];
approvedDateFormatted=pLU.formatD(approvedBy[2]);
}

String preparedBy2=null;
String preparedByDateFormatted=null;
if(RfaPrint[19]!=null){
String[] preparedBy =RfaPrint[19].toString().split(",");
preparedBy2 = preparedBy[0]+", "+preparedBy[1];
preparedByDateFormatted=pLU.formatD(preparedBy[2]);
}
String receivedBy2=null;
String receivedBy2ByDateFormatted=null;
if(RfaPrint[20]!=null){
String[] receivedBy =RfaPrint[20].toString().split(",");
receivedBy2 = receivedBy[0]+", "+receivedBy[1];
receivedBy2ByDateFormatted=pLU.formatD(receivedBy[2]);
}

String approvedBy=null;
String approvedByByDateFormatted=null;
if(RfaPrint[21]!=null){
String[] approvedBy3 =RfaPrint[21].toString().split(",");
approvedBy = approvedBy3[0]+", "+approvedBy3[1];
approvedByByDateFormatted=pLU.formatD(approvedBy3[2]);
}
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> ProjectTypeList=(List<Object[]>)request.getAttribute("ProjectTypeList");
List<Object[]> PriorityList=(List<Object[]>)request.getAttribute("PriorityList");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");

List<String> checkedByStatus  = Arrays.asList("AC","AV","AE","RC","RFA","RE","RP","RR","AR","AP","ARC","AY","AX","RV");
List<String> approvedByStatus  = Arrays.asList("AV","AE","RV","RFA","RE","RP","RR","AR","AP","ARC","AY","AX","AAA");
List<String> receiverIdStatus  = Arrays.asList("AR","AP","ARC");
List<String> approvedIdStatus  = Arrays.asList("AP","ARC");
%>

    <div id="container pageborder" align="center"  class="firstpage" id="firstpage"  >
        <table class="border-black" style="margin-top: 5px; margin-left: 3px; width: 700px">
           <tr>
		     <th colspan="10" style="font-size: 33px; height: 80px">Request For Action (RFA)</th>
	      </tr>
              
              <tr>
                 <td colspan="2" style="text-align: center;border: 1px solid black; width: 20px;width: 83px"><img style="height: 2.5cm" src="data:image/png;base64,<%=lablogo%>"></td>
                 <td colspan="8" style="text-align: center;font-weight: 700; border: 1px solid black; width: 83px" name="labcode"><%=LabList[2] %> <br> <%=LabList[3] %> <br> <%=LabList[4] %> - <%=LabList[5]%> </td>
              </tr>
              <tr>
                <td colspan="6" style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px"> &nbsp;&nbsp;RFA No : <span style="font-weight: normal;"><%=RfaPrint[3].toString() %> </span></td>
                <td colspan="4"style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px"> &nbsp;&nbsp;RFA Date : <span style="font-weight: normal;"><%=new FormatConverter().SqlToRegularDate(  RfaPrint[4].toString() )%></span></td>
              </tr>
              <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;Project : <span style="font-weight: normal;"><%=RfaPrint[2].toString()%> </span></td>
                <td colspan="4"style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;Classification : <span style="font-weight: normal;"><%=RfaPrint[6].toString() %> </span></td>
                <%for(Object[] obj : PriorityList){
                  if(obj[0].toString().equalsIgnoreCase(RfaPrint[5].toString())){%>
                <td colspan="4"style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;Priority : <span style="font-weight: normal;"><%=obj[1].toString() %> </span></td>
                <%}} %>
              </tr>
              <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 30px ">&nbsp;&nbsp;Problem Statement  </td>
                 <td colspan="8" style="border: 1px solid black; text-align: justify; font-weight: 700;  width: 80px; "><span  style="font-weight: normal; padding:  3px 2px 2px 2px ;">&nbsp;&nbsp;<%=RfaPrint[7].toString() %></span></td>
              </tr> 
              <tr>
                <td colspan="2" style="border: 1px solid black;  font-weight: 700; text-align: left; height: 30px">&nbsp;&nbsp;Problem Description </td>
                 <td colspan="8" style="border: 1px solid black;  font-weight: 700;width: 80px; text-align: justify; "><span style="font-weight: normal;"><%=RfaPrint[8].toString() %></span></td>
              </tr> 
               <tr>
                 <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 30px">&nbsp;&nbsp;Reference </td>
                 <td colspan="8" style="border: 1px solid black; text-align: justify; font-weight: 700; "><span style="font-weight: normal; padding:  3px 2px 2px 2px;">&nbsp;&nbsp;<%=RfaPrint[9].toString() %></span></td>
              </tr> 
               <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 65px">&nbsp;&nbsp;Problem Resolution <br>&nbsp;&nbsp;Assigned To </td>
                <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700; height: 65px">
                <%for(Object[] obj1 : AssigneeList){
                	if(obj1[0].toString().equalsIgnoreCase(RfaPrint[0].toString())){%>
                   <div style="padding-bottom:0px !important;font-weight: normal;">&nbsp;&nbsp;<%=obj1[1].toString()+", "+obj1[2].toString() %> </div>
                <%} }%>  
                </td>        
              </tr> 
              
              <tr>
              <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 64px">&nbsp;&nbsp;CC</td>
              <td colspan="8" style="border: 1px solid black; text-align: left; ;height: 64px;">
              <%
              if(!CCTdeEmplList.isEmpty()){
              for (Object[] ccList: CCTdeEmplList) {
              String desig=" "+ccList[1].toString();
              %>
             <div >&nbsp;&nbsp;<%=ccList[0]%>,<%=desig%></div> 
              <%}}%>
              </td>
              </tr>
            
              <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Raised By </td>
                <%if(RfaPrint[16]!=null){ %>
                <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=raisedBy2%> <br> <span style="font-size: 13px;"> &nbsp; [forwarded on :</span> <span class="spanDate"><%=risedDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
                <%}else{ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;"></span></td>
                <%} %>
              </tr> 
              <tr>
             <%if(RfaPrint[17]!=null && Arrays.asList("AA","AF","AC","AV","AAA","AR","AP","ARC","RFA","AX","AY","AAA","AR","RR","AP","RP","REK").contains(RfaPrint[11]+"")){ %>
                 <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Checked By </td>
                 <%if(checkedByStatus.contains(RfaPrint[11].toString()) ){ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=checkedBy2%> <br> <span style="font-size: 13px;"> &nbsp; [checked on :</span> <span class="spanDate"><%=checkedDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
                 <%}else{ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px"><span style="font-weight: normal;"></span></td>
                  <%} %>
               <%}else{ %>
                   
                <%} %>
              </tr> 
              <tr>
				<%if(RfaPrint[17]!=null && Arrays.asList("AV","AAA","AR","AP","ARC","RFA","AX","AY","RR","RP","REK","ARC").contains(RfaPrint[11]+"")){ %>
                 <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 64px">&nbsp;&nbsp;Approved By </td>
                 <%if(approvedByStatus.contains(RfaPrint[11].toString())){ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700; height: 64px"><span style="font-weight: normal;">&nbsp;&nbsp;<%=approvedBy2%> <br> <span style="font-size: 13px;"> &nbsp; [approved on :</span> <span class="spanDate"><%=approvedDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
                 <%}else{ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 64px "><span style="font-weight: normal;"></span></td>
                 <%} %>
               <%}else{ %>
                 
                <%} %>
              </tr> 

            
        </table>  

    </div>
    
    <% 
    if(RfaPrint[13]!=null) {%>
    <h1 class="break"></h1> 
        <div id="container pageborder" align="center"  class="firstpage" id="firstpage"  >
        <table class="border-black" style="margin-top: 5px; margin-left: 3px; width: 700px">
           <tr>
		     <th colspan="10" style="font-size: 33px; height: 80px">Closure Report (RFA)</th>
	      </tr>
              
              <tr>
                 <td colspan="2" style="text-align: center;border: 1px solid black; width: 20px;width: 83px"><img style="height: 2.5cm" src="data:image/png;base64,<%=lablogo%>"></td>
                 <td colspan="8" style="text-align: center;font-weight: 700; border: 1px solid black; width: 83px" name="labcode"><%=LabList[2] %> <br> <%=LabList[3] %> <br> <%=LabList[4] %> - <%=LabList[5]%> </td>
              </tr>
              <tr>
                <td colspan="6" style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;RFA No : <span style="font-weight: normal;"><%=RfaPrint[3].toString() %> </span></td>
                <td colspan="4"style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;RFA Date : <span style="font-weight: normal;"><%=new FormatConverter().SqlToRegularDate(  RfaPrint[4].toString() )%></span></td>
              </tr>
              <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;Project : <span style="font-weight: normal;"><%=RfaPrint[2].toString()%> </span></td>
                <td colspan="4"style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;Classification : <span style="font-weight: normal;"><%=RfaPrint[6].toString() %> </span></td>
                <%for(Object[] obj : PriorityList){
                  if(obj[0].toString().equalsIgnoreCase(RfaPrint[5].toString())){%>
                <td colspan="4"style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;Priority : <span style="font-weight: normal;"><%=obj[1].toString() %> </span></td>
                <%}} %>
              </tr>
              <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700;  ">&nbsp;&nbsp;Visual Inspection and <br>&nbsp;&nbsp;Observation </td>
                 <td colspan="8" style="border: 1px solid black; text-align: justify; font-weight: 700; height: 30px; width: 80px; height: 100px"><span style="font-weight: normal; padding:  3px 2px 2px 2px;">&nbsp;&nbsp;<%=RfaPrint[13].toString() %></span></td>
              </tr> 
              <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700;height: 30px">&nbsp;&nbsp;Clarification</td>
                 <td colspan="8" style="border: 1px solid black; text-align: justify; font-weight: 700;width: 80px; "><span style="font-weight: normal; padding:  3px 2px 2px 2px;">&nbsp;&nbsp;<%=RfaPrint[14].toString() %></span></td>
              </tr> 
               <tr>
                 <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 30px">&nbsp;&nbsp;Action Required</td>
                 <td colspan="8" style="border: 1px solid black; text-align: justify; font-weight: 700;"><span style="font-weight: normal; padding:  3px 2px 2px 2px;">&nbsp;&nbsp;<%=RfaPrint[15].toString() %></span></td>
              </tr> 
               <tr>
    
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 50px">&nbsp;&nbsp;Date of Completion </td>
                <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700; "><span style="font-weight: normal;">&nbsp;&nbsp;<%=new FormatConverter().SqlToRegularDate( RfaPrint[12].toString())%></span></td>
                    
              </tr> 
              <tr>
                <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Prepared By </td>
                <%if(RfaPrint[19]!=null){ %>
                <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=preparedBy2%> <br> <span style="font-size: 13px;"> &nbsp; [prepared on :</span> <span class="spanDate"><%=preparedByDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
                <%}else{ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;"></span></td>
                <%} %>
              </tr> 
              <tr>
              <%if(RfaPrint[20]!=null && Arrays.asList("RFA","AR","ARC").contains(RfaPrint[11]+"")){ %>
                 <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Received By </td>
                 <%if(receiverIdStatus.contains(RfaPrint[11]) ){ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=receivedBy2%> <br> <span style="font-size: 13px;"> &nbsp; [received on :</span> <span class="spanDate"><%=receivedBy2ByDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
                 <%}else{ %>
                  <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px"><span style="font-weight: normal;"></span></td>
                 <%} %>
              <%}else{%>
                 
                <%}%>
              </tr> 
              <tr>
              <%if(RfaPrint[21]!=null && Arrays.asList("AY","AP","ARC").contains(RfaPrint[11]+"")){ %>
                 <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 64px">&nbsp;&nbsp;Approved By </td>
                 <%if(approvedIdStatus.contains(RfaPrint[11])){ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700; height: 64px"><span style="font-weight: normal;">&nbsp;&nbsp;<%=approvedBy%> <br> <span style="font-size: 13px;"> &nbsp; [approved on :</span> <span class="spanDate"><%=approvedByByDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
                 <%}else{ %>
                 <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 64px "><span style="font-weight: normal;"></span></td>
                 <%} %>
              <%}else{%>
                 
                <%}%>
              </tr> 
            
        </table>  

    </div>
    <%} %>
</body>
</html>