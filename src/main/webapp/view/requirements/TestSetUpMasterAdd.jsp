<%@page import="com.vts.pfms.requirements.model.TestSetUpAttachment"%>
<%@page import="com.vts.pfms.requirements.model.TestSetupMaster"%>
<%@page import="com.vts.pfms.requirements.model.TestInstrument"%>
<%@page import="com.vts.pfms.requirements.model.SpecificationTypes"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.requirements.model.SpecificationMaster"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<meta charset="ISO-8859-1">

<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />


<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<style>

label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}
 .toggle-switch {
       position: relative;
       display: inline-block;
       width: 60px;
       height: 34px;
   }

   .toggle-switch input {
       display: none;
   }
    .toggle-switch .label {
       margin-left: 10px;
       vertical-align: middle;
       font-weight: bold;
       font-size: 18px;
   }
      .slider {
       position: absolute;
       cursor: pointer;
       top: 0;
       left: 0;
       right: 0;
       bottom: 0;
       background-color: #ccc;
       transition: .4s;
       border-radius: 34px;
   }

   .slider:before {
       position: absolute;
       content: "";
       height: 26px;
       width: 26px;
       left: 4px;
       bottom: 4px;
       background-color: white;
       transition: .4s;
       border-radius: 50%;
   }

   input:checked + .slider {
       background-color: green;
   }

   input:checked + .slider:before {
       transform: translateX(26px);
   }
body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}




.multiselect {
	padding: 4px 90px;
	background-color: white;
	border: 1px solid #ced4da;
	height: calc(2.25rem + 2px);
}


#container {
    background-color: white;
    display: inline-block;
    margin-left: 2%;
    margin-top: 1%;
 
}

.select2-selection__choice{
	margin-bottom: 5px;
}

</style>
</head>
<body>

<%
List<TestInstrument>instrumentList = (List<TestInstrument>)request.getAttribute("instrumentList");
TestSetupMaster tp = (TestSetupMaster)request.getAttribute("tp");
List<TestSetupMaster>master = (List<TestSetupMaster>)request.getAttribute("testSetupMasterMaster");
List<TestSetUpAttachment>attachments = (List<TestSetUpAttachment>)request.getAttribute("listOfAttachments");

List<String>testIds= master!=null && master.size()>0?
		master.stream().map(e->e.getTestSetUpId()).collect(Collectors.toList())
			: new ArrayList<>();

List<String>instruements = new ArrayList<>();

