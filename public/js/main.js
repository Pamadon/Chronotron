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
function createRadios(index) {
  var radioList = $('<ul>');
  var item;
  var input = '';
  for (var i = 0; i < questions[index].choices.length; i++) {
    item = $('<li>');
    input = '<input type="radio" name="answer" value=' + i + ' />';
    input += questions[index].choices[i];
    item.append(input);
    radioList.append(item);
  }
  return radioList;
}
