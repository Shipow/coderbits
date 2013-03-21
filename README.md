# coderbits

[![Dependency Status](https://gemnasium.com/artemeff/coderbits.png)](https://gemnasium.com/artemeff/coderbits)

Simple wrapper for the Coderbits API

### Install

    gem install coderbits

### Usage

```ruby
require 'coderbits'

# Create sprite image with css code for earned badges
Coderbits.glue('artemeff').run!
Coderbits.glue('artemeff', glue_options).run!

# Get user info
Codebits.get 'artemeff'
```

### Options

_glue_options_:

```ruby
:badge_size     # badges size for download
:save_to        # path for files
:layout         # horizontal, vertical or packed
:style          # css, scss or sass
:library        # rmagick or chunkypng
:selector       # selector
:padding        # add padding to each sprite
:margin         # add margin to each sprite
:nocomments     # suppress generation of comments in output stylesheet
:output_image   # output location for generated image
:output_style   # output location for generated stylesheet
:width          # fix width of each sprite to a specific size
:height         # fix height of each sprite to a specific size
```

### Copyright

Copyright (c) 2012 Yuri Artemev. See LICENSE.txt for further details.
