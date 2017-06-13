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

  //Submit button functionality
  $('#submit').on('click', function (e) {
    e.preventDefault();

    $('#next').show();
    $('#submit').hide();

    choose();
    displayAnswer();
  });

  //Next button functionality
  $('#next').on('click', function (e) {
    e.preventDefault();

    counter++;
    displayNext();
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

    var true_input = '<input type="radio" id="true" name="answer" value="True" />';
    var true_label = '<label for="true">True</label>';
    var false_input = '<input type="radio" id="false" name="answer" value="False" />';
    var false_label = '<label for="false">False</label>';

    qElement.append(true_input).append(true_label).append(false_input).append(false_label);

      return qElement;
    }
    function createAnswerElement(index) {
    var aElement = $('<div>', {
      id: 'answer'
    });

    var correct = $('<h3>Correct!</h3>');
    var wrong = $('<h3>Wrong!</h3>');

    if (selection === questions[index].correct_answer) {
      aElement.append(correct);
    } else {
      aElement.append(wrong);
    }

    return aElement;
  }

  //Show user if they were right or wrong
  function displayAnswer() {
    var answer = createAnswerElement(counter);
    quiz.append(answer);
  }

  //Show next question
  function displayNext() {
    $('#next').hide();
    $('#submit').show();
    $('#answer').remove();
    $('#question').remove();

    if(counter < questions.length){
      var nextQuestion = createQuestionElement(counter);
      quiz.append(nextQuestion);
    }
  }


  //Save user's answer
  function choose() {
    selection = $('input[name="answer"]:checked').val();
  }

  displayNext();

});
