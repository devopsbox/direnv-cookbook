actions :install

attribute :user, :kind_of => String, :name_attribute => true, :required => true
attribute :shell, :kind_of => String, :default => 'bash'


def initialize(name, run_context=nil)
  super
  @action = :install
end
