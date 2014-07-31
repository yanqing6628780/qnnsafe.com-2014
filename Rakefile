trap("SIGINT") { exit! }

task :default do
  exec 'rake -T'
end

def puts_and_exec command
  puts command
  exec command
end

desc 'Build site (production)'
task :build do
  puts_and_exec 'jekyll build --config _config.yml,_config.production.yml --trace'
end

desc 'Preview and watch changes on local machine (development)'
task :preview do
  puts_and_exec 'jekyll serve --watch --trace'
end

def stores_json
  File.expand_path('../stores.js', __FILE__)
end

# def get_stores
#   require 'json'
#   require 'unicode_utils'
#   require 'fileutils'
#   stores = IO.read(stores_json)
#   stores.gsub!(/(\/\*{js}\*\/).*\1/, '')
#   JSON.parse(stores)
# end

desc 'Convert Excel (.xls) to stores.js'
task :convert do
  xls = File.expand_path('../stores.xls', __FILE__)

  puts "Error: Where is stores.xls ?" and exit unless File.exists?(xls)

  require 'roo'
  excel = Roo::Spreadsheet.open(xls)
  csv = excel.to_csv

  lines = []
  csv.each_line do |line|
    # line.sub!(/.*?,/, '')
    line.sub!(/,$/, '')
    line.gsub!(/"(true|false)"/, '\1')
    line.gsub!(/,(\d+),/, ',"\1",')
    3.times do
      line.gsub!(/,,/, ',"",')
    end
    line.chomp!
    line = "[#{line}]"
    line.sub!(',]', ',false]') # temp fix
    line.sub!('.com"]', '.com",false]') # temp fix
    line = line.reverse.sub('","","', '","').reverse if line.count(',') == 10 # temp fix
    line.sub!('http://www.', '')
    lines << line
  end
  # lines.delete_at(0)
  all_lines = lines.join(",\n")

  # compile
  require 'execjs'
  stores = ExecJS.eval("[\n#{all_lines}\n]")
  stores.delete_at(0)
  new_stores = {}
  stores.each do |store|
    p = store.delete_at(1)
    c = store.delete_at(1)
    new_stores[p] = {} unless new_stores.has_key?(p)
    new_stores[p][c] = [] unless new_stores[p].has_key?(c)
    new_stores[p][c] << store
  end

  require 'json'
  json = JSON.pretty_generate(new_stores)
  store_count = 0
  json.scan(/\s{6}\[[^\]]*\]/).each do |m|
    json.sub!(m, ' ' * 6 + JSON.dump(JSON.parse(m)))
    store_count += 1
  end

  js = "/*{js}*/ window.STORES_COUNT = #{store_count} ; window.STORES = /*{js}*/\n#{json}"
  File.open(stores_json, 'w') do |file|
    file.puts js
  end
end

desc 'generate finder content'
task :nope do
  newa = Dir.glob('products/_posts/*.haml').map do |f|
    File.basename(f).sub(/^\d+\-\d+\-\d+\-/, '').sub(/\.haml$/, '')
  end
  newa.sort.each do |n|
    puts '  .item'
    puts '    %a{ href: "{{ site.www.qnnsafe.com }}/' + n + '.html" }'
    puts '      %img{ src: "{{ site.pimgs }}/' + n + '-01.jpg" }'
    file = Dir.glob('./products/_posts/*' + n + '.haml')
    file = IO.read(file[0])
    puts '      .item_title ' + file[/type:(.*)/, 1].strip + file[/name:(.*)/, 1].strip
  end
end

