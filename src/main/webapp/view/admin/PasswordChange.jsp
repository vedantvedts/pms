<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<%


String ForceResetPwd = (String)request.getAttribute("ForcePwd"); 
 
%>

<meta charset="UTF-8">

<spring:url value="/resources/css/admin/PasswordChange.css" var="passwordChange" />
<link href="${passwordChange}" rel="stylesheet" />
     

<%if(ForceResetPwd!=null && ForceResetPwd.equals("N")){ %>
	<jsp:include page="../static/header.jsp"></jsp:include> 
<%}else{ %>
	<jsp:include page="../static/dependancy.jsp"></jsp:include>
	<title>Reset Password</title>
<%} %>

</head>
<body>

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
       
    	<div class="card shadow-nohover">
        	<div class="card-header bg-header" >
        		<div class="row">
					<div class="col-md-3">
						<h5 class="text-white">Password Change</h5>
					</div>
					<div class="col-md-9 ">
					</div>	
				</div>
        	</div>
        	
        	<div class="card-body" >		
				<div class="row"> 
	            	<div class="col-md-1"></div>
	            	<div class="col-md-11">
						<%if(ForceResetPwd!=null && ForceResetPwd.equals("Y")){ %>
							<span class="font" >Note : </span> 
							<span class="font-size">Please reset Your default Password to continue.</span>
							<br><br>
						<%} %>
					</div>
				</div>
					
					
				<form action="PasswordChanges.htm" method="POST" name="myfrm" id="myfrm">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" id="sessionKey" name="encKey" value="<%=(String)request.getAttribute("sessionKey")%>" />
					<input type="hidden" id="sessionIv"  name="encIv"  value="<%=(String)request.getAttribute("sessionIv")%>" />
					<input type="text" name="username" id="username" value="${sessionScope.Username}" autocomplete="username" class="dis-none" aria-hidden="true">
					
                	<div class="row"> 
                		<div class="col-md-1"></div>
                   		<div class="col-md-3">
                       		<div class="form-group">
                             	<label class="control-label">Old Password</label><span class="mandatory">*</span>
                            	<input  class="form-control form-control" type="password" placeholder="Old Password " required name="OldPassword" id="Oldpassword" autocomplete="current-password">
                       		</div>
                   		</div>
         					
                   		<div class="col-md-3">
                       		<div class="form-group">
								<label class="control-label">New Password</label><span class="mandatory">*</span>
								<div class="input-group">
									<input class="form-control" type="password" placeholder="New Password" required name="NewPassword" id="password" autocomplete="new-password">
									<div class="input-group-append cursor">
										<span class="input-group-text " onclick="togglePassword('password', this)" >
											<i class="fa fa-eye"></i>
										</span>
									</div>
									<small id="invalidCharAlert" class="text-danger"></small>
								</div>
								<small id="passwordHelp" class="form-text text-muted"></small>
								<div id="strengthBar" >
									<div id="strengthIndicator" ></div>
								</div>
							</div>
                   		</div>
                    		
                   		<div class="col-md-3">
                       		<div class="form-group">
								<label class="control-label">Confirm New Password</label><span class="mandatory">*</span>
								<div class="input-group">
									<input class="form-control" type="password" placeholder="Confirm New Password" required name="NewPassword" id="confirm_password" autocomplete="new-password">
									<div class="input-group-append cursor">
										<span class="input-group-text " onclick="togglePassword('confirm_password', this)" >
											<i class="fa fa-eye"></i>
										</span>
									</div>
								</div>
								<small id="pwd-rules" class="text-muted">
								  <ul class="ul-list">
								    <li id="rule-length" class="text-danger">❌ At least 8 characters</li>
								    <li id="rule-uppercase" class="text-danger">❌ At least 1 uppercase letter</li>
								    <li id="rule-lowercase" class="text-danger">❌ At least 1 lowercase letter</li>
								    <li id="rule-number" class="text-danger">❌ At least 1 number</li>
								    <li id="rule-special" class="text-danger">❌ At least 1 special character (@$!%*?&)</li>
								  </ul>
								</small>
								<span id='message'></span>

							</div>
                   		</div>
					</div> 
	                        
                    <div align="center"> 
                    	<input type="hidden" name="type" value="AD"/>
                    	<input type="hidden" name="ForcePwd" value="<%=ForceResetPwd%>"/>
   						<input type="submit" class="btn btn-sm submit" id="sub" value="SUBMIT" name="sub" onclick="return checkoldPassword(event)">
                    </div>
	                          
				</form>      
	  		</div>
	  		
        </div>
	</div>
	

