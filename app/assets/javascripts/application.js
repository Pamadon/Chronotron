// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var modal = document.getElementById('hpmodal');
var btn = document.getElementById('modalbtn');
var span = document.getElementsByClassName('close')[0];

btn.onclick = function() {
	modal.style.display = "block";
};
span.onclick = function() {
	modal.style.display = "none";
};
window.onclick = function(event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
};
$(document).ready(function(){
  console.log('spinnaaa');
    $(".spinner").hide();

})


