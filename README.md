# What's this?

This is an example of using OmniAuth in a single page app to handle authorization through external services. It's far from perfect, just proves the idea.

# And what's the idea?

Well, we had to use some conventions to make it work:

* There should be a route which returns json representation of current user, or 401 error if there's no current user ('/me' in this app).
* We use ```<a>``` tags with ids like ```sign-in-twitter``` or ```sign-in-google_oauth2``` to tell the js code which link should use which provider

The rest is rather simple:

1. Open new window with OmniAuth link for authorization
2. Check every second if it is closed
3. If it is, stop checking and try to fetch current user from the server again

See CurrentUser class in ```current_user.coffee``` file.

Worked like charm! The kudos for the idea should go to [Dave Clark](http://clarkdave.net/2012/10/twitter-oauth-authorisation-in-a-popup/).

We used Handlebars to render two states for authorization (logged in/not logged in), really anything can be used there.

Speaking about kudos, we've used [Web 2.0 icons (colored pen version)](http://iconexpo.com/2009/12/20-free-web-2-0-icons-colored-pen-version/) by [Guiwhan You](https://plus.google.com/u/0/104954698487805861439/posts).

# Making it work

We've also used [figaro gem](https://github.com/laserlemon/figaro) to keep our app's keys. To make it run locally, you'll need to create your own Facebook, Google and Twitter apps, and add their keys to ```config/application.yml```.

Google was particulary a tough nut to make work locally. We made the app [pow](http://pow.cx)'s default app, and added ```omniauth.example.com``` to ```hosts``` file. Even then we had to disable SSL verification in ```config/initializers/omniauth.rb``` file.

# License
The MIT License (MIT)

Copyright (c) 2013 SoundRussian

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

