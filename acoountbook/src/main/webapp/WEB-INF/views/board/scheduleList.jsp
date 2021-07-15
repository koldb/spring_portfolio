<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
/* Remove the navbar's default rounded borders and increase the bottom margin */
.navbar {
	margin-bottom: 50px;
	border-radius: 0;
}

/* Remove the jumbotron's default bottom margin */
.jumbotron {
	margin-bottom: 0;
}

/* Add a gray background color and some padding to the footer */
#footer {
	margin-top: 50px;
	background-color: #f2f2f2;
	padding: 25px;
}

#content {
	margin-left: 50px;
	margin-right: 50px;
	overflow: hidden;
}

#title {
	border-bottom: 2px solid #727377;
}

#title>*, #leftTop>* {
	display: inline-block;
}

#leftMenu, #rightMenu {
	margin-top: 10px;
}

.sceduleSelect {
	height: 34px;
	width : 79px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.form-group > div {
	margin-bottom: 5px;
}

textarea {
	resize : none;
}

#rightTop > div > span {
	height: 26px;
	margin-top: 20px;
	margin-bottom: 10px;
	padding-top: 5px;
	cursor: pointer;
}

.font-red {
	color: red;
}

.font-blue {
	color: blue;
}

#bgYellow {
	background-color: yellow;
}
 
#calendar > tbody > tr >  td {
	height: 80px;
}

.scheduleInDiv {
	width: 100%;
	height: 60px;
}

.scheduleDiv {
	background-color: blue;
	color: white;
	border-radius: 5px;
	font-size: 8pt;
	text-align: left;
	cursor: pointer;
	padding-left: 5px;
}

.pointer {
	cursor: pointer;
}

.show {
	width: 138px;
	position: absolute;
	margin-top: -85px;
}

.borderDiv {
	border: solid 3px gray;
	background-color: white;
}

.small-icon {
	line-height: 20px;
	height: 20px;
	width: 20px;
	pointer-events: auto;
	cursor: pointer;
}

.bgWhite {
	background-color: white;
}


</style>

