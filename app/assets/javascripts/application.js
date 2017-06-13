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


$(document).ready(function(){
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
});



// Creates and returns the div that contains the questions and
// the answer selections
function createQuestionElement(index) {
  var qElement = $('<div>', {
    id: 'question'
  });

  var header = $('<h2>Question ' + (index + 1) + ':</h2>');
  qElement.append(header);

  var question = $('<p>').append(questions[index].question);
  qElement.append(question);

  var radioButtons = createRadios(index);
  qElement.append(radioButtons);

  return qElement;
}

// Creates a list of the answer choices as radio inputs
// function createRadios(index) {
//   var radioList = $('<ul>');
//   var item;
//   var input = '';
//   for (var i = 0; i < questions[index].choices.length; i++) {
//     item = $('<li>');
//     input = '<input type="radio" name="answer" value=' + i + ' />';
//     input += questions[index].choices[i];
//     item.append(input);
//     radioList.append(item);
//   }
//   return radioList;
// }
