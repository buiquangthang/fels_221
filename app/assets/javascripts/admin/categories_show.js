$(document).on('ready page:load', function(event) {
  $(document).on('click', '.show_category .btn-question', function() {
    $('.btn-add-question').attr('disabled', 'disabled');
    $('.validate-alert').hide();
    resetForm();
  });
  $(document).on( 'click', '.show_category a.destroy_duplicate_nested_form', function(){
    $(this).prev('.valueDestroy').val('true');
    $(this).closest('.duplicatable_nested_form').slideUp().remove();
    alert($(this).closest('.duplicatable_nested_form').find(".content_show_question").val());
    setLableCorrect();
    showAlertModal();
    setLableNumber();
  });
  $(document).on('click', '.show_category .duplicate_nested_form', function(e){
    if($('.show_category .duplicatable_nested_form').length > 0){
      numberFormLast = $('.show_category .duplicatable_nested_form:last-child .valueINumberForm').val();
      numberForm = parseInt(numberFormLast) + 1;
    }else{
      numberForm = 0;
    }
    newNestedForm = '<div class = "duplicatable_nested_form col-md-8 col-md-offset-2">';
    newNestedForm += '<label for = "question_answers_attributes_' + numberForm + '_content">Content</label><br>';
    newNestedForm += '<input type = "text" name = "question[answers_attributes][' + numberForm + '][content]" id = "question_answers_attributes_' + numberForm + '_content" class = "form-control" required = "true">';
    newNestedForm += '<input class = "valueIsCorrect" type = "hidden" name = "question[answers_attributes][' + numberForm + '][is_correct]" id = "question_answers_attributes_' + numberForm + '_is_correct" value = "false">';
    newNestedForm += '<input class = "valueDestroy" type = "hidden" value = "false" name = "question[answers_attributes][' + numberForm + '][_destroy]" id = "question_answers_attributes_' + numberForm + '__destroy">';
    newNestedForm += '<input class = "valueINumberForm" type = "hidden" name = "numberForm" value = "' + numberForm + '">';
    newNestedForm += '<a class = "destroy_duplicate_nested_form btn btn-danger" href = "javascript:void(0)">Remove</a></div>';
    $('.show_category #areaAnswer').append(newNestedForm);
    showAlertModal();
    setLableCorrect();
    setLableNumber();
  });
  $(document).on('click', '.show_category .btn-add-question', function(e){
    formsOnPage = $('.show_category .duplicatable_nested_form').length;
    if(formsOnPage > 0){
      $('.show_category .duplicatable_nested_form:first-child .valueIsCorrect').val('true');
    }
  });
  $(document).on('click', '.show_category .pagination a', function (event) {
    event.preventDefault();
    $.getScript($(this).attr('href'));
    return false;
  });
  $(document).on('keyup', '.show_category #categories_search input', function (event) {
    $.get($('.show_category #categories_search').attr('action'), $('.show_category #categories_search').serialize(), null, 'script');
    return false;
  });

  function resetForm(){
    $('.show_category .form-control').val(' ');
    $('.show_category #areaAnswer').html(' ');
  }
  function showAlertModal(){
    formsOnPage = $('.show_category .duplicatable_nested_form').length;
    if(formsOnPage > 0){
      $('.show_category .validate-alert').slideUp(50);
      $('.show_category .btn-add-question').removeAttr('disabled', 'disabled');
    }else{
      $('.show_category .btn-add-question').attr('disabled', 'disabled');
      $('.show_category .validate-alert').slideDown(50);
    }
    $('.show_category .number-answers').html('Answer('+formsOnPage+')');
  }
  function setLableCorrect(){
    formsOnPage = $('.show_category .duplicatable_nested_form').length;
    if(formsOnPage > 0){
      if($('.show_category .lableCorrect').length == 0){
        $('.show_category .duplicatable_nested_form:first-child label').after('<p class = "lableCorrect">Please enter correct answer at here</p>');
      }
    }
  }
  function setLableNumber(){
    formsOnPage = $('.show_category .duplicatable_nested_form').length;
    $('.show_category .duplicatable_nested_form label').html(' ');
    for(i=1; i <= formsOnPage; i++){
      $('.show_category .duplicatable_nested_form:nth-child(' + i + ') label').html('Answer '+i);
    }
  }
});