<script type="text/javascript">
$(document).ready(function () {
    var $password = $('#password');
    var $confirmPassword = $('#confirm_password');
    var $submitBtn = $('#sub');
    var $message = $('#message');
    var $passwordHelp = $('#passwordHelp');
    var $strengthIndicator = $('#strengthIndicator');
    var $invalidAlert = $('#invalidCharAlert');
    
    var strongPasswordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    var allowedCharsRegex = /^[A-Za-z\d@$!%*?&]*$/;
    
    $submitBtn.prop('disabled', true);

    function showInvalidAlert(msg) {
        $invalidAlert.text(msg).fadeIn();
        setTimeout(function () {
            $invalidAlert.fadeOut();
        }, 3000);
    }
    
    function validatePasswords() {
        var pwd = $password.val();
        var cpwd = $confirmPassword.val();

     	// Check for invalid characters
        if (!allowedCharsRegex.test(pwd)) {
            showInvalidAlert("⚠ Invalid character detected! Use only letters, numbers, or @$!%*?&");
            // Remove last invalid character
            pwd = pwd.replace(/[^A-Za-z\d@$!%*?&]/g, '');
            $password.val(pwd);
        }
     
        // Strength calculation
        var strength = 0;
        if (pwd.length >= 8) strength++;
        if (/[A-Z]/.test(pwd)) strength++;
        if (/[a-z]/.test(pwd)) strength++;
        if (/\d/.test(pwd)) strength++;
        if (/[@$!%*?&]/.test(pwd)) strength++;

        var strengthPercent = (strength / 5) * 100;
        var color = 'red';
        if (strengthPercent >= 80) color = 'green';
        else if (strengthPercent >= 60) color = 'orange';

        $strengthIndicator.css({
            width: strengthPercent + '%',
            backgroundColor: color
        });

        updateChecklist(pwd);

        // Password strength
        if (!strongPasswordRegex.test(pwd)) {
            $passwordHelp.text('Must include uppercase, lowercase, number & special character')
                         .css('color', 'orange');
            $submitBtn.prop('disabled', true);
            $message.text('');
            return;
        } else {
            $passwordHelp.text('Strong password').css('color', 'green');
        }

        // Match check
        if (pwd !== cpwd || !cpwd) {
            $message.text('Passwords do not match ❌').css('color', 'red');
            $submitBtn.prop('disabled', true);
        } else {
            $message.text('Passwords match ✔').css('color', 'green');
            $submitBtn.prop('disabled', false);
        }
    }

    $password.on('input', validatePasswords);
    $confirmPassword.on('input', validatePasswords);

    $password.on('paste copy cut', function (e) { e.preventDefault(); });
    $confirmPassword.on('paste copy cut', function (e) { e.preventDefault(); });
});


function updateChecklist(password) {
	var rules = {
		length: password.length >= 8,
		uppercase: /[A-Z]/.test(password),
		lowercase: /[a-z]/.test(password),
		number: /\d/.test(password),
		special: /[@$!%*?&]/.test(password)
	};

	$('#rule-length').css('color', rules.length ? 'green' : 'red')
		.text((rules.length ? '✅ ' : '❌ ') + 'At least 8 characters');
	$('#rule-uppercase').css('color', rules.uppercase ? 'green' : 'red')
		.text((rules.uppercase ? '✅ ' : '❌ ') + 'At least 1 uppercase letter');
	$('#rule-lowercase').css('color', rules.lowercase ? 'green' : 'red')
		.text((rules.lowercase ? '✅ ' : '❌ ') + 'At least 1 lowercase letter');
	$('#rule-number').css('color', rules.number ? 'green' : 'red')
		.text((rules.number ? '✅ ' : '❌ ') + 'At least 1 number');
	$('#rule-special').css('color', rules.special ? 'green' : 'red')
		.text((rules.special ? '✅ ' : '❌ ') + 'At least 1 special character (@$!%*?&)');

	return Object.values(rules).every(Boolean);
}

function togglePassword(fieldId, icon) {
	var input = document.getElementById(fieldId);
	var iconElement = icon.querySelector('i');
	if (input.type === "password") {
		input.type = "text";
		iconElement.classList.remove('fa-eye');
		iconElement.classList.add('fa-eye-slash');
	} else {
		input.type = "password";
		iconElement.classList.remove('fa-eye-slash');
		iconElement.classList.add('fa-eye');
	}
}

function checkoldPassword(event) {
    event.preventDefault(); 

    var Npwd = $('#password').val();
    var cpwd = $('#confirm_password').val();
    var Opwd = $('#Oldpassword').val();

    if (!(Npwd && cpwd && Opwd)) {
        alert("Please Enter All Fields!");
        return false;
    }

    $.ajax({
        type: "POST",
        url: "NewPasswordChangeCheck.htm",
        data: { 
        	oldpass: encryptAES(Opwd), 
        	${_csrf.parameterName}:	"${_csrf.token}", 
        },
        datatype: 'json',
        success: function (result) {
            if (result === '1') {
                if (Npwd === Opwd) {
                    alert('Your New Password Should Not Be Same as Your Old Password');
                    return false; // stop here, no submission
                } else if (Npwd === '123' || Npwd === '1234') {
                    alert('Default or Weak Passwords are not Allowed');
                    return false;
                } else if (confirm("Are You Sure To Submit?")) {
                	document.getElementById("myfrm").requestSubmit();
                }
            } else {
                alert('Please Enter Correct Old Password.');
            }
        }
    });

    return false;
}

</script>

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function () {
	  const form = document.getElementById("myfrm");
	  if (!form) return;

	  form.addEventListener("submit", function(e) {
	    const oldPwdField = document.getElementById("Oldpassword");
	    const newPwdField = document.getElementById("password");
	    const cnfPwdField = document.getElementById("confirm_password");

	    const oldPwd = oldPwdField.value;
	    const newPwd = newPwdField.value;

	    if (oldPwd) oldPwdField.value = encryptAES(oldPwd);
	    if (newPwd){
	    	newPwdField.value = encryptAES(newPwd);
	    	cnfPwdField.value = newPwdField.value;
	    }
	    
	  });
	});
	
	function encryptAES(plain) {
    	
    	var keyBase64 = (document.getElementById("sessionKey") || {}).value || "";
	    var ivBase64  = (document.getElementById("sessionIv")  || {}).value || "";

	    const key = CryptoJS.enc.Base64.parse(keyBase64);
	    const iv  = CryptoJS.enc.Base64.parse(ivBase64);
	    
   		if (!plain) return "";
  		const encrypted = CryptoJS.AES.encrypt(
        	CryptoJS.enc.Utf8.parse(plain),
        	key,
        	{ iv: iv, mode: CryptoJS.mode.CBC, padding: CryptoJS.pad.Pkcs7 }
      	);
      return encrypted.ciphertext.toString(CryptoJS.enc.Base64);
    }
</script>
</body>
</html>