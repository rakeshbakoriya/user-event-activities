#!/usr/bin/ruby
require 'rest-client'
require 'json'

class UserScore

	def user_events
		puts "Enter Github User Name"
		user_name =  gets 
		user_name = user_name.chomp
		url = "https://api.github.com/users/#{user_name}/received_events/public"
		response  = RestClient::Request.execute(url: url, method: :get)
		response_data = JSON.parse(response.body)
		find_events(response_data)
	end

	def find_events(response_data)
		issues_event = response_data.count { |h| h["type"] == 'IssuesEvent' }
		issue_comment_event = response_data.count { |h| h["type"] == 'IssueCommentEvent' }
		push_event = response_data.count { |h| h["type"] == 'PushEvent' }
		pull_request_review_comment_event = response_data.count { |h| h["type"] == 'PullRequestReviewCommentEvent' }
		watch_event = response_data.count { |h| h["type"] == 'WatchEvent' }
		create_event = response_data.count { |h| h["type"] == 'CreateEvent' }
		pull_request_event = response_data.count { |h| h["type"] == 'PullRequestEvent' }
		delete_event = response_data.count { |h| h["type"] == 'DeleteEvent' }
		show_user_enents(issues_event, issue_comment_event, push_event, pull_request_review_comment_event, watch_event, create_event, pull_request_event, delete_event)
	end

	def show_user_enents(issues_event, issue_comment_event, push_event, pull_request_review_comment_event, watch_event, create_event, pull_request_event, delete_event)
		puts "IssuesEvent #{issues_event}"
		puts "IssueCommentEvent #{issue_comment_event}" 
		puts "PushEvent #{push_event}"
		puts "PullRequestReviewCommentEvent #{pull_request_review_comment_event}"
		puts "WatchEvent #{watch_event}"
		puts "CreateEvent #{create_event}"
		puts "PullRequestEvent #{pull_request_event}"
		puts "DeleteEvent #{delete_event}"
	end
end 


obj = UserScore.new
obj.user_events