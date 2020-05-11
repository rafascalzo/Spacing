//
//  LibrarySearchParameters.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

struct LibrarySearchParameters {
    var authenticated: Bool
    // q (optional) string Free text search terms to compare to all indexed metadata.
    var searchTherm: String?
    // center (optional) string NASA center which published the media.
    var center: String?
    //  description (optional) string Terms to search for in “Description” fields.
    var description: String?
    //  description_508 (optional) string Terms to search for in “508 Description” fields.
    var description508: String?
    //  keywords (optional) string Terms to search for in “Keywords” fields. Separate multiple values with commas.
    var keywords: String?
    //  location (optional) string Terms to search for in “Location” fields.
    var location: String?
    //  media_type (optional) string Media types to restrict the search to. Available types: [“image”, “audio”]. Separate multiple values with commas.
    var mediaType: String?
    // nasa_id (optional) string The media asset’s NASA ID.
    var nasaId: String?
    // page (optional) integer Page number, starting at 1, of results to get.
    var page: Int?
    //  photographer (optional) string The primary photographer’s name.
    var photographer: String?
    //  secondary_creator (optional) string A secondary photographer/videographer’s name.
    var secondaryCreator: String?
    // title (optional) string Terms to search for in “Title” fields.
    var title: String?
    // year_start (optional) string The start year for results. Format: YYYY.
    var yearStart: String?
    // year_end (optional) string The end year for results. Format: YYYY.
    var yearEnd: String?
}
