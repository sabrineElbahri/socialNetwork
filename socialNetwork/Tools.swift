//
//  Tools.swift
//  socialNetwork
//
//  Created by Sabrine Elbahri on 19/09/16.
//  Copyright © 2016 3ie. All rights reserved.
//

import Foundation

public class Tools {
    
    private var catalogue: [String: AnyObject]? = nil
    
    public init() {}
    
    
    // https://developers.facebook.com/tools/explorer/ for more request
    
    public func ReadPermissionsCatalogue() -> [String : AnyObject] {
        
        catalogue = ["User Data Permissions":"email, publish_actions, user_about_me, user_birthday, user_education_history, user_friends, user_games_activity, user_hometown, user_likes, user_location, user_photos, user_posts, user_relationship_details, user_relationships, user_religion_politics, user_status, user_tagged_places, user_videos, user_website, user_work_history",
                     "Event, Groups & Pages":"ads_management, ads_read, business_management, manage_pages, pages_manage_cta, pages_manage_instant_articles, pages_messaging, pages_messaging_phone_number, pages_messaging_subscriptions, pages_show_list, publish_pages, read_page_mailboxes, rsvp_event, user_events, user_managed_groups",
                     "Open Graph Actions":"user_actions.books, user_actions.fitness, user_actions.music, user_actions.news, user_actions.video",
                     "Other":"read_audience_network_insights, read_custom_friendlists, read_insights"]
        
        return catalogue!
    }
    
    public func apiGraphNodeMeMoreOftenUsedCatalogue() -> [String : AnyObject] {
        
        catalogue = ["fields":"id, first_name, last_name, email, birthday, picture, gender, education, hometown, devices, interested_in, likes, friends, location, work, name, languages, bio, videos, movies, books, religion, relationship_status, friends, location, cover, political, sports, albums, accounts, achievements, events, family, friendlists, tagged, tagged_places, posts, photos, games, groups"]
        
        return catalogue!
    }
}