$(document).ready(function(){

  function update(){
      $('.updateLink').trigger("click", setTimeout(update, 60000));
    }

  update();
});
