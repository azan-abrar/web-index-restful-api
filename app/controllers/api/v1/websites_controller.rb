module Api::V1
  class WebsitesController < ApiController
    require 'nokogiri'
    require 'mechanize'
    require 'uri'

    def index
      @websites = Website.all
      if @websites.present?
        render json: @websites
      else
        render json: { error: "No record found", status: 200 }, status: 200
      end
    end

    def parse
      if params[:url].present? && (params[:url] =~ URI::regexp)
        @website = Website.find_by(url: params[:url])
        if @website.blank?
          agent = Mechanize.new
          page = agent.get(params[:url])
          h1_tags = page.search('h1').map{|p| p.content }
          h2_tags = page.search('h2').map{|p| p.content }
          h3_tags = page.search('h3').map{|p| p.content }
          links = page.search('a').map{|p| p['href']}.reject{|p| p !~ URI::regexp}

          @website = Website.create(url: params[:url])
          mass_insert(h1_tags, @website.id, 'h1') if h1_tags.present?
          mass_insert(h2_tags, @website.id, 'h2') if h2_tags.present?
          mass_insert(h3_tags, @website.id, 'h3') if h3_tags.present?
          mass_insert(links, @website.id, 'link') if links.present?
        end
        render json: @website, status: 200
      else
        render json: { error: "Please, provide a valid url param. e.g. http://example.com", status: 400 }, status: :bad_request
      end
    end

    private

    def mass_insert(array, website_id, tag)
      timestamp = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      array_places = array.map{"(?,?,?,?,?)"}.join(', ')
      array_values = []
      array.each do |arr|
        array_values << website_id << tag << arr << timestamp << timestamp
      end
      sql_array = ["INSERT INTO contents (website_id, content_type, content_text, created_at, updated_at) VALUES #{array_places}"] + array_values
      sql = ActiveRecord::Base.send(:sanitize_sql_array, sql_array)
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
