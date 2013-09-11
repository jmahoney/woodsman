root = exports ? this

root.select_image = ->
  root.open('/admin/images/selector', "image_selector","width=800,height=600x")

root.image_selected = (id, url) ->
  if root.opener
    root.opener.document.getElementById('post_image_id').value = id
    root.opener.document.getElementById('image_thumb').src = url
    root.close()
  else
    alert "no opener!"