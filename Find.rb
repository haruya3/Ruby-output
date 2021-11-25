class Find
    #以下のように、データをクラス(それぞれのインスタンスとして)保存管理できているので、そのクラスのメソッドならデータにアクセスできるのがでかい。
    
      def initialize(search_str: "", base_dir: "", search_depth: 1)
        @search_str = search_str
        @base_dir = base_dir
        @search_depth = search_depth
      end
    
      def do_search
        result = search_dir(current_dir: @base_dir, depth: @search_depth)
        file_path_show(result)
      end
    
      private
    
      def add?(full_path)
        file_name = File.basename(full_path)
        file_name.include?(@search_str)
      end
    
      def search_dir(current_dir: "", depth: 1)
        result = []
        return result if depth == 0
    
        Dir[current_dir + '/*'].each do |current_file|
          if File.directory?(current_file)
            children = search_dir(current_dir: current_file, depth: depth - 1)
            result.concat(children)
          else
            result.push(current_file) if add?(current_file)
          end
        end
        result
      end
    
      def file_path_show(result)
        result.each do |file|
          puts file
        end
      end
end
    