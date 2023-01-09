<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT INT  LIST</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}



 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}




/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}
.modal-xl{
	max-width: 1400px;
}
</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectMainList=(List<Object[]>) request.getAttribute("ProjectMainList");
String Onboarding = (String)request.getAttribute("Onboarding");
DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
    
    
                    <%} %>


	
<br>	
	
<div class="container-fluid">		
<div class="col-md-12">

 <div class="card shadow-nohover" >
<div class="card-header">
<div class="row">
	<div class="col-md-3"><h4><b>Project Main List</b></h4></div>
	
	<div class="col-md-9" align="right">
	 <%if(Onboarding!=null && "Yes".equalsIgnoreCase(Onboarding)){%>
				   <form action="ProjectMasterExcelUpload.htm" method="post" enctype="multipart/form-data">
					  		<table>
						  		<tr>
								  	<td align="left"><h6>Download Excel : &nbsp;<button formaction="ProjectMasterExcelUpload.htm" formmethod="post" formnovalidate="formnovalidate" name="Action" value="GenerateExcel"><i class="fa fa-file-excel-o" aria-hidden="true" style="color: green;"></i></button></h6></td>
									<td align="right"><h6>&nbsp;&nbsp;&nbsp;&nbsp;	Upload Excel :&nbsp;&nbsp;&nbsp;&nbsp;
									  <input type="file" id="excel_file" name="filename" required="required"  accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"></h6></td>						
							  		
							    </tr>
					  		</table>	
					     <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
					<div class="modal fade" id="exampleModalLong"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true" >
					  <div class="modal-dialog modal-xl" role="document">
					    <div class="modal-content"  >
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLongTitle">Project Master Details</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body"  style="max-height: 25rem; overflow-y:auto;">
					             <table class="table table-bordered table-hover table-striped table-condensed" id="myTable1"> </table>
					      </div>
					      <div class="modal-footer" align="center">
					       	    <div align="center">
					        			<button type="submit" onclick="return confirm('Are you sure to submit?')"  class="btn btn-sm add" name="Action" value="UploadExcel"> Upload</button>
					      		</div>
					       </div>
					    </div>
					  </div>
					</div>
					</form> 
			<%}%>
					</div>
					</div>
  </div>
<div class="card-body"> 
    <form action="ProjectMainSubmit.htm" method="POST" name="frm1" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed " id="myTable"> 
	   <thead>
	   <tr>
	   <th style="width: 5%;">Select</th>
			<th>SN</th>
			<th class="text-nowrap">Project Type</th>
			<th class="text-nowrap">Project Code</th>
			<th width="25%" class="text-nowrap">Project Name</th>
			<th style="width:10%" class="text-nowrap">Sanc Date</th>
			<th style="width: 124.892px;"  >Sanc Cost(&#8377; Lakh)</th>
			<th style="width:10%">PDC</th>
			<th>RevNo</th>
	  </tr>
	   </thead> 
    <tbody>
    
    
	 <%int count=1;
	 for(Object[] obj:ProjectMainList){ %>
<tr>
<td align="center"><input type="radio" name="ProjectMainId" value="<%=obj[0] %>" ></td>
<td><%=count %></td>
<td><%=obj[2] %></td>
<td align="center"><%=obj[3] %></td>
<td ><%=obj[4]%></td>
<%-- <td ><%=projectDescription %></td> --%>
<%-- <td ><%=unitCode %></td> --%>

<%

 %>
<td><%=sdf.format(obj[8]) %></td>
<%DecimalFormat df1 = new DecimalFormat( "################.00"); 
String v = df1.format((Double.valueOf(obj[9].toString()).doubleValue()/100000 )); 
NFormatConvertion nfc1=new NFormatConvertion();
%>
<td ><%=v%></td>
<%

 %>

<td class="text-nowrap"><%=sdf.format(obj[10]) %></td>

<td ><%=obj[11]%></td>
</tr>

<%count++;} %>
</tbody>
</table>
<table align="center">
<tr>
<td> <button name="action" class="btn btn-success btn-sm add" type="submit" value="add" >ADD</button>&nbsp;&nbsp;</td>
<td> <button name="action" class="btn btn-warning btn-sm edit" type="submit" value="edit" Onclick="Edit(frm1)">EDIT</button>&nbsp;&nbsp;</td>
<td>  <%if(Onboarding!=null && "Yes".equalsIgnoreCase(Onboarding)){%>
				<a class="btn btn-info btn-sm  back"   href="OnBoarding.htm">Back</a>
				<%}else{%>
				<a class="btn btn-info btn-sm  back"   href="MainDashBoard.htm">Back</a>
	 <%}%>&nbsp;&nbsp;
</td>
<!-- <td><button name="action" class="btn btn-warning" type="submit" value="revise" Onclick="Edit(frm1)">Revision</button>&nbsp;&nbsp;</td>
<td><button name="action" class="btn btn-danger" type="submit" value="close" Onclick="Delete(frm1)">Close</button>&nbsp;&nbsp;</td>
<td><button class="btn btn-primary" type="submit" formaction="UploadAttachmentSanction?act=view" Onclick="Edit(frm1)">Attach</button>&nbsp;&nbsp;</td>
<td><button name="action" class="btn btn-info" type="submit" value="revisionDetails" Onclick="Edit(frm1)">View</button>&nbsp;&nbsp;</td></tr> -->

</table>
 	
</div>
</div>
</div>





 	 						
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 	</form>
</div>


</div>
</div>
	
</div>	
	
	
	
	
<script type="text/javascript">

function Edit(myfrm){
	
	 var fields = $("input[name='ProjectMainId']").serializeArray();

	  if (fields.length === 0){
		  bootbox.alert("Please Select One Project Main Record");
	      event.preventDefault();
	      return false;
	}
		  return true;
}

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	 var fields = $("input[name='btSelectItem']").serializeArray();
	  if (fields.length === 0){
		  	myalert();
	 		event.preventDefault();
			return false;
		}
		  return true;	
}

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});
  
