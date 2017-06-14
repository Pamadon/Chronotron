var questions = (JSON.parse(gon.trivia)).results;
var counter = 0;
var quiz = $('#quiz');
var selection = "";
var score = 0;

//Submit button functionality
$('#submit').on('click', function (e) {
  e.preventDefault();

  if (selection === "") {
  	$('#errMsg').remove();
  	quiz.append($('<h3 id="errMsg">Please make a selection</h3>'));
  } else {
  	$('#next').show();
	  $('#submit').hide();

	  choose();
	  changeScore(counter);
	  displayAnswer();
  }
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

  var displayScore = $('<span>Score: ' + score + '</span>');
  qElement.append(displayScore);

  var header = $('<h2>Question ' + (index + 1) + ':</h2>');
  qElement.append(header);

  var category = $('<h4>Category: ' + questions[index].category + '</h4>');
  qElement.append(category);

  var difficulty = $('<h4>Difficulty: ' + questions[index].difficulty + '</h4>');
  qElement.append(difficulty);

  var question = $('<p>').append(questions[index].question);
  qElement.append(question);

  var radios = createRadios(index);
  qElement.append(radios);

  return qElement;
}

//Creates and returns a divs with the answer options as radio inputs
function createRadios(index) {
	var radioList =$('<ul>');
	var item;
	var input = '';
	var label = '';
	var choices = [];

	choices.push(questions[index].correct_answer);
	questions[index].incorrect_answers.forEach(function(answer) {
		choices.push(answer);
	});

	shuffle(choices);

	choices.forEach(function(option) {
     item = $('<li>');
     input = '<input type="radio" id="' + option + '" name="answer" value="' + option + '" />';
     label = '<label for="' + option + '" >' + option + '</label>';
     item.append(input);
     item.append(label);
     radioList.append(item);
  });

  return radioList;
}

//Shuffle the choices so the answer isn't always in the same spot
function shuffle(array) {
	var index = array.length;
	var randomIndex;
	var temp;

	while (0 !== index) {
		randomIndex = Math.floor(Math.random() * index);
		index -= 1;

		temp = array[index];
		array[index] = array[randomIndex];
		array[randomIndex] = temp;
	}

	return array;
}

//Creates and returns a div with "Correct"/"Wrong"
function createAnswerElement(index) {
  var aElement = $('<div>', {
    id: 'answer'
  });

  var correct = $('<h3>Correct!</h3>');
  var wrong = $('<h3>Wrong!  Answer: '+ questions[index].correct_answer + '</h3>');

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

//Update a user's score, based on question difficulty
function changeScore(index) {
	if (selection === questions[index].correct_answer) {
    if (questions[index].difficulty === "easy") {
 			score += 100;
    } else if (questions[index].difficulty === "medium") {
    	score += 250;
    } else if (questions[index].difficulty === "hard") {
    	score += 500;
    }
  }
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
