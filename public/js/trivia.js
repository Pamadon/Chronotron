var questions = (JSON.parse(gon.trivia)).results;
var counter = 0;
var quiz = $('#quiz');
var selection = "";
var numCorrect = 0;
var score = 0;

//Submit button functionality
$('#submit').on('click', function (e) {
  e.preventDefault();

  choose();
  $('#errMsg').remove();

  if (selection === undefined) {
  	quiz.append($('<h3 id="errMsg">Please make a selection</h3>'));
  } else {
  	$('#next').show();
	  $('#submit').hide();
	  $('#related-videos').remove();


	  var vids = getRelatedVideos();
	  $('#trivia-videos').append(vids);

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

//More! button functionality
$('#more').on('click', function (e) {
	e.preventDefault();

	$.ajax({
		url: 'https://opentdb.com/api.php?',
		data:{
			amount: gon.amount,
			category: gon.category,
			difficulty: gon.difficulty
		},
		success: function(data) {
			var moreQuestions = data.results;

			moreQuestions.forEach(function(q) {
				questions.push(q);
			});

			$('#end-screen').remove();
			displayNext();
		}
	})
});

// Creates and returns the div that contains the questions and
// the answer selections
function createQuestionElement(index) {
  var qElement = $('<div>', {
    id: 'question'
  });

  var qElementA = $('<div>', {
    id: 'question-data'
  });

  var header = $('<h3>Question ' + (index + 1) + ' of ' + questions.length + '</h3>');
  qElementA.append(header);

  var question = $('<p>').append(questions[index].question);
  qElementA.append(question);

  var radios = createRadios(index);
  qElementA.append(radios);

  var qElementB = $('<div>', {
    id: 'question-cat'
  });

  var category = $('<h4>Category:</h4>' + '<p>' + questions[index].category + '</p>');
  qElementB.append(category);

  var difficulty = $('<h4>Difficulty:</h4>' + '<p>' + questions[index].difficulty + '</p>');
  qElementB.append(difficulty);

  var displayScore = $('<h4>Score:</h4> ' + '<p>' + score + '</p>');
  qElementB.append(displayScore);

  qElement.append(qElementA).append(qElementB);

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

  var correct = $('<h4>Correct!</h4>');
  var wrong = $('<h4>Wrong! The correct answer was: '+ questions[index].correct_answer + '</h4>');

  if (selection === questions[index].correct_answer) {
  	aElement.append(correct);
  	numCorrect++;
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
  $('#more').hide();
  $('#submit').show();
  $('#answer').remove();
  $('#question').remove();

  if(counter < questions.length){
    var nextQuestion = createQuestionElement(counter);
    quiz.append(nextQuestion);
  } else {
  	$('#question').remove();

  	var endScreen = displayEndScreen();
  	quiz.append(endScreen);
  }
}

//Save user's answer
function choose() {
  selection = $('input[name="answer"]:checked').val();
}

//Creates and returns a div with user's score and replay options
function displayEndScreen() {
	var eElement = $('<div>', {
    id: 'end-screen'
  });

	var complete = $('<h3>Quiz Complete! You answered ' + numCorrect + '/' + questions.length + 'correctly!</h2>');
  eElement.append(complete);

  var showScore = $('<h3>You got a score of ' + score + '!</h3>');
  eElement.append(showScore);

  var moreMsg = $('<p>Need to waste more time?  Get more questions!</p>');
  eElement.append(moreMsg);

  $('#more').show();

  return eElement;
}

//Creates and returns a div with videos related to current question's answer
function getRelatedVideos() {
	var vElement = $('<div>', {
		id: 'related-videos'
	});

	$.ajax({
		type: 'GET',
		url: 'https://www.googleapis.com/youtube/v3/search?',
		dataType: 'json',
		data: {
			part: 'snippet',
      maxResults: '3',
      order: 'relevance',
      q: 'history' + questions[counter].correct_answer,
      type: 'video',
      videoDuration: 'any',
      videoEmbeddable: 'true',
      key: 'AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM'
    },
		success: function(data) {
			data.items.forEach(function(video) {
 			vElement.append($('<iframe id="ytplayer" class="trivia-vids" type="text/html" width="31%" height="150" src="https://www.youtube.com/embed/' + video.id.videoId + '?autoplay=0&origin=http://example.com" frameborder="0"></iframe>')
 			)});
		}
	});

	return vElement;
}

displayNext();
