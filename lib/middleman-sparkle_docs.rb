# Require core library
require 'middleman-core'

# Sparkle docs extention
class SparkleDocs < ::Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super
    require 'fileutils'
  end

  def before_build(builder)
    %w(sfn sparkle_formation).each do |item|
      doc_path = File.join(Gem::Specification.find_by_name(item).full_gem_path, 'docs')
      Dir.glob(File.join(doc_path, '**', '**', '*.md')).each do |doc_item|
        next if doc_item.end_with?('README.md')
        relative_path = doc_item.sub(doc_path, '').sub(/^\//, '')
        destination_path = File.join(app.config[:source], 'docs', item, relative_path)
        FileUtils.mkdir_p(File.dirname(destination_path))
        content = File.read(doc_item).gsub('.md', '.html')
        File.write(destination_path, content)
        builder.say_status :import, File.join('docs', item, relative_path) if builder
      end
    end
    # This is a crappy way to make it work, but it makes it work
    app.send(:remove_instance_variable, :@_sitemap)
    app.sitemap
    app.run_hook :ready
  end

  def after_configuration
    %w(sfn sparkle_formation).each do |item|
      doc_path = File.join(Gem::Specification.find_by_name(item).full_gem_path, 'docs')
      Dir.glob(File.join(doc_path, '**', '**', '*.md')).each do |doc_item|
        next if doc_item.end_with?('README.md')
        relative_path = doc_item.sub(doc_path, '').sub(/^\//, '')
        destination_path = File.join(app.config[:source], 'docs', item, relative_path)
        FileUtils.mkdir_p(File.dirname(destination_path))
        content = File.read(doc_item).gsub('.md', '.html')
        File.write(destination_path, content)
      end
    end
  end

  def after_build(builder)
    %w(sfn sparkle_formation).each do |item|
      Dir.glob(File.join(app.config[:source], 'docs', item, '**', '**', '*.md')).each do |doc_item|
        relative_path = doc_item.sub(File.join(app.config[:source], 'docs', ''), '')
        FileUtils.rm(doc_item)
        builder.say_status :scrub, File.join('docs', relative_path), :red
      end
    end
  end

end

SparkleDocs.register(:sparkle_docs)
