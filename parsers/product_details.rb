data = JSON.parse(content)['catalogEntryView'].first
if data
  id = data['p']
  title = data['n']
  category = 'Energy Drinks'
  brand = data['m']
  description = data['l6'].gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, '') rescue ''
  image_url = 'https://shop.coles.com.au' + data['t']
  star_rating = ''
  number_of_reviews = ''
  price = data['p1']['o']
  is_available = '1'

  promotion_text =
      if data['p1']['l4']
        'Save $' + (data['p1']['l4'].to_f - price.to_f).round(2).to_s
      else
        ''
      end

  [
      /(\d*[\.,]?\d+)\s?([Ff][Ll]\.?\s?[Oo][Zz])/,
      /(\d*[\.,]?\d+)\s?([Oo][Zz])/,
      /(\d*[\.,]?\d+)\s?([Ff][Oo])/,
      /(\d*[\.,]?\d+)\s?([Ee][Aa])/,
      /(\d*[\.,]?\d+)\s?([Ff][Zz])/,
      /(\d*[\.,]?\d+)\s?(Fluid Ounces?)/,
      /(\d*[\.,]?\d+)\s?([Oo]unce)/,
      /(\d*[\.,]?\d+)\s?([Mm][Ll])/,
      /(\d*[\.,]?\d+)\s?([Ll])/,
      /(\d*[\.,]?\d+)\s?([Kk][Gg])/,
      /(\d*[\.,]?\d+)\s?([Gg])/,
      /(\d*[\.,]?\d+)\s?([Ll]itre)/,
      /(\d*[\.,]?\d+)\s?([Ss]ervings)/,
      /(\d*[\.,]?\d+)\s?([Pp]acket\(?s?\)?)/,
      /(\d*[\.,]?\d+)\s?([Cc]apsules)/,
      /(\d*[\.,]?\d+)\s?([Tt]ablets)/,
      /(\d*[\.,]?\d+)\s?([Tt]ubes)/,
      /(\d*[\.,]?\d+)\s?([Cc]hews)/
  ].find {|regexp| (title + ' ' + data['a']['O3'].first + ' ' + (data['a']['S5'].first rescue '')) =~ regexp}
  item_size = $1
  uom = $2

  match = [
      /(\d+)\s?[xX]/,
      /Pack of (\d+)/,
      /Box of (\d+)/,
      /Case of (\d+)/,
      /(\d+)\s?[Cc]ount/,
      /(\d+)\s?[Cc][Tt]/,
      /(\d+)[\s-]?[Pp]ack($|[^e])/,
      /(\d+)\s?[Pp][Kk]/
  ].find {|regexp| (title + ' ' + data['a']['O3'].first + ' ' + (data['a']['S5'].first rescue '')) =~ regexp}
  in_pack = match ? $1 : '1'

  info = {
      # - - - - - - - - - - -
      RETAILER_ID: '0017',
      RETAILER_NAME: 'coles',
      GEOGRAPHY_NAME: 'AU',
      # - - - - - - - - - - -
      SCRAPE_INPUT_TYPE: page['vars']['input_type'],
      SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
      SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? category : '-',
      SCRAPE_URL_NBR_PRODUCTS: page['vars']['SCRAPE_URL_NBR_PRODUCTS'],
      # - - - - - - - - - - -
      SCRAPE_URL_NBR_PROD_PG1: page['vars']['SCRAPE_URL_NBR_PRODUCTS'],
      # - - - - - - - - - - -
      PRODUCT_BRAND: brand,
      PRODUCT_RANK: page['vars']['rank'],
      PRODUCT_PAGE: page['vars']['page'],
      PRODUCT_ID: id,
      PRODUCT_NAME: title,
      PRODUCT_DESCRIPTION: description,
      PRODUCT_MAIN_IMAGE_URL: image_url,
      PRODUCT_ITEM_SIZE: (item_size rescue ''),
      PRODUCT_ITEM_SIZE_UOM: (uom rescue ''),
      PRODUCT_ITEM_QTY_IN_PACK: (in_pack rescue ''),
      PRODUCT_STAR_RATING: star_rating,
      PRODUCT_NBR_OF_REVIEWS: number_of_reviews,
      SALES_PRICE: price,
      IS_AVAILABLE: is_available,
      PROMOTION_TEXT: promotion_text,
      EXTRACTED_ON: Time.now.to_s
  }
  product_details['_collection'] = 'products'
  outputs << info

end