# desc 'Beautify stores.js'
# task :beautify do
#   stores = get_stores
# 
#   all_widths = stores.map do |store|
#     store.map do |info|
#       UnicodeUtils.display_width(info.to_s)
#     end
#   end
# 
#   # check lengths
#   first_w = 0
#   all_widths.each_index do |i|
#     first_w = all_widths[i].length if i ==0
#     if first_w != all_widths[i].length
#       puts stores[i].inspect
#       exit
#     end
#   end
# 
#   max_widths = all_widths.transpose.map do |width|
#     width.max + 1
#   end
# 
#   count = 0
# 
#   File.open(stores_json + '.new', 'w') do |output|
#     File.open(stores_json).read.each_line do |line|
#       if line =~ /",/
#         line = line.gsub(/",\s*/).with_index do |match, index|
#           '",' + " " * (max_widths[index] - all_widths[count][index])
#         end
#         count += 1
#       end
#       output.puts line
#     end
#   end
# 
#   FileUtils.mv stores_json + '.new', stores_json
# end
# 
# desc 'Make index for stores.js'
# task :make_index do
#   stores = get_stores
#   count = stores.length
#   province = stores[0].index("省份")
#   city = stores[0].index("城市")
#   stores = stores.transpose
#   assoc = {}
#   1.upto(count-1) do |index|
#     _prov = stores[province][index]
#     _city = stores[city][index]
#     assoc[_prov] = [] unless assoc.has_key?(_prov)
#     assoc[_prov] << _city unless assoc[_prov].include?(_city)
#   end
#   assoc.each_value do |a|
#     a.sort! do |x,y|
#       x.encode("GBK", "utf-8") <=> y.encode("GBK", "utf-8")
#     end
#   end
#   puts "index ="
#   assoc.keys.sort do |x,y|
#     x.encode("GBK", "utf-8") <=> y.encode("GBK", "utf-8")
#   end.each do |key|
#     puts "  \"#{key}\": " + assoc[key].to_s
#   end
# end
# 
# desc 'Copy old product details'
# task :copy_old do
#   require 'yaml'
#   old = File.expand_path('../products/_posts_old/', __FILE__)
#   current = File.expand_path('../products/_posts/', __FILE__)
#   Dir.chdir(old)
#   Dir.entries('.').each do |entry|
#     if File.file?(entry)
#       file = IO.read(entry)
#       yaml = YAML.load(file)
#       current_file = File.join(current, entry.sub(/\.md$/, '.haml'))
#       if File.exists?(current_file)
#         new_content = IO.read(current_file)
#         new_content = YAML.load(new_content)
#         new_content["images"] = yaml["images"]
#         new_content["features"] = yaml["features"].gsub(/\s*?\n/, "\n")
#         new_content["spec_details"] = yaml["spec_details"].gsub(/\s*?\n/, "\n")
#         new_content["manual"] = yaml["manual"].gsub(/\s*?\n/, "\n")
#         new_content = new_content.to_yaml.gsub(/^(type|specs):\s/, "\n\\1: ")
#         new_content.gsub!(/^(images):\s/, "\n\\1:\n")
#         new_content.gsub!(/^(features|spec_details|manual):\s\|$/, "\n\\1: |")
#         new_content = "#{new_content}\n---\n"
#         File.open(current_file, 'w') do |file|
#           file.write new_content
#         end
#       end
#     end
#   end
# end
# 
# desc 'Convert Markdown News to Haml News'
# task :md2haml do
#   require 'maruku'
#   require 'html2haml'
#   require 'fileutils'
#   news = File.expand_path('../news/', __FILE__)
#   Dir.chdir(news)
#   sep = "\n---\n"
#   markdowns = Dir.glob('**/*.md')
#   markdowns.each do |markdown|
#     file = IO.read(markdown)
#     file = file.split(sep)
#     head = file[0]
#     body = file[1]
#     html = Maruku.new(body).to_html
#     haml = Html2haml::HTML.new(html, {ruby19_style_attributes: true}).to_haml
#     new_body = head + sep + haml
#     File.open(markdown, 'w') do |file|
#       file.write new_body
#     end
#     FileUtils.mv markdown, markdown.sub(/.md$/,'.haml')
#   end
# end
