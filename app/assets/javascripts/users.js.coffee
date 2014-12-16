jQuery ->
  length_check = (target, min, max) ->
    if $(target).val()? and $(target).val()?
      $(target).parent().addClass('has-error').removeClass('has-success') unless $(target).val().length in [min..max]
      $(target).parent().removeClass('has-error').addClass('has-success') if $(target).val().length in [min..max]

  email_check = (email) ->
    regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
    regex.test email

  description_label = (description_remaining) ->
    $('label#description_feedback').html 'Description' + ' (' + description_remaining + ' characters remaining)' if $('label#description_feedback').html?

  descriptions = '#job_description, #contractor_description'
  addresses = '#user_address, #contractor_address'
  emails = '#user_email, #contractor_email'
  passwords = '#user_password, #contractor_password, #new_password'
  password_confirms = '#user_password_confirmation, #contractor_password_confirmation, #new_password_confirmation'

  length_check(descriptions, 10, 2000)
  length_check('#job_title', 5, 50)
  length_check(addresses, 10, 100)
  length_check(emails, 5, 30)
  length_check('#user_password, #contractor_password', 8, 128)
  length_check('#user_password_confirmation, #contractor_password_confirmation', 8, 128)

  text_remaining = 2000 - $(descriptions).val().length if $(descriptions).val()?
  description_label(text_remaining)

  $(descriptions).keyup ->
    text_remaining = 2000 - $(descriptions).val().length
    description_label(text_remaining)
    length_check(descriptions, 10, 2000)

  $('#job_title').keyup ->
    length_check('#job_title', 5, 50)

  $(addresses).keyup ->
    length_check(addresses, 10, 100)

  $(emails).keyup ->
    if email_check $(emails).val()
      length_check(emails, 5, 30)
    else
      length_check(emails, 998, 999)

  $(passwords).keyup ->
    length_check(passwords, 8, 128)

  $('#current_password').keyup ->
    length_check('#current_password', 8, 128)

  $(password_confirms).keyup ->
    if $(password_confirms).val() == $(passwords).val()
      length_check(password_confirms, 8, 128)
    else
      length_check(password_confirms, 998, 999)
