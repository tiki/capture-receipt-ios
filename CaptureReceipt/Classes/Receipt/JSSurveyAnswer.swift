/*
 * RspSurveyAnswer Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing survey answer details.

 This struct is used to convey survey answer details including text and description.
 */
struct JSSurveyAnswer: Encodable {
    /// The text of the survey answer.
    private let text: String?

    /**
     Initializes an `RspSurveyAnswer` struct.

     - Parameters:
        - surveyAnswer: The survey answer containing text and description.
     */
    init(surveyAnswer: BRSurveyAnswer) {
        text = surveyAnswer.text
    }
    
    static func opt(surveyAnswer: BRSurveyAnswer?) -> JSSurveyAnswer? {
        return surveyAnswer != nil ? JSSurveyAnswer(surveyAnswer: surveyAnswer!) : nil
    }
}
