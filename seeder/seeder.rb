require 'uri'

headers = {

    'Host'=>'www.google.com',
    'User-Agent'=>'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:64.0) Gecko/20100101 Firefox/64.0',
    'Accept'=>'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language'=>'fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3',
    'Accept-Encoding'=>'gzip, deflate, br',
    'DNT'=>'1',
    'Connection'=>'keep-alive',
    'Upgrade-Insecure-Requests'=>'1'

}
pages << {
    page_type: 'products_listing',
    method: 'GET',
    url: "https://www.google.com/search?q=Holiday+Inn+Birmingham+Airport%2C+5000+Richard+Arrington+Jr+Blvd+N%2C+Birmingham%2C+AL",
    ua_type: "gb2",
    headers:headers
}