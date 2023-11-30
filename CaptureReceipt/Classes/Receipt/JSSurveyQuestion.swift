/*
 * RspSurveyQuestion Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt


/**
 Represents a response containing survey question details.

 This struct is used to convey survey question details including text, type, answers, multipleAnswers flag, and user response.
 */
struct JSSurveyQuestion: Encodable{
    /// The text of the survey question.
    private let text: String?
    /// The type of the survey question.
    private let type: String?
    /// The list of survey answers associated with the question.
    private let answers: [JSSurveyAnswer]
    /// A boolean flag indicating whether multiple answers are allowed.
    private let multipleAnswers: Bool
    /// The user's response to the survey question.
    private let userResponse: JSSurveyResponse?

    /**
     Initializes an `RspSurveyQuestion` struct.

     - Parameters:
        - surveyQuestion: The survey question containing text, type, answers, multipleAnswers flag, and user response.
     */
    init(surveyQuestion: BRSurveyQuestion) {
        text = surveyQuestion.text
        type = String(describing: surveyQuestion.type)
        answers = surveyQuestion.answers.map { answer in JSSurveyAnswer(surveyAnswer: answer) }
        multipleAnswers = surveyQuestion.multipleAnswers
        userResponse = JSSurveyResponse.opt(surveyResponse: surveyQuestion.userResponse)
    }
    
    static func opt(surveyQuestion: BRSurveyQuestion?) -> JSSurveyQuestion? {
        return surveyQuestion != nil ? JSSurveyQuestion(surveyQuestion: surveyQuestion!) : nil
    }

}
