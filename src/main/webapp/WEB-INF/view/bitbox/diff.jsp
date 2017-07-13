<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>BITBOX</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="/dist/css/skins/_all-skins.min.css">

<!-- test -->
<link href='https://kr.piliapp.com/text-diff/' rel='canonical' />
<link rel="stylesheet" type="text/css" href="/js/3nsek.css" />
<link rel="alternate" type="application/rss+xml"
	title="RSS 2.0 - all apps"
	href="http://feeds.feedburner.com/sopilitools_en" />

<!-- jquery -->
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>


<style type="text/css">
.text {
	min-width: 550px;
	min-height: 100px;
}

#result_block {
	display: none;
}

.result {
	padding: 5px;
	border: solid gray;
}

hr {
	
}

ins {
	background-color: #E6FFE6;
}

del {
	background-color: #FFE6E6;
}

.file {
	-webkit-appearance: textfield;
	background-color: white;
	-webkit-rtl-ordering: logical;
	user-select: text;
	cursor: auto;
	padding: 1px;
	border-width: 2px;
	border-style: inset;
	border-color: initial;
	border-image: initial;
}
</style>
<meta name="google" value="notranslate" />
<script>
	(function(i, s, o, g, r, a, m) {
		i['GoogleAnalyticsObject'] = r;
		i[r] = i[r] || function() {
			(i[r].q = i[r].q || []).push(arguments)
		}, i[r].l = 1 * new Date();
		a = s.createElement(o), m = s.getElementsByTagName(o)[0];
		a.async = 1;
		a.src = g;
		m.parentNode.insertBefore(a, m)
	})(window, document, 'script',
			'//assets-us2.piliapp.com/s3pxy/base/ga.min.js', 'ga');
	var ga_trackers = [ '' ];
	ga('create', 'UA-973474-10');
	ga('create', 'UA-973474-5', {
		'name' : 't2'
	});
	ga_trackers.push('t2.');

	if (typeof ga_pageview_params === 'undefined')
		var ga_pageview_params = "\/text-diff\/?hl=kr";
</script>
<script type="text/javascript">
	(function(c) {
		for ( var b in c) {
			var d = c[b];
			ga(d + "require", "displayfeatures");
			if (typeof ga_dimensions !== "undefined") {
				for ( var a in ga_dimensions) {
					ga(d + "set", "dimension" + ga_dimensions[a][0],
							ga_dimensions[a][1])
				}
			}
			if (typeof ga_dimension !== "undefined") {
				ga(d + "set", "dimension" + ga_dimension[0], ga_dimension[1])
			}
			if (typeof ga_pageview_params === "undefined") {
				ga(d + "send", "pageview")
			} else {
				ga(d + "send", "pageview", ga_pageview_params)
			}
		}
	})(ga_trackers);
