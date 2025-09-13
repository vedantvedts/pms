<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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

<spring:url value="/resources/css/master/officerMasterList.css" var="officerMasterList" />     
<link href="${officerMasterList}" rel="stylesheet" />

<title>OFFICER DETAILS</title>

</head>
<body>

<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String Onboarding = (String)request.getAttribute("Onboarding");
List<Object[]> OfficerList=(List<Object[]>) request.getAttribute("OfficerList");
List<Object[]> AllOfficerlist =(List<Object[]>)request.getAttribute("AllOfficerList");

%>


<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>


	

	
<div class="container-fluid">		
<div class="col-md-12">

 <div class="card shadow-nohover" >
  <div class="card-header">
  <div class="row">
	<div class="col-md-2"><h4><b>Officer List</b></h4></div>
	
	<div class="col-md-10" align="right">
	 <%if(Onboarding!=null && "Yes".equalsIgnoreCase(Onboarding)){%>
				  <form action="EmployeeMasterExcelUpload.htm" method="post" enctype="multipart/form-data">
					  		<table>
						  		<tr>
								  	<td align="left"><h6>Download Excel : &nbsp;<button formaction="EmployeeMasterExcelUpload.htm" formmethod="post" formnovalidate="formnovalidate" name="Action" value="GenerateExcel"><i class="fa fa-file-excel-o exelbtn" aria-hidden="true" ></i></button></h6></td>
									<td align="right"><h6>&nbsp;&nbsp;&nbsp;&nbsp;	Upload Excel :&nbsp;&nbsp;&nbsp;&nbsp;
									  <input type="file" id="excel_file" name="filename" required="required"  accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"></h6></td>						
							  		<td align="right"></td>
							    </tr>
					  		</table>	
					     <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
					<div class="modal fade modalOfiicer" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true" >
					  <div class="modal-dialog modal-lg" role="document">
					    <div class="modal-content modalContent" >
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLongTitle">Employee Master Details</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body bodydiv" align="center" >
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
    <form action="Officer.htm" method="POST" name="frm1">

 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead class="tableHeader" >
	   <tr>
		  <th>Select</th>
		  <th>SrNo</th>
		  <th>Employee No</th>
		  <th>Employee Name</th>
		  <th>Designation</th>
		  <th>Extension No</th>
		  <th>Lab Email</th>
		  <th>Division</th>
		  <th>Active Status</th>
	  </tr>
	   </thead>
        <tbody>
	       <%for(Object[] obj:OfficerList){ %>
	         <tr>
	             <td align="center"><input type="radio" name="Did" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):""%>  ></td> 
	             <td><%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()):"-"%></td> 
	             <td ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-" %></td>
	             <td class="tData"><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString())%><%}else{ %>-<%} %></td>
	             <td class="tData"> <%if(obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[3].toString()) %><%}else{ %>-<%} %></td>
	             <td class="tData"><%if(obj[4]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[4].toString()) %><%}else{ %>-<%} %></td>
	             <td><%if(obj[5]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[5].toString()) %><%}else{ %>-<%} %></td>
	   	         <td><%if(obj[6]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[6].toString()) %><%}else{ %>-<%} %></td>
	   			 <td><%if(Integer.parseInt(obj[10].toString())==1){%>Active<%}else{ %><span class="status">InActive</span><%} %></td>
	      </tr>
	    <%} %>
	    </tbody>
</table>
 	
</div>
<%if(OfficerList!=null && OfficerList.size()>0){ %>
	 <div align="center"> 
	 	<button type="submit" class="btn btn-primary btn-sm add" formaction="OfficerAdd.htm" value="add">ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<button type="submit" class="btn btn-danger btn-sm delete" name="sub" value="delete"  onclick="Delete(frm1)">INACTIVE</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<button type="submit" class="btn  btn-sm revoke" name="sub" value="updateSeniority"  onclick="Upadte(frm1)">UPDATE SENIORITY</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 <%if(Onboarding!=null && "Yes".equalsIgnoreCase(Onboarding)){%>
				<a class="btn btn-info btn-sm  back"   href="OnBoarding.htm">Back</a>
				<%}else{%>
				<a class="btn btn-info btn-sm  back"   href="MainDashBoard.htm">Back</a>
			<%}%>	
	</div> 
<%} %> 
 
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
</div>


