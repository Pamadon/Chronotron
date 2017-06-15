var currentCategory = gon.choice;


function otherCatgoriesAvailable(currentCategory){
    var otherCategories = [];
    switch (currentCategory){
      case "videos":
        otherCategories = ["trivia", "music", "trails"];
        break;
      case "trivia":
        otherCategories = ["videos", "music", "trails"];
        break;
      case "music":
        otherCategories = ["videos", "trivia", "trails"];
        break;
      case "trails":
        otherCategories = ["videos", "trivia", "music"];
        break;
    }
    return otherCategories;
}


function toggleCategory(){
  currentCategory = this.innerText;
  console.log(currentCategory);
}

$(document).ready(function(){


    var otherCategories = otherCatgoriesAvailable(currentCategory);

    var buttons = $('.choice-buttons');

    buttons.on("click", toggleCategory);




    for (var i=0; i < buttons.length; i++){
      buttons[i].innerText = otherCategories[i];
      console.log(buttons[i]);
    }

});
