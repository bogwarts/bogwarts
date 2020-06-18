module Jekyll
  module Paginate
    class PaginationOverride < Pagination
      # This generator is safe from arbitrary code execution.

      # This generator should be passive with regard to its execution
      priority :highest

      def new_paginate(site, page)
        # all_posts = site.site_payload['site']['posts']
        all_posts = site.static_files.filter_map { |f| f.relative_path if f.path.include?('assets/comics/lowres') }
        all_posts = all_posts.sort_by { |s| s.scan(/\d+/).first.to_i }
        puts(all_posts)
        paginate_array = site.config['paginate_path'].split('/')
        len = paginate_array.length-1
        name = site.config['paginate_path'].split('/')[len-2]
        # if name != nil
        #   all_posts = all_posts.find_all { |p| p['ascription'] == name }
        # else
        #   all_posts = all_posts.reject { |p| p['hidden'] }
        # end

        pages = Pager.calculate_pages(all_posts, site.config['paginate'].to_i)

        (1..pages).reverse_each do |num_page|
          pager = Pager.new(site, num_page, all_posts, pages)
          if num_page != len
            newpage = Page.new(site, site.source, page.dir, page.name)
            newpage.pager = pager
            newpage.dir = Pager.paginate_path(site, num_page)
            site.pages << newpage
          else
            page.pager = pager
          end
        end
      end
      alias_method :paginate, :new_paginate
    end
  end
end
