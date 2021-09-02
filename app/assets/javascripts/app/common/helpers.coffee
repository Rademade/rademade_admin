window.RademadeAdmin = {
  helpers: {
    stripScripts: (string) ->
      div = document.createElement('div')
      div.innerHTML = string
      scripts = div.getElementsByTagName('script')
      i = scripts.length
      while i--
        scripts[i].parentNode.removeChild scripts[i]
      div.innerHTML
  }
}
