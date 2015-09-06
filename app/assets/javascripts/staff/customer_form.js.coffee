# HTML文書全体の準備が整ったら
$(document).on 'page:change', ->
  # 変更するボタンがクリックされたら
  $('form.edit_form').on 'click', '#enable-password-field', ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#form_customer_password').removeAttr('disabled')
    $('label[for=form_customer_password]').addClass('required')
  # 変更しないボタンがクリックされたら
  $('form.edit_form').on 'click', '#disable-password-field', ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#form_customer_password').attr('disabled', 'disabled')
    $('label[for=form_customer_password]').removeClass('required')

  # 住宅住所を入力するのチェックを設定
  toggle_home_address_fields()
  $('input#form_inputs_home_address').on 'click', ->
    toggle_home_address_fields()

  # 勤務先を入力するのチェックを設定
  toggle_work_address_fields()
  $('input#form_inputs_work_address').on 'click', ->
    toggle_work_address_fields()

toggle_home_address_fields = ->
  checked = $('input#form_inputs_home_address').prop('checked')
  $('fieldset#home-address-fields input').prop('disabled', !checked)
  $('fieldset#home-address-fields select').prop('disabled', !checked)
toggle_work_address_fields = ->
  checked = $('input#form_inputs_work_address').prop('checked')
  $('fieldset#work-address-fields input').prop('disabled', !checked)
  $('fieldset#work-address-fields select').prop('disabled', !checked)
