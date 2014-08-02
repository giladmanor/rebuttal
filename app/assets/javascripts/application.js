// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {
	$(".statements").on('mousewheel', function(event) {
		console.log(event.deltaX, event.deltaY, event.deltaFactor);
		if (event.deltaY < 0) {
			goPrev();
		}
		if (event.deltaY > 0) {
			goNext();
		}

	});
});

var goPrev = function() {//back in rank
	send("view_prev",{rank:window.currentlyViewed},function(res){
		console.log(res);
		$("#statementContainer").animate({
			top:"-1000px"
		},500,function(){
			$("#statementContainer").html(res);
			$("body").css("overflow","hidden");
			$("#statementContainer").css("top",1000);
			$("#statementContainer").animate({
			top:"0"
			},500, function(){
				$("body").css("overflow","auto");
			});
		});
		
		
	});
};

var goNext = function() {//Forward in rank
	send("view_next",{rank:window.currentlyViewed},function(res){
		console.log(res);
		$("#statementContainer").animate({
			top:"1000px"
		},500,function(){
			$("#statementContainer").html(res);
			$("body").css("overflow","hidden");
			$("#statementContainer").css("top","-1000px");
			$("#statementContainer").animate({
			top:"0"
			},500, function(){
				$("body").css("overflow","auto");
			});
		});
	});
};

var send = function(action, data, successFunc) {
	$.ajax({
		type : "POST",
		url : "/" + action,
		data : data,
		success : function(res) {
			if (successFunc != null) {
				successFunc(res);
			}
		},
		error : function(err) {
			console.log("ERROR: ", err);
		}
	});
};
