# README

The API have two endpoints:

1. Parsing page's content (H1, H2, H3 tags, links) and storing it in the database using the endpoint: http://localhost:3000/api/v1/websites/parse
  - required params (valid url) e.g. ?url=https://www.example.com

2. Displaying all the previous stored/parsed URL's on this endpoint: http://localhost:3000/api/v1/websites

The api has been designed with versioning in mind for scalibility purposes.

The website url is stored in the websites table and the page's (H1, H2, H3 tags and links) are stored in the contents table and are linked with the corresponding website.

The json output is customized to display desired columns in the api endpoint output, rather than displaying all the columns.

Test cases has been added using rspec.

# web-index-restful-api
