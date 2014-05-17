module Sinatra
  module Resources
    [:get, :post, :put, :delete].each do |meth|
      class_eval <<-EndMeth
        def #{meth}(path=nil, options={}, &block)
          super(make_path(path), make_options(options), &block)
        end
      EndMeth
    end

    # Define a new resource block.  Resources can be nested of arbitrary depth.
    def resource(path, options = {}, &block)
      raise "Resource path cannot be nil" if path.nil?
      (@path_parts ||= []) << path
      (@path_options ||= []) << options
      block.call
      @path_parts.pop
      @path_options.pop
    end

    # Shortcut for "resource ':id'".
    def member(options = {}, &block)
      raise "Nested member do..end must be within resource do..end" if @path_parts.nil? || @path_parts.empty?
      resource(':id', options, &block)
    end

    def make_path(path)
      return path if path.is_a?(Regexp) || @path_parts.nil? || @path_parts.empty?
      path = path.to_s if path.is_a?(Symbol)
      route = @path_parts.join('/')
      route += '/' + path if path
      '/' + route.squeeze('/')
    end

    def make_options(options)
      (@path_options || []).reverse.inject({}) do |option, collected_options|
        collected_options.update(option)
        collected_options
      end.update(options)
    end
  end
  
  register Resources
end