<script type="text/javascript">
	var date;
	var nowYear;
	var nowMon;
	var nowDay;
	var year;
	var mon;
	var day;
	var hour;
	var min;
	
	
	// 사용자가 이벤트를 발생시킨 시간을 받아오는 함수
	function getTime() {
		date = new Date();
		nowYear = date.getFullYear();
		nowMon = date.getMonth() + 1;
		nowDay = date.getDate();
		year = date.getFullYear();
		mon = date.getMonth() + 1;
		day = date.getDate();
		hour = date.getHours();
		min = date.getMinutes();
	}
	
	$(document).ready(function() {
		today();
		addHour();
		addMin();
		getTime();
		getYearMonth();
		getCalendar();
		selectSchedule();
		
		
		// 달력 날짜 변경
		$("span").on("click", function() {
			var id = $(this).attr("id");
			
			if (id=="preYear") {
				if (year > 1) {
					year = year - 1;	
				}
				else if (year == 0) {
					alert("년도를 확인해주세요.");
					return;
				}
				getYearMonth();
				getCalendar();
				selectSchedule();
			}
			else if (id=="preMonth") {
				if (mon == 1 && year > 1) {
					year = year - 1;
					mon = 12;
				}
				else if (mon != 1 && year >= 1) {
					mon = mon - 1;
				}
				else if (mon == 1 && year == 1) {
					alert("년도를 확인해주세요.");
					return;
				}
				getYearMonth();
				getCalendar();
				selectSchedule();
			}
			else if (id=="nextMonth") {
				if (mon == 12) {
					year = year + 1;
					mon = 1;
				}
				else if (mon != 12) {
					mon = mon + 1;
				}
				getYearMonth();
				getCalendar();
				selectSchedule()
			}
			else if (id=="nextYear") {
				year = year + 1;
				getYearMonth();
				getCalendar();
				selectSchedule();
			}
		});

		$("#subject").on("keyup", function() {
			if ($(this).val().length > 10) {
				$(this).val($(this).val().substring(0, 10));
			}
		});
		
		$("#subject_up").on("keyup", function() {
			if ($(this).val().length > 10) {
				$(this).val($(this).val().substring(0, 10));
			}
		});
		
		// 일정 추가
		$("#scheduleInsert").on("click", function() {
			var startStr = $("#startYMD").val() + " " + $("#startHour").val() + ":" + $("#startMin").val() + ":00";
			var endStr = $("#endYMD").val() + " " + $("#endHour").val() + ":" + $("#endMin").val() + ":00"
			
			$("#startDate").val(startStr);
			$("#endDate").val(endStr);
			
			if ($("#subject").val() == "") {
				alert("제목을 입력해주세요.");
				return;
			}
			else if ($("#startYMD").val() == "") {
				alert("시작일을 입력해주세요.");
				return;
			}
			else if ($("#endYMD").val() == "") {
				alert("종료일 입력해주세요.");
				return;
			}
			else if ($("#memo").val() == "") {
				alert("내용을 입력해주세요.");
				return;
			}
			else if ($("#startDate").val() > $("#endDate").val()) {
				alert("시작일과 종료일을 확인해주세요.");
				return;
			}
			
			$("#scheduleInsertForm").submit();
		});
		
		/* $(document).on("click", ".scheduleInDiv > div > a", function() {
			var name = $(this).attr("data-arrmore");
			var state = $("#" + name).attr("class");
			
			if (state == "hide") {
				$("#" + name).attr("class", "show");	
			}
			else if (state == "show") {
				$("#" + name).attr("class", "hide");
			}
		});
		
		$(document).on("click", ".small-icon", function() {
			var name = $(this).attr("data-arrmore");
			var state = $("#" + name).attr("class");
			
			if (state == "hide") {
				$("#" + name).attr("class", "show");	
			}
			else if (state == "show") {
				$("#" + name).attr("class", "hide");
			}
		});
		
		$(document).on("mouseover", ".scheduleDiv", function() {
			$(this).attr("data-toggle", "modal");
			$(".scheduleDiv").show();
		});
	
		$(document).on("mouseout", ".scheduleDiv", function() {
			$(this).attr("data-toggle", "tooltip");
		});
		
		$(document).on("click", ".scheduleDiv", function() {
			var params = {
				param : $(this).attr("data-value")
			}
			
			readSchedule(params);
		}); */
		
		/* $("#updateSchedule").on("click", function() {
			var params = {
				num : $("#num_up").val(),
				subject : $("#subject_up").val(),
				startDate : $("#startDate_up").val(),
				endDate : $("#endDate_up").val(),
				memo : $("#memo_up").val()
			}
			
			updateSchedule(params);
		});
		
		$("#deleteSchedule").on("click", function() {
			deleteSchedule();
		});*/
	});
	
	// 입력 폼에 자동으로 오늘 날짜 넣기
	function today() {		
		var date = new Date();

		var yyyy = date.getFullYear();
		var mm = (date.getMonth() + 1)
		var dd = date.getDate();

		if (mm < 10) {
			mm = "0" + mm;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}

		var str = yyyy + "-" + mm + "-" + dd;

		$("#startYMD").val(str);
		$("#endYMD").val(str);
	}
	
	// 입력 폼에 자동으로 시간넣기
	function addHour() {
		var str = "";
		for (var i = 0; i <= 23 ; i++) {
			if (i<10) {
				str = str + "<option value='0" + i + "'>0" + i + "</option>";	
			}
			else if (i>=10) {
				str = str + "<option value='" + i + "'>" + i + "</option>";
			}	
		}
		$("#startHour").html(str);
		$("#endHour").html(str);
	}
	
	// 입력 폼에 자동으로 분 넣기
	function addMin() {
		var str = "";
		for (var i = 0; i <= 59 ; i=i+5) {
			if (i<10) {
				str = str + "<option value='0" + i + "'>0" + i + "</option>";	
			}
			else if (i>=10) {
				str = str + "<option value='" + i + "'>" + i + "</option>";
			}	
		}
		$("#startMin").html(str);
		$("#endMin").html(str);
	}
		
	
	// 년도 및 월을 뿌리는 함수
	function getYearMonth() {
		$("#toYearMonth").text(year + "년　" + mon + "월");	
	}
	
	// 날짜를 뿌리는 함수
	function getCalendar() {
		// 해당 달 1일의 요일을 받아옴
		var week = (new Date(year+"-"+mon+"-01")).getDay();       // getDay() : 요일 반환 0~6
		// 해당 달의 마지막일을 받아옴
		var lastDay = (new Date(year, mon, 0)).getDate();        //getDate() : 1~31일자 반환
		var newLine = 0;                                         //요일 라인 값 (세로)
		var str = "<tr>";
		
		// 그 달의 1일인 요일보다 이전 요일이라면 
		for (var i=0; i<week; i++) {
			str = str + "<td class='text-right'></td>";
			newLine++;
		}
		
		for (var i=1; i<=lastDay; i++) {   //1일부터 td 그리기 시작
			if (nowYear != year || nowMon != mon || i != day) {
				str = str + "<td class='inDiv text-right'>" + i + "<div id='day" + i + "' class='scheduleInDiv'></div></td>";	
			}
			else if (nowYear == year && nowMon == mon && i == day) {
				str = str + "<td id='bgYellow' class='text-right'>" + i + "<div id='day" + i + "' class='scheduleInDiv'></div></td>";
			}
			newLine++;  
			if (newLine == 7 && i != lastDay) {
				newLine = 0;
				str = str + "</tr><tr>";
			}
		}
		
		for (var i=newLine; i<7; i++) {
			str = str + "<td class='text-right'></td>";
		}
		
		str = str + "</tr>";
		
		$("#calendar > tbody").html(str);
	}
	
	// 달력을 다 그리고 나서 칸에 맞게 일정 넣기
	function selectSchedule() {
		
		var str = null;
		
		if (mon < 10) {
			str = "0" + mon;
		}
		
		var param = year + "-" + str;
		var userID = "${member.userId}";
		console.log(userID);
		
		var params = {
			param : param,
			writer : userID
		}
		
		console.log(typeof params);
		console.log(typeof userID);
		
		$.ajax({
			url : "/schedule/selectSchedule",
			type : "POST",
			dataType : "json",
			data : JSON.stringify(params),
			contentType : "application/json; charset=UTF-8",
			beforeSend : function() {
				
			},
			success : function(data) {
				
				console.log("data : " + data);
				
				var arr = new Array(32);
				var arrTemp = [];
				var str = "";
				var arrMore = [];
				
				// 배열을 0으로 초기화 시킨다.
				for (var i=0; i<arr.length; i++) {
					arr[i] = 0;
				}
				
				$.each(data, function(idx, val) {
					// num : 몇일인지를 나타내는 변수
					// arr : 배열은 총 32칸이며 1일에 일정이 1개라면 arr[1]에는 int형 1이 들어있다.
					// arrTemp : 배열은 몇 개인지 알 수 없으며, arr배열의 값중 3이상인 값이 몇번째 arr에 들어있는지를 보관한다. 
					// startDay : 일정 시작일
					// endDay : 일정 종료일
					// subDay : 일정 종료일 - 일정 시작일
					// arrMore : more 클릭했을 때 출력시킬 내용
					
					// DB에서 조회한 일정 시작일과 일정 종료일을 변수에 넣는다.
					var startDay = new Date(val.startDate.substring(0, 6));
					var endDay = new Date(val.endDate.substring(0, 6));

					
					
					console.log("타입 확인 : "+ typeof startDay);
					console.log("넌 startDay " + startDay);
					
					console.log("인덱스 : " + idx);
					console.log("val : " + val);
					console.log("start val : " + typeof val.startDate);
					console.log("start val num : " + val.startDate);
					console.log("start val num : " + val.endDate);
					
					
					

					
					
					
					// 만약, 일정 시작일이 지난달 이거나 일정 종료일이 다음달이면 이번달 시작일과 이번달 종료일로 변경한다. 
					if (mon != Number(startDay.getMonth() + 1)) {
						startDay = new Date(year + "-" + mon + "-" + "01");
						if (mon < 10) {
							startDay = new Date(year + "-0" + mon + "-" + "01");
						}
					}
					if (mon != Number(endDay.getMonth() + 1)) {
						endDay = new Date(year + "-" + mon + "-" + (new Date(year, mon, 0)).getDate().toString());
						if (mon < 10) {
							endDay = new Date(year + "-0" + mon + "-" + (new Date(year, mon, 0)).getDate().toString());
						}
					}
					
					// 종료일에서 시작일 빼기 계산식
					var subDay = ((endDay - startDay) / (60 * 60 * 24 * 1000) + 1);
					
					var num = Number((startDay.toString()).substring(8, 10));
					
					// 해당 일자에 일정이 3개 이하면 달력에 표시하고 4개 이상이면 3개까지만 출력하고 
					// 나머지는 arrTemp에 해당 일자가 있는지 조회하고 없으면 arrTemp 배열에 해당 날짜를 넣어라.
					for (var i=0; i<subDay; i++) {
						
						if (arr[num + i] < 3) {
							arr[num + i]++;
							str = "<div class='scheduleDiv' data-toggle='tooltip' data-placement='top' title='" + val.subject + "' data-value='" + val.num + "' data-toggle='modal' data-target='#myModal'>" + (val.subject.length<8?val.subject:(val.subject.substring(0, 8)+" ...")) + "</div>";
							$("#day" + (num + i)).append(str);
						}
						else if (arr[num + i] >= 3) {
							arr[num + i]++;
							str = "<div class='scheduleDiv' data-toggle='tooltip' data-placement='top' title='" + val.subject + "' data-value='" + val.num + "' data-toggle='modal' data-target='#myModal'>" + (val.subject.length<8?val.subject:(val.subject.substring(0, 8)+" ...")) + "</div>";
							// arrTemp에 해당 일자가 있는지 조회하고 있으면 arrMore[j]에 추가하고 for문을 종료,
							// 없으면 arrTemp에 해당 날짜를 집어넣고 arrMore에는 그날의 내용을 넣음
							for (var j=0; j<arrTemp.length; j++) {
								if (arrTemp[j] == num) {
									arrMore[j] = arrMore[j] + str;
									return;
								}
							}
							arrTemp.push(num + i);
							
							var target = $("#day" + (num + i));
							var text = "";
							
							for (var i=0; i<target.length; i++) {
								text = text + target.eq(i).html();
							}
							arrMore.push(text + str);
						}
					}
					
				});
				
				// 예) 하루에 일정이 3개 이상인 날짜가 5개가 있다 : for문 5번 돎
				for (var i=0; i<arrTemp.length; i++) {
					var cnt = arr[arrTemp[i]] - 3;
					str = "<div class='text-right'><a class='pointer' data-arrMore='hide" + i + "'>+" + cnt + " more</a></div>";
					$("#day" + arrTemp[i]).append(str);
					str = "<div class='has-feedback bgWhite'><div class='text-left'>" + year + "-" + mon + "-" + arrTemp[i] + "</div><span class='glyphicon glyphicon-remove form-control-feedback small-icon' data-arrmore='hide" + i + "'></span></div>";
					$("#day" + arrTemp[i]).append("<div id='hide" + i + "' class='hide'>" + str + arrMore[i] + "</div>");
				}
				
				// 툴팁 사용하기 위함
				$('[data-toggle="tooltip"]').tooltip();
			},
			error : function(request, status, error) {
				alert("스케줄읽어오기 에러 list search fail :: error code: "
						+ request.status + "\n" + "error message: "
						+ error + "\n");
			}
		});
	}
	
	function readSchedule(params) {		
		$.ajax({
			url: "/schedule/readSchedule",
			dataType: "json",
			type: "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			beforeSend : function() {
				$("#num_up").empty();
				$("#subject_up").empty();
			    $("#writer_up").empty();
			    $("#startDate_up").empty();
			    $("#endDate_up").empty();
			    $("#memo_up").empty();
			},
			success: function(data) {			    
			    $("#num_up").val(data.num);
			    $("#subject_up").val(data.subject);
			    $("#writer_up").val(data.writer);
			    $("#startDate_up").val(data.startDate);
			    $("#endDate_up").val(data.endDate);
			    $("#memo_up").text(data.memo);
			},
			error: function(request, status, error) {
				alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
			}
		});
	}
	
	function updateSchedule(params) {		
		$.ajax({
			url: "/schedule/updateSchedule",
			dataType: "json",
			type: "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			beforeSend : function() {
				 $("#subject_up").empty();
			     $("#writer_up").empty();
			     $("#startDate_up").empty();
			     $("#endDate_up").empty();
			     $("#memo_up").empty();
			},
			success: function(data) {	    
				if (data == 1) {
					window.location = "/schedule/scheduleList?num=" + $("#num").val();
				}
				else if (data != 1) {
					alert("수정을 실패하였습니다.");
				}
			},   
			error: function(request, status, error) {
				alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
			}
		});
	}
	
	function deleteSchedule() {
	
		var params = {
			param : $("#num_up").val()
		}
		
		$.ajax({
			url: "/schedule/deleteSchedule",
			dataType: "json",
			type: "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			beforeSend : function() {
	
			},
			success: function(data) {			     
			    if (Number(data) == 1) {
			    	window.location = "/schedule/scheduleList?num=" + $("#num").val();
			    } 
			    else if (Number(data) != 1) {
			    	alert("일정 삭제를 실패하였습니다.");
			    }
			},
			error: function(request, status, error) {
				alert("list search fail :: error code: " + request.status + "\n" + "error message: " + error + "\n");
			}
		});
	}
