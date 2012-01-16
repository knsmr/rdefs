# Rdefs

Rdefs is a tiny Ruby script that extracts class, module, method, attribute definitions from a given Ruby source code. It helps you to take a quick look at the structure of the source code. Rdefs is different from document generation tools like RDoc, SDoc, YARD because those tools are meant to extract APIs and the description for each API.

Rdefs was originally written by Aoki Minero many years ago, and later gemified by Ken Nishimura.

## Install

	   $ gem install rdefs

## Example

	$ rdefs active_record/session_store.rb
	module ActiveRecord
	  class SessionStore < ActionDispatch::Session::AbstractStore
	    module ClassMethods # :nodoc:
	      def marshal(data)
	      def unmarshal(data)
	      def drop_table!
	      def create_table!
	    class Session < ActiveRecord::Base
	      class << self
	        def data_column_size_limit
	        def find_by_session_id(session_id)
	        private
	          def session_id_column
	          def setup_sessid_compatibility!
	              def self.find_by_session_id(*args)
	              class << self; remove_method :find_by_session_id; end
	              def self.find_by_session_id(session_id)
	      def initialize(attributes = nil, options = {})
	      def data
	      attr_writer :data
	      def loaded?
	      private
	        def marshal_data!
	        def raise_on_session_data_overflow!
	    class SqlBypass
	      class << self
	        alias :data_column_name :data_column
	        attr_writer :connection
	        attr_writer :connection_pool
	        def connection
	        def connection_pool
	        def find_by_session_id(session_id)
	      attr_reader :session_id, :new_record
	      alias :new_record? :new_record
	      attr_writer :data
	      def initialize(attributes)
	      def data
	      def loaded?
	      def save
	      def destroy
	    private
	      def get_session(env, sid)
	      def set_session(env, sid, session_data, options)
	      def destroy_session(env, session_id, options)
	      def get_session_model(env, sid)
	      def find_session(id)

## Help

	rdefs --help
	rdefs [-n] [file...]
	        --class                      Show only classes and modules
	    -n, --lineno                     Prints line number.
	        --help                       Prints this message and quit.

# Use Rdefs with Emacs

You might want to put etc/rdefs.el into your elisp directory and add something like this to your dot.emacs:

	(require 'rvm)
	(rvm-use-default)
	(require 'rdefs)
