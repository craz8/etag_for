# EtagFor

Allow an ActionController action to include CSS, Javascript, View and Layout code as pieces for the calculation of an action's ETAG header.  This allows
browsers to get new responses from the server if the view code that renders the response changes.

## Installation

Add this line to your application's Gemfile:

    gem 'etag_for'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install etag_for

## Usage

Typical etag usage for an Rails controller action looks like this:

```ruby
class FooController < ApplicationController

  def show
    @post = Post.find(params[:id])
    fresh_when :etag => @post, :last_modified => @post.updated_at, :public => true
  end

end
```

This works great, any time the @post object gets updated, the ETag header won't match, and a new response will be generated.

This doesn't catch the case where the view code, **post.html.erb** is updated.  Clients with an existing response, including proxy caches, will never get an
updated response, as the ETag calculation doesn't include this part of the response.

With the provided **etag_for** method, the rendering templates used by your application can be used as part of the ETag calculation.

```ruby
class FooController < ApplicationController

  def show
    @post = Post.find(params[:id])
    fresh_when :etag => etag_for(@post, :layout => 'application.html.erb', :view => 'post/show.html.erb'), :last_modified => @post.updated_at, :public => true
  end

end
```

## etag_for(item_or_items, options = {})

Returns an array of strings that can be used as an input to **fresh_when** and **stale?** to calculate an ETag value for the current request.

### item_or_items parameter

The single item or items array that is the basic data retrieved to be rendered.  In the example below, the index method has an array of posts, and the show method
provides a single post object

```ruby
class PostController < ApplicationController

  def index
    @posts = Post.all
    fresh_when :etag => etag_for(@posts, :layout => 'application.html.erb', :view => 'post/index.html.erb'), :last_modified => @posts.first.updated_at, :public => true
  end

  def show
    @post = Post.find(params[:id])
    fresh_when :etag => etag_for(@post, :layout => 'application.html.erb', :view => 'post/show.html.erb'), :last_modified => @post.updated_at, :public => true
  end

end
```

### options

#### :css

Specifiy the CSS file used by the layout for this action.  The asset pipeline name will be substituted, to get the hash digest of the CSS file as part of the 
ETag

default value if none is specified is **application**.  Supply an empty string for no CSS file.

#### :js

Specifiy the JS file used by the layout for this action.  The asset pipeline name will be substituted, to get the hash digest of the JS file as part of the 
ETag

default value if none is specified is **application**.  Supply an empty string for no JS file.

#### :layout

The name of the layout file used by this action.  An MD5 digest of this file will be part of the ETag calculation

e.g. 'application.html.erb'

#### :view

The path and name of the view file used by this action.  An MD5 digest of this file will be part of the ETag calculation

e.g. 'posts/show.html.erb'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

[<img src="http://d1za39ny3bo0r4.cloudfront.net/assets/craz8-logo-8e807e1c44376d564da419a6d82ec5be.png">](http://craz8.com)

EtagFor is maintained by CRAZ8
