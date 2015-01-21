require "gemnasium/parser"
require "open-uri"
require "json"

module Gemgrapher
	class Grapher
		def content(string)
		  @content ||= begin
		    indent = string.scan(/^[ \t]*(?=\S)/)
		    n = indent ? indent.size : 0
		    string.gsub(/^[ \t]{#{n}}/, "")
		  end
		end

		def initialize
			@content = content(File.read("Gemfile"))
			@gemfile ||= Gemnasium::Parser::Gemfile.new(@content)
			deps = {}
			point = {}
			p @gemfile.dependencies
			total = @gemfile.dependencies.length
			@data = []
			count = 0
			@gemfile.dependencies.each do |g|
			        response = open("http://rubygems.org/api/v1/gems/#{g.name}.json").read
			        parsed_json = JSON.parse(response)
			        dependencies = parsed_json["dependencies"]["runtime"].to_a
			        deps["#{g.name}"] = dependencies.map{|d| deps["#{d['name']}"] ||= [] ;d["name"]}
			        p "#{count+=1} out of #{total} "
			end
			deps.each do |key, value|
			        @data << {"name" => "root.#{key}", "imports" => value.map{|v| "root.#{v}"}}
			end
			data = File.read(gem_libdir + "/assets/index.html")
			filtered_data = data.gsub("classes = JSON.parse()", "classes = JSON.parse('#{@data.to_json}')")
			File.open("index.html", "w") do |f|
			  f.write(filtered_data)
			end
		end

	    def gem_libdir
	      t = "#{Gem.dir}/gems/gemgrapher-0.0.1/lib"
	    end


	end
end
