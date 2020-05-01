require "nokogiri"
require "pry"


def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  project_hash = {}

  projects = kickstarter.css("#projects_list .project.grid_4")

  projects.each do |project|
    title = project.css(".bbcard_name a").text
    project_hash[title] = {
      :image_link => project.css(".project-thumbnail img").attribute("src").text,
      :location => project.css(".project-meta .location-name").text,
      :description => project.css(".bbcard_blurb").text,
      :percent_funded => project.css(".project-stats .first.funded strong").text.gsub("%", "").to_i
    }
  end

  project_hash
end

# test = create_project_hash
# binding.pry
# 0