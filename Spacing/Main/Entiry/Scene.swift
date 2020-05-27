//
//  Scene.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

enum SceneCase {
    case PICTURE_OF_THE_DAY, MARS, EXOPLANET, IMAGE_AND_VIDEO_LIBRARY, EPIC, EARTH
}

struct Scene {
    
    var title: String
    var scene: SceneCase
    var imageName: String
}
