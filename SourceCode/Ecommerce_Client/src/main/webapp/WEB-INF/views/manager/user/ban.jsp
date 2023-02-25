<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="mt" tagdir="/WEB-INF/tags"%>
<mt:managertemplate title="${title }">
	<jsp:attribute name="content">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>${parentPageTitle }</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath }/manager/user/index">${parentPageTitle }</a></li>
								<li class="breadcrumb-item active">${pageTitle }</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<!-- general form elements -->
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">${pageTitle }</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->
								<form method="POST" id="form"
								action="${pageContext.request.contextPath }/manager/user/ban">
									<div class="card-body">
										<div class="form-group">
											<span style="font-size:20;">Send an email to user <label>${username }</label> to inform the reason and duration of their ban.</span>
										</div>
									
										<div class="form-group">
											<label for="banDuration">Ban duration (month)</label>
											<input type="number" min="1" class="form-control"
											name="banDuration" value="1"></input>
										</div>
									
										<div class="form-group">
											<label for="subject">Subject</label>
											<input type="text" class="form-control" name="subject"
											placeholder="Enter mail's subject" value="${subject }"></input>
										</div>
											
										<div class="form-group">
											<label for="content">Content</label>
											<textarea id="summernote" name="content">
												${content }
											</textarea>
										</div>
										<input type="hidden" name="id" value="${id }">
										
										<div class="form-check">
											<input type="checkbox" class="form-check-input"
											name="isHTMLText">
											<label for="isHTMLText"
											title="Unchecked this box if email's content only contains plain text (Source Sans Pro font).">Email's content is formatted (bold, italic, special fonts,...)</label>
										</div>
									</div>
									<!-- /.card-body -->

									<div class="card-footer">
										<button type="submit" class="btn btn-primary">Submit</button>
										<button type="reset" class="btn btn-danger float-right">Reset</button>
									</div>
								</form>
							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
			
	<input type="hidden" id="msg" value="${msg }">
	<input type="hidden" id="msgType" value="${msgType }">

	<!-- jQuery  -->
	<script src="${pageContext.request.contextPath }/resources/manager/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="${pageContext.request.contextPath }/resources/manager/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${pageContext.request.contextPath }/resources/manager/dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script
			src="${pageContext.request.contextPath }/resources/manager/dist/js/demo.js"></script>

	<!-- Page specific script -->
	
	<!-- jquery-validation -->
	<script src="${pageContext.request.contextPath }/resources/manager/plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/manager/plugins/jquery-validation/additional-methods.min.js"></script>
	<!-- Summernote -->
	<script src="${pageContext.request.contextPath }/resources/manager/plugins/summernote/summernote-bs4.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#summernote').summernote();
			
			$.validator.setDefaults({
			    submitHandler: function () {
			    	$('#form')[0].submit();
			    }
			  });
				
			  $('#form').validate({
			    rules: {
			      subject: {
			        required: true,
			        minlength: 5,
			        maxlength: 100,
			      },
			      content: {
			    	 required: true,
				     minlength: 20,
				     maxlength: 500,
			      }
			    },
			    errorElement: 'span',
			    errorPlacement: function (error, element) {
			      error.addClass('invalid-feedback');
			      element.closest('.form-group').append(error);
			    },
			    highlight: function (element, errorClass, validClass) {
			      $(element).addClass('is-invalid');
			    },
			    unhighlight: function (element, errorClass, validClass) {
			      $(element).removeClass('is-invalid');
			    }
			  });
		});
	</script>			

	</jsp:attribute>
</mt:managertemplate>