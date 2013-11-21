module Sinatra
  module Resources
    [:get, :post, :put, :delete, :patch, :link, :unlink, :head, :options].each do |meth|
      class_eval <<-EndMeth
        def #{meth}(path=nil, options={}, &block)
          super(make_path(path), options, &block)
        end
      EndMeth
    end

    # Define a new resource block.  Resources can be nested of arbitrary depth.
    def resource(path, &block)
      raise "Resource path cannot be nil" if path.nil?
      (@path_parts ||= []) << path
      block.call
      @path_parts.pop
    end

    # Shortcut for "resource ':id'".
    def member(&block)
      raise "Nested member do..end must be within resource do..end" if @path_parts.nil? || @path_parts.empty?
      resource(':id', &block)
    end

    def make_path(path)
      return path if path.is_a?(Regexp) || @path_parts.nil? || @path_parts.empty?
      path = path.to_s if path.is_a?(Symbol)
      route = @path_parts.join('/')
      route += '/' + path if path
      '/' + route.squeeze('/')
    end
  end
  
  register Resources
end