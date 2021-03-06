Redmine::Plugin.register :redmine_hginit do
  name 'Redmine Hginit plugin'
  author 'Joffrey DECOURSELLE & Antoine MOSER'
  description 'Call hg init command after project\'s creation'
  version '0.0.1'
  settings :default => {
    :repo_dir => '/var/repo',
    :del_script => '/home/redmine/scripts/remove.sh',
    :http_repo => 'https://forge.univ-lyon1.fr/hg/',
    :hgrc_content => ''
  }
end

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'hginit_project'
  require_dependency 'hginit_repository'
  unless Project.included_modules.include? HgInit::ProjectPatch
    Project.send(:include, HgInit::ProjectPatch)
    Repository.send(:include, HgInit::RepositoryPatch)
  end
end