$(document).ready(function(){
	  $("#myTable1").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});
</script>
 <script type="text/javascript">
const excel_file = document.getElementById('excel_file');

excel_file.addEventListener('change', (event) => {
    var reader = new FileReader();

    reader.readAsArrayBuffer(event.target.files[0]);

    reader.onload = function(event){

        var data = new Uint8Array(reader.result);

        var work_book = XLSX.read(data, {type:'array'});

        var sheet_name = work_book.SheetNames;

        var sheet_data = XLSX.utils.sheet_to_json(work_book.Sheets[sheet_name[0]], {header:1});  
    	
    
        if(sheet_data.length > 0)
        {          
        	
            
        var table_output ='<thead> <tr > <th>SNo</th> <th>LabCode</th> <th>Code</th> <th>Name</th><th>proj No</th> <th>Unit Code</th> <th>Sanc Letter No</th> <th>Total Sanc Cost</th> <th>Sanc Cost FE</th> <th>Sanc Cost RE</th> <th>Nodal & Participating Lab</th> <th >Scope</th> <th >Objective</th> <th>Deliverable</th></tr> </thead><tbody>'
        	
            for(var row = 0; row < sheet_data.length; row++)
            {            	
            	  table_output += ' <tr> ';
             	
            	  if(row>0){table_output += '<td>'+ row +'</td>';}
                for(var cell = 0; cell < 13; cell++)
                {
                	if(row>0 && cell==0){
                		table_output += '<td>'+'<%=session.getAttribute("labcode")%>'+'</td>';
                	}
                	if(row>0 && cell>0){
                		table_output += '<td>'+sheet_data[row][cell]+'</td>';
                	}
	
                }
               
               /*  if(row>0){table_output += '<td>'+ 0 +'</td>';}
                if(row>0){table_output += '<td>'+ 0 +'</td>';} */
                table_output += '</tr>';
             }
            table_output += ' <tbody>';
            document.getElementById('myTable1').innerHTML = table_output;
             
             var EmployeeNojsArray = [<%int i=0; for (Object[] obj:ProjectMainList) { %>"<%= obj[3] %>"<%= i + 1 < ProjectMainList.size() ? ",":"" %><% } %>];
                    
             var employeeNo=[];
             for (var i in sheet_data) {
          	  employeeNo.push(sheet_data[i][1]+'')
          	}
            
             const duplicates = employeeNo.filter((item, index) => index !== employeeNo.indexOf(item));  
           
             const indexval = []             
             for(var i in duplicates){
            	 indexval.push(employeeNo.indexOf(duplicates[i]))
             }
             
             var dbDuplicate = [];                      
             EmployeeNojsArray.forEach(function(item){
            	  var isPresent = employeeNo.indexOf(item);
            	  if(isPresent !== -1){
            		  dbDuplicate.push(isPresent); 
            	  }
            	})
            	
            	if(indexval.length>0){
            		 alert("Duplicate Employee Number Existed in Excel file at Serial No :"+ indexval);
   			      excel_file.value = '';
            	}else if(dbDuplicate.length>0){
            		 alert("Employee Number alredy Existed at serial No :"+ dbDuplicate);
   			      excel_file.value = '';
            	}else{
                	 $('#exampleModalLong').modal('show');
               }

            }else{
            	alert("Please Select the Excel File!");
            	return false;
            }
        }
        
});

$('#exampleModalLong').on('hide.bs.modal', function(){
	 excel_file.value = '';
})
</script> 
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>