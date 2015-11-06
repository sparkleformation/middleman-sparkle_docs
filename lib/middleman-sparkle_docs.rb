# Require core library
require 'middleman-core'

# Sparkle docs extention
class SparkleDocs < ::Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super
    require 'fileutils'
  end

  def after_configuration
    %w(sfn sparkle_formation).each do |item|
      Dir.glob(File.join(app.config[:source], 'docs', item, '**', '**', '*.{md,png}')).each do |doc_item|
        relative_path = doc_item.sub(File.join(app.config[:source], 'docs', ''), '')
        FileUtils.rm(doc_item)
      end
    end
    %w(sfn sparkle_formation).each do |item|
      doc_path = File.join(Gem::Specification.find_by_name(item).full_gem_path, 'docs')
      Dir.glob(File.join(doc_path, '**', '**', '*.{md,png}')).each do |doc_item|
        next if doc_item.end_with?('README.md')
        relative_path = doc_item.sub(doc_path, '').sub(/^\//, '')
        destination_path = File.join(app.config[:source], 'docs', item, relative_path)
        FileUtils.mkdir_p(File.dirname(destination_path))
        if(doc_item.end_with?('.md'))
          content = File.read(doc_item).gsub('.md', '.html')
          File.write(destination_path, content)
        else
          FileUtils.cp(doc_item, destination_path)
        end
      end
    end
  end

end

SparkleDocs.register(:sparkle_docs)
