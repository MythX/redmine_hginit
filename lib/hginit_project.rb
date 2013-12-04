require_dependency 'hginit_mercurial'

module HgInit
module ProjectPatch
  
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      after_create :init_repository
    end  
  end  
  
  module ClassMethods
  end
  
  module InstanceMethods
    
    def init_repository
      repo = HgInit::MercurialWithInit.new
      repo.url = Setting[:plugin_redmine_hginit][:repo_dir] + \
      "/#{identifier}"
      repo.root_url = repo.url
      repo.init
      repo.get_scm.project = self
      repo.get_scm.save!
    end
    
  end
end
end
