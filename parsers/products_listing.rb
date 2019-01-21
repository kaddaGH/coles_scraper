body = Nokogiri.HTML(content)
json = body.at_css('div[data-colrs-transformer="colrsExpandFilter"]').text
data = JSON.parse(json)
scrape_url_nbr_products = data['searchInfo']['totalCount']
products = data['products']
products.each_with_index do |product, i|
  options = {
      'input_type' => page['vars']['input_type'],
      'search_term' => page['vars']['search_term'],
      'SCRAPE_URL_NBR_PRODUCTS' => scrape_url_nbr_products,
      'rank' => i + 1,
      'page' => page['vars']['page']
  }

  pages << {
      page_type: 'product_details',
      method: 'GET',
      url: "https://shop.coles.com.au/search/resources/store/20601/productview/bySeoUrlKeyword/" + product['s'],
      ua_type: "gb2",
      vars: options

  }
end