</div>
</div>
	
</div>	
	
	
	

<script type="text/javascript">

var type=$("#empTYPE").val();
$("#empTypeForm").val(type);

function Edit(myfrm){

	 var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
		  return true;	
	}
function Delete(myfrm){
	

	var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();	
	return false;
	}
	  var cnf=confirm("Are You Sure To Make Officer Inactive !");
	  if(cnf){
	
	return true;
	
	}else{
		  event.preventDefault();
			return false;
			}
	
	}
	
	function Upadte(myfrm){
		var fields = $("input[name='Did']").serializeArray();

		  if (fields.length === 0){
		alert("Please Select A Record");
		 event.preventDefault();	
		return false;
		}

		
		
	}


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
         	
             
         var table_output ='<thead> <tr > <th>SNo</th> <th>LabCode</th> <th>Emp No</th> <th>Emp Name</th> <th>Ext No</th> <th>Mobile No</th> <th>Email</th> <th>Drona Email</th> <th>Internet Email</th> <th>Designation</th> <th>Division</th></tr> </thead><tbody>'
        	 var checkExcel=0;
         	 var Employeeno=[]; 
         	 var phoneno=[];
         	 var ExtNo=[];
         	 var EmpEmail=[];
         	 var empname1=[];
         	 var dronaEmail=[];
         	 var InternetEmail=[];
             for(var row = 0; row < sheet_data.length; row++)
             {            	
             	  table_output += ' <tr> ';
              	 
             	  if(row>0){table_output += '<td>'+ row +'</td>';}
                 for(var cell = 0; cell < 8; cell++)
                 {
                	 if(row==0){
         				
         				if(cell==1 && "Employee Number"!=sheet_data[row][cell]){ console.log("1"); checkExcel++;}
         				if(cell==2 && "Employee Name"!=sheet_data[row][cell]){ console.log("2"); checkExcel++;}
         				if(cell==3 && "Extention Number"!=sheet_data[row][cell]){ console.log("3"); checkExcel++;}
         				if(cell==4 && "Mobile Number"!=sheet_data[row][cell]){ console.log("4"+sheet_data[row][cell]); checkExcel++;}
         			}
                 	if(row>0 && cell==0){
                 		table_output += '<td>'+'<%=session.getAttribute("labcode")%>'+'</td>';
                 	}
                 	if(row>0 && cell==1){
                 		var empno = sheet_data[row][cell];
                 		if(!/^[a-zA-Z0-9]+$/.test(empno)){ Employeeno.push(row);}	
                 	}
                 	if(row>0 && cell==3){
                 		var Exno = ''+sheet_data[row][cell]+'';
                 		if(!/^\d+$/.test(Exno) || Exno.length < 4 || Exno.length > 10){ ExtNo.push(row);}	
                 	}
                 	if(row>0 && cell==4){
                 		var pno = ''+sheet_data[row][cell]+'';
                 		if(!/^\d+$/.test(pno) || pno.length!=10){ phoneno.push(row);}	
                 	}
                 	if(row>0 && cell==5){
                 		var email= ''+sheet_data[row][cell]+'';
                 		var EMAIL_REGEXP = new RegExp('^[a-z0-9]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,15})$', 'i');
                 		if(!EMAIL_REGEXP.test(email)){ EmpEmail.push(row); }
                 	}
                 	if(row>0 && cell==2){
                 		var name= ''+sheet_data[row][cell]+'';
                 		if(name.trim()=='' ||name.trim()=='undefined'){empname1.push(row); }
                 	}
                 	if(row>0 && cell>0 && cell!=6 && cell!=7){
                 		table_output += '<td>'+sheet_data[row][cell]+'</td>';
                 	}
                 	if(row>0 && cell>0 && (cell==6 ||cell==7)){
                 		var email= ''+sheet_data[row][cell]+'';
                 		console.log("email   :"+email);
                 		if(email=='' || email=='undefined'){
                 			table_output += '<td> - </td>';
                 		}else{
                 			
                     		var EMAIL_REGEXP = new RegExp('^[a-z0-9]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,15})$', 'i');
                     		if(email!='' && email!='undefined' && cell==6 && !EMAIL_REGEXP.test(email)){ dronaEmail.push(row); }
                     		if(email!='' && email!='undefined' && cell==7 && !EMAIL_REGEXP.test(email)){ InternetEmail.push(row); }
                 			table_output += '<td>'+sheet_data[row][cell]+'</td>';
                 			
                 		}
                 	}
	
                 }
                
                 if(row>0){table_output += '<td>'+ <%=session.getAttribute("DesgId")%> +'</td>';}
                 if(row>0){table_output += '<td>'+ <%=session.getAttribute("Division")%> +'</td>';}
                 table_output += '</tr>';
              }
             table_output += ' <tbody>';
             document.getElementById('myTable1').innerHTML = table_output;
              
              var EmployeeNojsArray = [<%int i=0; for (Object[] obj:AllOfficerlist) { %>"<%= obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"" %>"<%= i + 1 < AllOfficerlist.size() ? ",":"" %><% } %>];
                     
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
             	 
             	 var msg='';
              	if(empname1.length>0){
              		msg+="Enter Employee Name at Serial No :"+ empname1+"\n";
              	}
	            if(phoneno.length>0){
	            	msg+="Employee Phone Number should be Numeric and 10 digit at Serial No :"+ phoneno+"\n";
	            }
             	if(Employeeno.length>0){
             		msg+="Employee Number should be Alpha Numeric at Serial No :"+ Employeeno+"\n";
              	}
             	if(indexval.length>0){
             		msg+="Duplicate Employee Number Existed in Excel file at Serial No :"+ indexval+"\n";
             	} 
             	if(dbDuplicate.length>0){
             		msg+="Employee Number already Existed at serial No :"+ dbDuplicate+"\n";
             	}
             	if(ExtNo.length>0){
             		msg+="Extension Number should be Numeric and 4 or 10 digit at serial No :"+ ExtNo+"\n";
             	}
             	if(EmpEmail.length>0){
             		msg+="Email is not valid at serial No :"+ EmpEmail +"\n";
             	}
             	if(dronaEmail.length>0){
             		msg+="Drona Email is not valid at serial No :"+ dronaEmail +"\n";
             	}	
             	if(InternetEmail.length>0){
             		msg+="Internet Email is not valid at serial No :"+ InternetEmail +"\n";
             	}
             	if(checkExcel>0){
        			 alert("Please Upload Employee Master Excel ");
        			excel_file.value = '';
        		} else {
	            	if(InternetEmail.length>0 || dronaEmail.length>0 || empname1.length>0 || EmpEmail.length>0 || ExtNo.length>0 || phoneno.length>0 || Employeeno.length>0 || dbDuplicate.length>0|| indexval.length>0  ){
	            		alert(msg);
	            		excel_file.value = '';
	            	} else {
	         			 $('#exampleModalLong').modal('show');
	         		}
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
 <script type="text/javascript">
 $(document).ready(function() {
		$("#myTable").DataTable({
				'aoColumnDefs': [{
				'bSortable': false,
			     
				'aTargets': [-1] /* 1st one, start by the right */
			}]
		});
	});
/*  $(document).ready(function(){
 	  $("#myTable1").DataTable({
 	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
 	 "pagingType": "simple",
 	 "pageLength": 5
 });
 }); */
 </script>

<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>