if(tp!=null && tp.getTestInstrument()!=null && tp.getTestInstrument().length()>0){
	
	String[] list = tp.getTestInstrument().split(", ");
	
	instruements = Arrays.asList(list);
}
String htmlContent = (String)request.getAttribute("htmlContent");
%>



	<div class="container" id="container" style="max-width:95%">
		<form action="TestSetUpSubmit.htm" method="POST" enctype="multipart/form-data">
			<div class="row" id="row1">
			
				<div class="col-md-12" id="reqdiv" style="background: white;">
					<div class="card-body" id="cardbody">
					
					<div class="row">
						<div class="col-md-3">
								<div class="form-group">
                            	<label style="font-size: 17px;  color: #07689f">Test SetUp Id :<span class="mandatory" style="color: red;">*</span></label>
                         		<input type="text" class="form-control" required="required" name="testSetUpId" id="testSetUpId"  value="<%= tp!= null?tp.getTestSetUpId():""%>" onchange="checkSetUpId()">
                         	</div>
                         </div>
                         	
					       
					
								
					</div>
					
					<div class="row">
					
					<div class="col-md-11">
						<div class="form-group">
					 	<label style="font-size: 17px; color: #07689f">Specific Facility Required :<span class="mandatory" style="color: red;">*</span></label>
							<textarea rows="2" cols="100" class="form-control" required="required" maxlength="500" placeholder="Maximum 500 characters" name="facility"><%= tp!= null?tp.getFacilityRequired():""%></textarea>
						</div>
					 </div>
					</div>
					
									<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											Test Instrument 
										</label>
									</div>
									<div class="col-md-4" style="margin-top: 1%;">
										<div class="form-group">
											
												<select class="form-control selectdee" name="testInstrument" id="testInstrument" data-width="80%" data-live-search="true" multiple onchange="addTestInstrument()">
													<%for (TestInstrument t :instrumentList) {%>
														<option value="<%=t.getInstrumentId()%>"  <%if(instruements.contains(t.getInstrumentId()+"")){ %> selected <%} %>><%=t.getInstrumentName() %></option>
													<%} %>
													<option value="0"> ADD NEW</option>
												</select>
												</div>
												</div>
												
									<div class="col-md-1" style ="display: flex;justify-content:center;align-items: center;" >
										
										<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											TDRS:
										</label>
										</div>
									
										<div class="col-md-3" style="margin-top: 1%;">
										<input type="file" accept=".xls,.xlsx" class="form-control" name="tdrs" />
										</div>
										<%if(tp!=null && tp.getTdrsData()!=null ) {%>
										<div class="col-md-2" style="display: flex;justify-content:center;align-items: center;">
										<button class="btn btn-link" onclick ="showData()">  <%=tp.getTdrsData()!=null ?"  "+ tp.getTdrsData().split("_")[1]:"" %> </button>
										<button class="btn btn-sm" type="button" onclick="setDownloadTdrs()"  data-toggle="tooltip"
										data-placement="top" data-original-data=""
										title="TDRS file Download" >
									   <i class="fa fa-download" aria-hidden="true" style="color:green;"></i> </button>
										</div>
										
										<%} %>
										</div>
												
												</div>
					
					<div class="row">
							<div class="col-md-5">
							<div class="form-group">
							<label style="font-size: 17px;  color: #07689f">Test Set UP: <span class="mandatory" style="color: red;">*</span></label>
							<div id="Editor">
			   				<%= tp!= null?tp.getTestSetUp().trim():""%>

							</div>
							</div>
    						<textarea name="testSetup" style="display: none;"  id="testSetup"></textarea>	
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-6">
							<div class="form-group">
							<label style="font-size: 17px;  color: #07689f">Test Procedure: <span class="mandatory" style="color: red;">*</span></label>
							<div id="Editor1">
			   			<%= tp!= null?tp.getTestProcedure().trim():""%>

							</div>
							</div>
    						<textarea name="testProcedure" style="display: none;"  id="testProcedure"></textarea>	
						</div>
					</div>
					
					<div class="row">
					
						<div class="col-md-5">
							<div class="form-group">
							<label style="font-size: 17px;  color: #07689f">Objective: <span class="mandatory" style="color: red;">*</span></label>
							<div id="Editor3">
			   			<%= tp!= null?tp.getObjective().trim():""%>

							</div>
							</div>
    						<textarea rows="1" cols="100" style="display: none;" id="objective" class="form-control" required="required" maxlength="5000"  placeholder="Maximum 5000 characters" name="objective"></textarea>
						</div>
						<div class="col-md-1"></div>
					<%-- 		<div class="col-md-5">
							<div class="form-group">
							<label style="font-size: 17px;  color: #07689f">Technical Data Record Sheet (TDRS): <span class="mandatory" style="color: red;">*</span></label>
							<div id="Editor2">
			   			<%= tp!= null?tp.getTdrsData():""%>

							</div>
							</div>
    						<textarea name="tdrs" style="display: none;"  id="tdrs"></textarea>	
						</div> --%>
					
						<div class="col-md-3"> 
   				  <table class="table table-bordered">
     			 <thead>
        <tr>
    
            <th>Upload Attachment</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody id="specificationTable">
		<tr>
		
		<td><input type="file" name="attach" class="form-control" maxlength="250"   accept="application/pdf , image/* " ></td>
		<td ><button type="button" class="btn btn-sm" id="plusbutton"><i class="fa fa-plus" aria-hidden="true" style="color:green"></i></button></td>
		</tr>
		</tbody>     
     </table>						
						</div>
						
						<%if(attachments!=null && attachments.size()>0){ %>
						<div class="col-md-2">

								<table class="table table-bordered">
									<thead>
										<tr>

											<th>Linked Attachments</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
									<% int count=0;
									for(TestSetUpAttachment ta:attachments) {%>
									<tr id="<%=++count%>">
									<td><p>
								<%=	  "Attachement_"+ (count)%></p>
									</td>
									
									<td>
									<button class="btn btn-sm" type="button" onclick="setDownload(<%=ta.getAttachmentId() %>)"  data-toggle="tooltip"
										data-placement="top" data-original-data=""
										title="Download">
									
									 <i class="fa fa-download" aria-hidden="true" style="color:green;"></i></button>
									<button class="btn btn-sm" type="button"  onclick="deleteFile('<%=count%>','<%=tp.getSetupId()%>','<%=ta.getAttachmentId() %>')"   data-toggle="tooltip"
										data-placement="top" data-original-data=""
										title="Remove"> 
									<i class="fa fa-trash" aria-hidden="true" style="color:red;"></i></button>
									</td>
									</tr>
									<%} %>
									</tbody>
									</table>
									
							</div>
						<%} %>
						
						</div>
					
					<div align="center">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					<%if(tp==null){ %>	
					<button type="submit" class="btn submit" onclick="return submitForm()">
					SUBMIT
					</button>
					<%}else{ %>
					<input type="hidden" name="id" value="<%=tp.getSetupId()%>">
					<button type="submit" class="btn edit" onclick="return submitForm()">UPDATE</button>
					<%} %>
					<a class="btn back" href="TestSetUpMaster.htm">Back</a>
					</div>
					
					</div>
					</div>
					</form>
					
					
					<form method="get" action="TestSetupAttachmentDownload.htm" target="_blank">
					<input type="hidden" name="attachmentId" id="mid">
				
					<input type="hidden"  name="id" value="<%=tp!=null? tp.getSetupId():"0" %>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="submit" id="formsubmit" hidden="hidden">
					</form>
					
					
				    <form method="get" action="TestTdrsAttachmentDownload.htm" target="_blank">
					<input type="hidden"  name="id" value="<%=tp!=null? tp.getSetupId():"0" %>">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="submit" id="tdrsDownload" hidden="hidden">
					</form>
					
					</div>

