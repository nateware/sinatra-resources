module Sinatra
  module Resources
    def self.registered(app)
      [:get, :post, :put, :delete].each do |meth|
        # http://whynotwiki.com/Ruby_/_Method_aliasing_and_chaining#Can_you_alias_class_methods.3F
        app.class_eval <<-EndAlias
          class << self
            alias_method :#{meth}_without_resource, :#{meth}
            alias_method :#{meth}, :#{meth}_with_resource
          end
        EndAlias
      end
    end

    [:get, :post, :put, :delete].each do |meth|
      class_eval <<-EndMeth
        def #{meth}_with_resource(path=nil, options={}, &block)
          #{meth}_without_resource(make_path(path), options, &block)
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
      route = @path_parts.join('/')
      route += '/' + path if path
      '/' + route.squeeze('/')
    end
  end
  
  register Resources
end