</script>
<script>
	var _gaq = _gaq || [];
	var GA_EVENT_ID = 'UA-973474-16';

	(function(w) {
		var l = w.location, h = w.history, m = l.href.match(/#ref=([\w-]+)$/);
		if (!m)
			return;
		l.hash = '';

		ga('create', GA_EVENT_ID, 'auto', {
			'name' : 'event'
		});
		ga('event.send', 'event', 'ref', l.pathname + l.search, m[1]);

		if (h.replaceState)
			h.replaceState('', document.title, l.href.split('#')[0]);
	})(window);
</script>
<script type="text/javascript">
	document.body.className = document.body.className.replace('no-js', '')
			+ ' js';
</script>

<!-- ajax -->


</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="sidebar.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<section class="content-header">
				<div class="box-body">
					<h2 align="center">Diff</h2>
					<h3 align="center">코드 비교</h3>
				</div>
			</section>
			<section style="padding: 15px">
				<div class="box">
					<div class="content">
						<div class="form-group" style="padding-left: 10px;">
							<h3 style="border-bottom: 1px solid gray">
								<i class="fa fa-cog"></i> 표시 형식
								</h3>
								<label> <input type='radio' name='methods' value='a'
									checked='checked'/>다른부분 밑줄긋기(비추천)
								</label><br> <label> <input type='radio' name='methods'
									value='b'/>한 페이지로 보기
								</label><br> <label> <input type='radio' name='methods'
									value='c' />두 페이지로 보기
								</label><br>
						</div>
						<div style="padding: 20px">
						<div class="row" style="border: 3px solid white">
							<div class="col-xs-6">
								<!-- form action="/bitbox/read" enctype="multipart/form-data" method="post" -->
								<h3><i class="fa fa-file-text-o"></i> 첫번째 코드</h3>
								<input class="file1 file" type="file" name="file1" id="file1" style="background-color: antiquewhite;">
								<br>
								<!-- /form -->
								<textarea id='oldtext' cols="120" rows="15" name='oldtext'
									class='old text'></textarea>
							</div>
							<div class="col-xs-6">
								<!-- form -->
								<h3><i class="fa fa-file-text-o"></i> 두번째 코드</h3>
								<input class="file2 file" type="file" name="file2" id="file2" style="background-color: antiquewhite;">
								<br>
								<!-- /form -->
								<textarea id='newtext' cols="120" rows="15" name='newtext'
									class='new text'></textarea>
							</div>
						</div>
						</div>
						<div class="form-group"
							style="padding-left: 5px; padding-top: 10px;">
							<input type='button' name='compare' class="btn btn-primary"
								value='비교하기' />
						</div>
						<div id="result_block">
							<a name="diff"></a>
							<h1>결과</h1>
							<div class='text result' id='result'></div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<%@include file="controlSideBar.jsp"%>
	</div>
	<script type='text/javascript'
		src='//kr.piliapp.com/static/s3/apps/ajax/libs/jquery/1.3.2/jquery.min.js'></script>
	<script src="//kr.piliapp.com/assets/us2/v2/ew9wabkghp3ru4r/4g8tt.js"></script>
	<script type='text/javascript'>
		function nl2br(str, is_xhtml) {
			breakTag = '<br />';
			if (typeof is_xhtml != 'undefined' && !is_xhtml) {
				breakTag = '<br>';
			}

			return (str + '').replace(/([^>]?)\n/g, '$1' + breakTag + '\n');

		}
		function method1() {
			method1_go();
		}

		function method1_go() {
			$("#result")
					.html(
							nl2br(diffString($('#oldtext').val(), $('#newtext')
									.val())));
			$("#result_block").show();
		}
		function method2() {
			method2_go();
		}
		function method2_go() {
			var base = difflib.stringAsLines($("#oldtext").val());
			var newtxt = difflib.stringAsLines($("#newtext").val());
			var sm = new difflib.SequenceMatcher(base, newtxt);
			var opcodes = sm.get_opcodes();
			var diffoutputdiv = $("#result").get(0);
			while (diffoutputdiv.firstChild)
				diffoutputdiv.removeChild(diffoutputdiv.firstChild);
			var contextSize = null;
			diffoutputdiv.appendChild(diffview.buildView({
				baseTextLines : base,
				newTextLines : newtxt,
				opcodes : opcodes,
				baseTextName : "첫 번째 텍스트",
				newTextName : "두 번째 텍스트",
				contextSize : contextSize,
				viewType : ($("input[name=methods]:checked").val() == 'b') ? 1
						: 0
			/*1 inline , 0 side*/}));
			$("#result_block").show();
		}

		function bind_submit() {
			$("input[name=compare]").click(function() {
				$('#oldtext').val($.trim($('#oldtext').val()));
				$('#newtext').val($.trim($('#newtext').val()));
				if ($("input[name=methods]:checked").val() == 'a')
					method1();
				else
					method2();
			});
		}
		function bind_fullscreen() {
		}
		$(document).ready(function() {
			bind_submit();
		});

		function readT() {
			alert()
		}
	</script>
	<!-- jQuery 2.2.3 -->
	<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script src="/bootstrap/js/bootstrap.min.js"></script>
	<!-- Slimscroll -->
	<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/dist/js/demo.js"></script>

	<!-- test -->
	<script src="//kr.piliapp.com/assets/us2/v2/ew9wabkghp3ru4r/4g8tt.js"></script>
	<script
		src="//s7.addthis.com/js/250/addthis_widget.js#pubid=girvan&async=1"></script>
	<script>
		addthis.init();
	</script>
	<script type="text/javascript">
		var files = [];
		$(document).on("change", "#file1", function(event) {
			files = event.target.files;
			processUpload_1();
		})
		
		$(document).on("change", "#file2", function(event) {
			files = event.target.files;
			processUpload_2();
		})

		
		function processUpload_1() {
			var oMyForm = new FormData();
			oMyForm.append("file", files[0]);
			$.ajax({
				
				url : "/bitbox/read",
				data : oMyForm,
				type : "POST",
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				success : function(data) {
					//alert('success');
					$("#oldtext").val(data);
					//...;
				},
				error : function(data) {
					alert('error');
					//...;
				}
			});
		}
		
		function processUpload_2() {
			var oMyForm = new FormData();
			oMyForm.append("file", files[0]);
			$.ajax({
				
				url : "/bitbox/read",
				data : oMyForm,
				type : "POST",
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				success : function(data) {
					//alert('success');
					$("#newtext").val(data);
					//...;
				},
				error : function(data) {
					alert('error');
					//...;
				}
			});
		}
	</script>
</body>
</html>