<div class="modal" tabindex="-1" role="dialog" id="modalAdd">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Instrument ADD</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       	<div class="col-md-12">
		<div class="form-group">
         <label style="font-size: 17px;  color: #07689f">Instrument Name:<span class="mandatory" style="color: red;">*</span></label>
          <input type="text" class="form-control" required="required" name="InstrumentName" id="InstrumentName" placeholder="Maxlength 500 characters" maxlength="500" >
          </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn submit" onclick="saveName()">Save</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="htmlContentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" style=" width: 300%; margin-left: -100%;">
       <div class="modal-header">
        <h5 class="modal-title">TDRS Data</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ${htmlContent}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
$('#Editor').summernote({
	width: 700,
     toolbar: [
         // Adding font-size, font-family, and font-color options along with other features
         ['style', ['bold', 'italic', 'underline', 'clear']],
         ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
         ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
         ['para', ['ul', 'ol', 'paragraph']],
         ['height', ['height']]
     ],
     fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
     fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
     buttons: {
         // Custom superscript and subscript buttons
         superscript: function() {
             return $.summernote.ui.button({
                 contents: '<sup>S</sup>',
                 tooltip: 'Superscript',
                 click: function() {
                     document.execCommand('superscript');
                 }
             }).render();
         },
         subscript: function() {
             return $.summernote.ui.button({
                 contents: '<sub>S</sub>',
                 tooltip: 'Subscript',
                 click: function() {
                     document.execCommand('subscript');
                 }
             }).render();
         }
     },

   	height:150
    });


$('#Editor1').summernote({
	width: 700,
     toolbar: [
         // Adding font-size, font-family, and font-color options along with other features
         ['style', ['bold', 'italic', 'underline', 'clear']],
         ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
         ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
         ['para', ['ul', 'ol', 'paragraph']],
         ['height', ['height']]
     ],
     fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
     fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
     buttons: {
         // Custom superscript and subscript buttons
         superscript: function() {
             return $.summernote.ui.button({
                 contents: '<sup>S</sup>',
                 tooltip: 'Superscript',
                 click: function() {
                     document.execCommand('superscript');
                 }
             }).render();
         },
         subscript: function() {
             return $.summernote.ui.button({
                 contents: '<sub>S</sub>',
                 tooltip: 'Subscript',
                 click: function() {
                     document.execCommand('subscript');
                 }
             }).render();
         }
     },

   	height:150
    });
$('#Editor2').summernote({
	width: 700,
     toolbar: [
         // Adding font-size, font-family, and font-color options along with other features
         ['style', ['bold', 'italic', 'underline', 'clear']],
         ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
         ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
         ['para', ['ul', 'ol', 'paragraph']],
         ['height', ['height']]
     ],
     fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
     fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
     buttons: {
         // Custom superscript and subscript buttons
         superscript: function() {
             return $.summernote.ui.button({
                 contents: '<sup>S</sup>',
                 tooltip: 'Superscript',
                 click: function() {
                     document.execCommand('superscript');
                 }
             }).render();
         },
         subscript: function() {
             return $.summernote.ui.button({
                 contents: '<sub>S</sub>',
                 tooltip: 'Subscript',
                 click: function() {
                     document.execCommand('subscript');
                 }
             }).render();
         }
     },

   	height:150
    });
