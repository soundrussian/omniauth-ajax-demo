# an empty namespace
App = {}

# class to handle authentication logic
class App.CurrentUser

  constructor: (options) ->

    # saving options
    @options = options

    # setting what to render if user is unauthorized
    $(document).ajaxError (event, xhr) ->
      $('#current_user').html HandlebarsTemplates['sign_in']()

    @_setupProviders()

  # what to render if user is authorized
  display: (user) ->
    $('#current_user').html HandlebarsTemplates['user'](user)

  # get current user from server (should return 401 status if unauthorized)
  fetch: () ->
    $.get '/me', (data) =>
      @display data

  # tell the server to log out current user and then fetch it
  # to have 401 error
  logout: () ->
    $.get '/signout', =>
      @fetch()

  # for each passed provider add event handler with id 'sing-in-provider'
  _setupProviders: ->
    @options.providers.forEach (provider) =>
      $(document).on 'click', "#sign-in-#{provider}", (e) =>

        # when the link is clicked, open a window with onmiauth link
        @auth_window = @_openWindow("/auth/#{provider}", "Connect to MySite", 800, 600)

        # and check if it is closed every second
        @interval = window.setInterval ( =>

          # if it is, stop checking and fetch current user from server
          if @auth_window.closed
            window.clearInterval @interval
            @fetch()
        ), 1000

        # prevent default click handler
        false

  # open nice centered window
  _openWindow: (url, title, width, height) ->
    left = (screen.width / 2) - (width / 2)
    top = (screen.height / 2) - (height / 2)
    window.open url, title, "location=0,status=0,width=#{width},height=#{height},top=#{top},left=#{left}"



# create current user and pass used providers
App.current_user = new App.CurrentUser providers: ['twitter', 'facebook', 'google_oauth2']


# get user when document loads (this could go to constructor)
$(document).ready ->
  App.current_user.fetch()

# handle clicking sign out link
$(document).on 'click', '#signout', (e) ->
  App.current_user.logout()
  false
