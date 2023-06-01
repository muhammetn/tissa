//
//  StaticModels.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 28.04.2022.
//

import UIKit

public var scWidth = UIScreen.main.bounds.width
public var widthRatio = UIScreen.main.bounds.width/360

public var lang = UserDefaults.standard.string(forKey: "lang") ?? "ru"

public var host = UserDefaults.standard.string(forKey: "host") ?? "null"


public var url: String?

public var popImage: String?
public var popSrc: String?