$('#Editor3').summernote({
	width: 700,
     toolbar: [
         // Adding font-size, font-family, and font-color options along with other features
         ['style', ['bold', 'italic', 'underline', 'clear']],
         ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
         ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
         ['para', ['ul', 'ol', 'paragraph']],
         ['height', ['height']]
     ],
     fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
     fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
     buttons: {
         // Custom superscript and subscript buttons
         superscript: function() {
             return $.summernote.ui.button({
                 contents: '<sup>S</sup>',
                 tooltip: 'Superscript',
                 click: function() {
                     document.execCommand('superscript');
                 }
             }).render();
         },
         subscript: function() {
             return $.summernote.ui.button({
                 contents: '<sub>S</sub>',
                 tooltip: 'Subscript',
                 click: function() {
                     document.execCommand('subscript');
                 }
             }).render();
         }
     },

   	height:150
    });
    
    
    
    function addTestInstrument(){
    	
    	var value = $('#testInstrument').val();
    
    	if(value.includes('0')){
    		console.log("Hii")
    		value = value.filter(e=>e!=='0')
    		$('#testInstrument').val(value).trigger('change')
    		
    		$('#modalAdd').modal('show');
    		 $('#InstrumentName').val('')
    	}
    }
    
    function saveName(){
    	
    	
    	
    	var value1 = $('#testInstrument').val();
        console.log(value1)
    	
    	
    	var value= $('#InstrumentName').val();
    	
    	if(value.length===0){
    		alert("Please give Instrument Name!")
    	}else{
    		if(confirm('Are you sure to submit?')){
    			
    		$.ajax({
   			 type:'GET',
			 url:'saveTestInstrumentName.htm',
			 data:{
				 InstrumentName:value
			 },
			 datatype:'json',
			 success : function(result){
				 value1.push(result+"");
			      var data = $('#testInstrument').html();
                  data = "<option value='" + result + "' selected>" + value + "</option>" + data;

            
                  
                  $('#testInstrument').html(''); 
                  $('#testInstrument').append(data);
                  $('#testInstrument').val(value1).trigger('change'); 

                  $('#modalAdd').modal('hide');
			 }
			})
			
		 
    		}else{
    			event.preventDefault();
    		}
    		
    		
    	}
    }
    
    function submitForm(){

 	   	$('textarea[name=testSetup]').val($('#Editor').summernote('code'));
    
 	   	$('textarea[name=testProcedure]').val($('#Editor1').summernote('code'));
   
 	    $('textarea[name=tdrs]').val($('#Editor2').summernote('code'));
 	    $('textarea[name=objective]').val($('#Editor3').summernote('code'));
 	   
 	   if(confirm('Are you sure to submit?')){
 		   
 		   
 	   }else{
 		   
 		   return false;
 		   event.preventDefault();
 	   }
 	   
    	
    }
    
   var setUpId= '<%= tp!= null?tp.getTestSetUpId():""%>';
   
   var testids = [];
   
   <%
   if(testIds.size()>0){
   for(String s:testIds){
   %>
   testids.push('<%=s%>')
   
   <%}}%>
 function  checkSetUpId(){

	 var value = $('#testSetUpId').val();
	 if(value!==setUpId){
		 if(testids.includes(value)){
			 alert("Test SetUp Id Already Exist !")
			 $('#testSetUpId').val("");
		 }
	 }
	
 }
   
 
 $("#plusbutton").click(function() {
     var newRow = `
         <tr>
             <td><input type="file" name="attach" class="form-control" maxlength="250" required accept="application/pdf , image/* "></td>
             <td><button type="button" class="btn btn-sm"><i class="fa fa-minus" aria-hidden="true" style="color:red" ></i></button></td>
         </tr>
     `;
     $("#specificationTable").append(newRow);

     // Attach event handler for the newly added minus button
     $("#specificationTable tr:last-child td:last-child button").click(function() {
         $(this).closest("tr").remove();
     });
 });
    
 
 function deleteFile(trcount,setUpId,attachmentId){
	 
	 
	 if(confirm('Are you sure to submit?')){
		  
		 
		 $.ajax({
			type:'GET',
			url:'deleteTestSetUpAttachement.htm',
			datatype:'json',
			data:{
				setUpId:setUpId,
				attachmentId:attachmentId,
			},
			success:function(result){
				var ajaxresult = JSON.parse(result);
				
				if(ajaxresult===1){
					alert("Attachment removed successfully!");
					 $('#'+trcount).hide();
				}
			}
			 
		 })
		 
	 }else{
		 
		 event.preventDefault();
		 return false;
	 }
	 
	 
	 
	 
	
 }
 
 
 $(function () {
		$('[data-toggle="tooltip"]').tooltip()
		})
 
 
 function setDownload(a){
	 $('#mid').val(a);
	 $('#formsubmit').click();
 }
 
 
 function setDownloadTdrs(){
	 $('#tdrsDownload').click();
 }
 function showData(){
	 $('#htmlContentModal').modal('show');
 }
 
 
/*  $(document).ready(function () {
	    var maxRows = 11; // how many rows to show
	    $(".htmlTable tr").each(function (index) {
	      if (index >= maxRows) {
	        $(this).hide();
	      }
	    });
	  }); */
	  
	  
	  
</script>
</body>
</html>