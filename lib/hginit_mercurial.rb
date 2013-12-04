module HgInit
class MercurialWithInit 
  unloadable

  def initialize( scm = nil )
    if scm.nil?
      @scm = Repository::Mercurial.new
    else
      @scm = scm
    end
  end

  def url
    @scm.url
  end

  def root_url
    @scm.root_url
  end

  def url= val
    @scm.url = val 
  end

  def root_url= val
    @scm.root_url = val
  end

  def init
    %x{hg init #{@scm.root_url}}
    open(@scm.root_url + '/.hg/hgrc', 'w') {|f| 
        #f.write "[web]\nstyle = gitweb\nallow_push = *\npush_ssl = false\n"
        #f.write "[trusted]\nusers = www-data\n" 
        f.write Setting[:plugin_redmine_hginit][:hgrc_content]
        f.write "\n"
    }
    %x{chgrp -R repo #{@scm.root_url}}
    %x{sudo chown -R www-data #{@scm.root_url}}
    %x{touch /opt/hg/hgwebdir.wsgi}
    %x{touch /opt/hg-test/hgwebdir.wsgi}
    %x{touch /opt/hg-old/hgwebdir.wsgi}
  end
  
  def remove
    script = Setting[:plugin_redmine_hginit][:del_script]
    %x{#{script} #{@scm.root_url}}
  end

  def get_scm
    @scm
  end
  
end
end
