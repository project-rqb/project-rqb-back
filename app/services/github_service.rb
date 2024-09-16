require 'faraday'

class GithubService
  GITHUB_API_URL = 'https://api.github.com'.freeze

  def self.check_org_membership(username)
    response = client.get("/orgs/runteq/members/#{username}")
    response.status == 204
  rescue Faraday::Error => e
    Rails.logger.error("GitHub API リクエストエラー: #{e.message}")
    false
  end

  private

  def self.client
    @client ||= Faraday.new(GITHUB_API_URL) do |conn|
      conn.headers['Authorization'] = "Bearer #{ENV['GITHUB_ACCESS_TOKEN']}"
    end
  end
end
