Parse.$ = jQuery

Parse.initialize("t8Gakff8gWaH61w70kV8Rm2rhCENgRhk5yhzAjmP", "Jm1tzCy9Pae3v0wfjMtAGiwfYzAkWo8DJfLxrckr");

window.App = {}

App.Language = Parse.Object.extend("Language", {})
App.Languages = Parse.Collection.extend(
  comparator: (object) -> object.get("name")
)

App.Code = Parse.Object.extend("Code", {})
App.Codes = Parse.Collection.extend({})


class App.LoadingView extends Backbone.View
  template: -> _.template($('#loading').text())

  render: ->
    @$el.html(@template())
    @

class App.SubmitView extends Backbone.View
  template: -> _.template($('#submit-form').text())

  events:
    'submit form': 'submit'
    'fileselect #file': 'selectedFile'

  render: ->
    @$el.html(@template())
    selectEl = @languageSelect()
    @disableButton()
    @collection.forEach (language) ->
      optionEl = $("<option>")
      optionEl.val(language.id)
      optionEl.text(language.get('name'))
      selectEl.append(optionEl)
    @

  selectedFile: (ev, numFiles, label) ->
    @$el.find('.filenames').val(label)
    fileEl = @fileInput().get(0)
    if fileEl.files.length > 0
      file = fileEl.files[0]
      parseFile = new Parse.File('code.zip', file)
      @model.set('zipfile', parseFile)
      @enableButton()

  submit: (ev)->
    ev.preventDefault()
    id = @languageSelect().val()
    language = @collection.get(id)
    relation = @model.relation('language')
    relation.add(language)

    @disableButton()
    @showSavingLabel()
    @model.save({},
      success: =>
        @showSavedLabel()
        @enableButton()
    )


  languageSelect: ->
    @$el.find('#language')

  fileInput: ->
    @$el.find('#file')

  button: ->
    @$el.find('button')

  disableButton: ->
    @button().attr('disabled','disabled')

  enableButton: ->
    @button().attr('disabled', false)

  showSavingLabel: ->
    @$('.saving-label').removeClass('hidden')
    @$('.saved-label').addClass('hidden')

  showSavedLabel: ->
    @$('.saving-label').addClass('hidden')
    @$('.saved-label').removeClass('hidden')

class Layout
  constructor: ->
    @$el = $('.body')

  show: (view) ->
    @currentView.remove() if @currentView
    @$el.html(view.render().$el)
    @currentView = view

class SubmitController
  constructor: ->
    @languages = new App.Languages()
    @languages.query = new Parse.Query(App.Language);

    @model = new App.Code()

    @languages.fetch(
      success: =>
        view = new App.SubmitView(
          model: @model,
          collection: @languages
        )
        App.layout.show(view)
    )

#App.codes = new App.Codes()
#App.codes.query = new Parse.Query(App.Code);
#
#App.codes.fetch()
#
#App.codes.pluck("language")
#
#
#App.allLanguages = new App.Languages()
#App.allLanguages
#
#App.allLanguages.fetch()
#
#console.log App.allLanguages.pluck("name")

$(document).on 'ready', ->
  App.layout = new Layout()
  App.layout.show(new App.LoadingView())
  controller = new SubmitController()


