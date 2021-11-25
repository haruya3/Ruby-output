require 'FileUtils'
require './Find' #自作クラスをrequireする際は./から始める。requireするプログラムのいるところがカレントディレクトリになっている。
#全角のスペースが入っていたために
#syntax error, unexpected local variable or method, expecting `end'というエラーが起きて悩まされた。
def touch #ルートディレクトリには書き込めない。
    puts "作成するファイルパスを指定してください(作成するファイル名は含めないでください)"
    file_path = gets.chomp
    file_dirname = File.dirname(file_path)
    file_basename = File.basename(file_path)
    if Dir.exist?(file_dirname) #これで、二階層以上のディレクトリでも作成できる
      Dir.mkdir(file_path) unless Dir.exist?(file_basename)
    else
      FileUtils.mkdir_p(file_path) #dirnameの時点でそんざいしていないのであれば、basenameもないので複数階層作成はFileUtilsで
    end
    Dir.chdir(file_path) do #chdirを使いたかったのでパスではなくこっちを使った。ブロックを渡している。
      p Dir.pwd #ブロックを渡すことでブロックの中だけカレントディレクトリがpathになる
      puts "ファイル名を入力してください"
      file_name = gets.chomp
      File.open(file_name, "w") do |f|
        f.write() #ここで、Fileクラスで新規ファイルを作っているがFileUtilsにはtouchメソッドがあるのでそっちを使ってもよい。
      end
    end 
end

def rm
    puts "削除するファイルパスを指定してください"
    file_path = gets.chomp
    unless Dir.exist?(file_path) || File.exist?(file_path)
        puts "そのようなディレクトリまたはファイルは存在しません"
        puts "やり直してください"
        return
    end
    puts "削除するのはfileですか？dirですか？"#ここで、日本語入力させると、when式での判定時にえらーが起きてしまう。
    option = gets.chomp
    p option
    case option
    when "file"
      FileUtils.rm(file_path)
    when "dir"
      FileUtils.rm_r(file_path)
    else
      puts "fileかdirを入力してください"
    end
end

def main
    puts "コマンドを入力してください(Linuxコマンド)"
    command = gets.chomp
    case command
    when "touch"
      touch
    when "rm"
        rm
    when "find"
        puts "検索するもの、探すディレクトリ、探す深さを順に入力してください(この順にスペースを空けて入力してください)"
        find_keywords = gets.chomp.split()
        find = Find.new(search_str: find_keywords[0], base_dir: find_keywords[1], search_depth: find_keywords[2].to_i)
        find.do_search
    end
end

main