</script>

</head>
<body>
	<div id="wrap">

	<%-- 	<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">상세 일정</h4>
					</div>

					<div class="modal-body">
						<form>
							<c:choose>
								<c:when test="${userId != null}">
									<div class="form-group">
										<input type="hidden"
											class="form-control" id="num_up" name="num"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label for="title">일정명</label> <input type="text"
											class="form-control" id="subject_up" name="subject">
									</div>
									<div class="form-group">
										<label for="writer">작성자</label> <input type="text"
											class="form-control" id="writer_up" name="writer"
											readonly="readonly" value="${userId}"> 
									</div>
									<div class="form-group">
										<label for="startDate1">시작일</label> <input type="text"
											class="form-control" id="startDate_up" name="startDate">
									</div>
									<div class="form-group">
										<label for="endDate1">종료일</label> <input type="text"
											class="form-control" id="endDate_up" name="endDate">
									</div>
									<div class="form-group">
										<label for="title">상세내용</label>
										<textarea class="form-control" id="memo_up" name="memo">
										</textarea>
									</div>
								</c:when>
								<c:otherwise>
									<div class="form-group">
										<input type="hidden"
											class="form-control" id="num_up" name="num"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label for="title">일정명</label> <input type="text"
											class="form-control" id="subject_up" name="subject"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label for="writer">작성자</label> <input type="text"
											class="form-control" id="writer_up" name="writer"
											readonly="readonly" value="${userId}"> 
									</div>
									<div class="form-group">
										<label for="startDate1">시작일</label> <input type="text"
											class="form-control" id="startDate_up" name="startDate"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label for="endDate1">종료일</label> <input type="text"
											class="form-control" id="endDate_up" name="endDate"
											readonly="readonly">
									</div>
									<div class="form-group">
										<label for="title">상세내용</label>
										<textarea class="form-control" id="memo_up" name="memo"
											readonly="readonly">
										</textarea>
									</div>
								</c:otherwise>
							</c:choose>
						</form>
					</div>

					<div class="modal-footer">
						<c:choose>
							<c:when test="${userId != null}">
								<button type="button" id="updateSchedule" class="btn btn-default">수정</button>
								<button type="button" id="deleteSchedule" class="btn btn-default">삭제</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</c:otherwise>
						</c:choose>
						
					</div>
				</div>

			</div>
		</div> --%>

		<!-- content 시작 -->
		<div id="content">

			<div id="title">
				<h3>개인 일정을 추가하거나 수정 할 수 있습니다.
				</h3>
			</div>

			<div>
				<!-- 좌측매뉴 -->
				<div id="leftMenu" class="col-md-3">
					<div id="leftTop">
						<h4>
							<label>일정 등록</label>
						</h4>
						<!-- <button type="button" class="btn btn-warning pull-right"
							data-toggle="modal" data-backdrop="static"
							data-target="#departmentModal">관리</button> -->
					</div>
					<div id="leftBottom">
						<form id="scheduleInsertForm" action="/schedule/insertSchedule" method="post">
							<input type="hidden" id="writer" name="writer" value="${member.userId}">
							<div class="form-group">
								<label for="scheduleTitle1">제목</label> 
								<input type="text" class="form-control" id="subject" name="subject" placeholder="제목">
							</div>
					
							<div class="form-group">
								<label for="scheduleStart1">시작일</label>
								<div>
									<input type="date" id="startYMD"  class="form-control" />
								</div>
								<div>
									<select id="startHour" class="sceduleSelect">
										<option value="00">00</option>
									</select>시
									<select id="startMin" class="sceduleSelect">
										<option value="00">00</option>
									</select>분
								</div>
								<input type="hidden" id="startDate" name="startDate" />
							</div>
							
							<div class="form-group">
								<label for="scheduleEnd1">종료일</label>
								<div>
									<input type="date" id="endYMD" class="form-control" />
								</div>
								<div>
									<select id="endHour" class="sceduleSelect">
										<option value="00">00</option>
									</select>시
									<select id="endMin" class="sceduleSelect">
										<option value="00">00</option>
									</select>분
								</div>
								<input type="hidden" id="endDate" name="endDate" />
							</div>
							
							<div class="form-group">
								<label for="scheduleContent1">내용</label> 
								<textarea id="memo" name="memo" class="form-control" rows="7"></textarea>
							</div>
							
							<button type="button" id="scheduleInsert" class="form-control btn-success">등록</button>
						</form>
					</div>
				</div>

				<div id="rightMenu" class="col-md-9">
					<div id="rightTop">
						<div class="col-md-4 text-right">
							<span id="preYear" class="glyphicon glyphicon-backward"></span>
							<span id="preMonth" class="glyphicon glyphicon-chevron-left"></span>
						</div>
						<div class="col-md-4 text-center">
							<h3 id="toYearMonth">2017년　3월</h3>
						</div>
						<div class="col-md-4 text-left">
							<span id="nextMonth" class="glyphicon glyphicon-chevron-right"></span>
							<span id="nextYear" class="glyphicon glyphicon-forward"></span>
						</div>						
					</div>
					<div id="rightBottom">
						<div>
							　
						</div>
						<div class="table">
							<table id="calendar" class="table table-bordered">
								<colgroup>
									<col width="14.28%" />
									<col width="14.28%" />
									<col width="14.28%" />
									<col width="14.28%" />
									<col width="14.28%" />
									<col width="14.28%" />
									<col width="14.28%" />
								</colgroup>
								<thead>
									<tr class="active">
										<th class="text-center font-red">일</th>
										<th class="text-center">월</th>
										<th class="text-center">화</th>
										<th class="text-center">수</th>
										<th class="text-center">목</th>
										<th class="text-center">금</th>
										<th class="text-center font-blue">토</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- content 종료 -->


	</div>
</body>
</html>
