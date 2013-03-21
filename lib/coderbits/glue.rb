require 'sprite_factory'
require 'faraday'

module Coderbits
  class Glue
    # valid options
    OPTIONS = [
      :badge_size, :save_to, :layout, :style, :library, :selector,
      :padding, :margin, :nocomments, :output_image, :output_style,
      :width, :height
    ]

    def initialize username, options = {}
      safe options
      @username = username
    end

    def run!
      imgs = download_images
      css  = merge_images
      html = generate_html

      {
        images: imgs,
        css: css,
        html: html
      }
    end

    def download_images
      # get user data
      data = Coderbits::Client.new.get @username

      # collect images
      images = data[:badges].select{ |b| b[:earned] }.map { |b| b[:image_link].match(/(.*)\/(.*)/)[2] }.uniq

      # get connection
      connection = Coderbits::Client.new.connection

      # create directory
      Dir.mkdir @options[:save_to] unless Dir.exists? @options[:save_to]
      Dir.mkdir "#{@options[:save_to]}/badges" unless Dir.exists? "#{@options[:save_to]}/badges"

      # download images
      images.each do |img|
        unless @options[:badge_size] == 64
          # parse image name
          eimg = img.match /(.+)-(\d+).png/
          
          # build with :badge_size
          img = "#{eimg[1]}-#{@options[:badge_size]}.png"
        end
        
        # download image
        response = connection.get("https://coderbits.com/images/badges/#{img}")
        
        # save to disk
        if response.headers["content-type"] == "image/png"
          File.open("#{@options[:save_to]}/badges/#{img}", 'wb') { |f| f.write response.body }
        end
      end
    end

    def merge_images
      SpriteFactory.run! "#{@options[:save_to]}/badges",
        css_engine: @options[:css_engine],
        selector: 'span.icon_',
        output_image: "#{@options[:save_to]}/out.png",
        output_style: "#{@options[:save_to]}/out.css",
        nocomments: true
    end

    def generate_html
      nil # coming soon
    end

    def safe options
      # 
      options = options.select { |k, v| OPTIONS.include? k }

      dflt = {
        badge_size: 64,          # badges size for download
        save_to: './',           # path for files

        layout: 'packed',        # horizontal, vertical or packed
        style: 'css',            # css, scss or sass
        library: 'chunkypng',    # rmagick or chunkypng
        selector: 'span.badge_', # selector
        padding: 0,              # add padding to each sprite
        margin: 0,               # add margin to each sprite
        nocomments: true         # suppress generation of comments in output stylesheet
      }

      dflt[:output_image] = "#{dflt[:save_to]}/badges.png" # output location for generated image
      dflt[:output_style] = "#{dflt[:save_to]}/badges.css" # output location for generated stylesheet
      dflt[:width]  = dflt[:badge_size] # fix width of each sprite to a specific size
      dflt[:height] = dflt[:badge_size] # fix height of each sprite to a specific size

      @options = dflt.merge options
    end
  end
end