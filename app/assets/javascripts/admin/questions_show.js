$(document).on('ready page:load', function(event) {
  nestedForm = $('.duplicatable_nested_form_show_question').last().clone()
  setLableNumber();

  $(document).on('click', 'a.destroy_duplicate_nested_form_show-question[disabled!=disabled]', function(){
    $(this).prev().val('true');
    $(this).closest('.duplicatable_nested_form_show_question').slideUp();
    $(this).closest('.duplicatable_nested_form_show_question').find('.content_show_question').removeAttr('required');
    setNumberAnswer();
    setLableNumber();
  });
  $(document).on('click', '.duplicate_nested_form_show_question', function(){
    formsOnPage = $('.duplicatable_nested_form_show_question').length;
    newNestedForm = $(nestedForm).clone();
    $(newNestedForm).find('label').each(function(){
      oldLabel = $(this).attr ('for');
      newLabel = oldLabel.replace(new RegExp(/[0-99]/), formsOnPage);
      $(this).attr ('for', newLabel);
    });
    $(newNestedForm).find('input').each(function(){
      if($(this).attr('class') == 'value_detroy_show_question'){
        $(this).val('false');
      }
      if($(this).attr('class') == 'is_correct_show_question'){
        $(this).val('false');
      }
      if($(this).attr('class') == 'select_answer_input'){
        $(this).removeAttr('checked');
      }

      oldId = $(this).attr ('id');
      newId = oldId.replace(new RegExp(/[0-99]/), formsOnPage);
      $(this).attr ('id', newId);
      oldName = $(this).attr ('name');
      newName = oldName.replace(new RegExp(/\[[0-99]+\]/), '[' + formsOnPage + ']');
      $(this).attr ("name", newName);
    });
    $(newNestedForm).find('.destroy_duplicate_nested_form_show-question').removeAttr('disabled');
    $(newNestedForm).find('.content_show_question').val(' ');
    $('#area_answer').append(newNestedForm);
    $('.duplicatable_nested_form_show_question:last-child .content_show_question').val(null);
    setNumberAnswer();
    setLableNumber();
  });
  $(document).on('click', '.select_answer_input', function(){
    $('.is_correct_show_question').val('false');
    $(this).next().val('true');
    $('.destroy_duplicate_nested_form_show-question').removeAttr('disabled', 'disabled');
    $(this).nextAll('.destroy_duplicate_nested_form_show-question').attr('disabled', 'disabled');
  });
  function setNumberAnswer(){
    numberAnswer = $('.duplicatable_nested_form_show_question:has(.value_detroy_show_question[value = false])').length;
    $('.show-question .number-answers').html('( ' + numberAnswer + ' Answers )');
  }
  function setLableNumber(){
    formsShowOnPage = $('.duplicatable_nested_form_show_question:has(.value_detroy_show_question[value = false])').length;
    $('.duplicatable_nested_form_show_question label:first-child').html(' ');
    for(i = 1; i <=formsShowOnPage; i++){
      $('.duplicatable_nested_form_show_question:has(.value_detroy_show_question[value = false]):nth-of-type(' + i + ') label:first-child').html('Answer ' + i);
    }
  }
});
