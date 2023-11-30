/*
 * RspSurveyResponse Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt


/**
 Represents a response containing survey response details.

 This struct is used to convey survey response details including selected answers and free text comments.
 */
struct JSSurveyResponse: Encodable {
    /// The indices of selected answers in the survey.
    let answersSelected: [Decimal]
    /// Free-text comments provided as part of the survey response.
    let freeText: String?

    /**
     Initializes an `RspSurveyResponse` struct.

     - Parameters:
        - answersSelected: The indices of selected answers in the survey.
        - freeText: Free-text comments provided as part of the survey response.
     */
    init(surveyResponse: BRSurveyResponse) {
        self.answersSelected = surveyResponse.answersSelected.map{answersSelected in answersSelected as! Decimal}
        self.freeText = surveyResponse.freeText
    }
    
    static func opt(surveyResponse: BRSurveyResponse?) -> JSSurveyResponse? {
        return surveyResponse != nil ? JSSurveyResponse(surveyResponse: surveyResponse!) : nil
    }

}
