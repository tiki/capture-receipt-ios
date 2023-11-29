//
//  JSSurvey.swift
//  Plugin
//
//  Created by Michael Audi on 10/13/23.
//  Copyright © 2023 Max Lynch. All rights reserved.
//

import Foundation
import BlinkReceipt
import BlinkEReceipt


/**
 Represents a response containing survey information.

 This struct is used to convey details about a survey, including its dates, questions, and rewards.
 */
public struct JSSurvey: Encodable {
    /// The slug associated with the survey.
    private let slug: String?
    /// The reward value associated with the survey (float formated to 2 decimals)
    private let rewardValue: String?
    /// The start date of the survey (ISO8601).
    private let startDate: String?
    /// The end date of the survey (ISO8601).
    private let endDate: String?
    /// The list of survey questions.
    private let questions: [JSSurveyQuestion]

    /**
     Initializes an `RspShipment` struct.

     - Parameters:
        - shipment: The shipment information.
     */
    init(survey: BRSurvey) {
        slug = survey.slug
        rewardValue = String(format:"%.2f", survey.rewardValue)
        startDate = survey.startDate != nil ? survey.startDate!.ISOStringFromDate() : nil
        endDate = survey.endDate != nil ? survey.endDate!.ISOStringFromDate() : nil
        questions = survey.questions.map { question in JSSurveyQuestion(surveyQuestion: question) }
    }
    
    static func opt(survey: BRSurvey?) -> JSSurvey? {
        return survey != nil ? JSSurvey(survey: survey!) : nil
    }

}
