require './lib/headers'
require 'uri'

# 1: Seed taxonomy & search pages
pages << {
    page_type: 'products_listing',
    method: 'GET',
    headers: ReqHeaders::SEARCH_PAGE_HEADER_REQ,
    url: "https://shop.coles.com.au/online/a-national/drinks/soft-drinks-3314551/energy-drinks?tabType=everything&tabId=everything&personaliseSort=false&orderBy=20601_6&errorView=AjaxActionErrorResponse&requesttype=ajax&beginIndex=0",
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}
search_terms = ['Red Bull', 'RedBull', 'Energidryck', 'Energidrycker']
search_terms.each do |search_term|

  pages << {
      page_type: 'products_listing',
      method: 'GET',
      headers: ReqHeaders::SEARCH_PAGE_HEADER_REQ,
      url: "https://shop.coles.com.au/online/COLRSSearchDisplay?storeId=20601&catalogId=10576&searchTerm=#{URI.encode(search_term)}&categoryId=&tabType=everything&tabId=everything&personaliseSort=false&langId=-1&beginIndex=0&browseView=false&facetLimit=100&searchSource=Q&sType=SimpleSearch&resultCatEntryType=2&showResultsPage=true&pageView=image&errorView=AjaxActionErrorResponse&requesttype=ajax",

      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end
