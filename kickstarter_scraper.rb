# require libraries/modules here
require 'nokogiri'
require 'open-uri'
#require 'pry'


def create_project_hash
  # write your code here
  kickstarter = Nokogiri::HTML(open('./fixtures/kickstarter.html'))

  project_hash = {}

  all_projects = kickstarter.css("section #projects")
  individual_projects = all_projects.css("div .project-card")

  individual_projects.each do |project|
    
    info_hash = {}

    title = project.children.css(".bbcard_name strong").children.children.text.strip()

    info_hash[:image_link] = project.children.css(".project-thumbnail a img").attribute("src").value
    info_hash[:description] = project.children.css(".bbcard_blurb").children.text.strip()
    info_hash[:location] = project.children.css(".project-meta li a .location-name").children.text.strip()
    info_hash[:percent_funded] = project.children.css("[class='first funded'] strong").children.text.strip().chomp("%").to_i

    project_hash[title] = info_hash
  end

  project_hash
end


create_project_hash