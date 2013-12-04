require_dependency 'hginit_mercurial'

module HgInit
module RepositoryPatch
  
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      before_destroy :remove_repository
    end  
  end  
  
  module ClassMethods
  end
  
  module InstanceMethods
    
    def remove_repository
      repo = HgInit::MercurialWithInit.new self
      repo.remove
    end
          
  end
end
end