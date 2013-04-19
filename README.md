# alderman-factors

Estimating the poltical structure of the Chicago council from campaign contributions

Summary descriptions of 
* who gets the most money
* distribution of size of donations
* categorizing by industry  

Clustering - do clusters line up with
* voting clusters
* geospatial clusters
* committee appointments
* tenure

# Installation

```bash
git clone git@github.com:DataMade/alderman-factors.git
cd site_template
gem install bundler
bundle
unicorn
```
navigate to http://localhost:8080/

# Caching

This template comes with hooks in to Heroku's memcache plugin for caching pages. To set up memcache on heroku:

```bash
heroku addons:add memcache
```

Then uncomment this line in application.rb

```bash
cache_control :public, max_age: 1800  # 30 min
```

# Dependencies

* [Ruby 1.9.3](http://www.ruby-lang.org/en/downloads)
* [Sinatra](http://www.sinatrarb.com)
* [Haml](http://haml.info)
* [Heroku](http://www.heroku.com)
* [Twitter Bootstrap](http://twitter.github.com/bootstrap)
* [Google Analytics](http://www.google.com/analytics)


# Errors / Bugs

If something is not behaving intuitively, it is a bug, and should be reported.
Report it here: https://github.com/DataMade/alderman-factors/issues


# Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Commit and send me a pull request. Bonus points for topic branches.
