/*
 *
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation

public class ReceiptService{
    
    
    public static func uploadImages(images: [UIImage]) {

        let url = URL(string: "https://postman-echo.com/post")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.timeoutInterval = 30.0
        
        
        let uuid = UUID().uuidString
        let CRLF = "\r\n"
        let filename = uuid + ".png"
        let formName = "file"
        let type = "image/png"     // file type
        let boundary = String(format: "----iOSURLSessionBoundary.%08x%08x", arc4random(), arc4random())
        var body = Data()
        


        // file data //
        body.append(("--\(boundary)" + CRLF).data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"formName\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append(("Content-Type: \(type)" + CRLF + CRLF).data(using: .utf8)!)
        body.append(CRLF.data(using: .utf8)!)
        
        for image in images {
            guard let imageData = UIImagePNGRepresentation(image) else {
                print("oops")
                return
            }
            body.append(imageData as Data)
        }



        // footer //
        body.append(("--\(boundary)--" + CRLF).data(using: .utf8)!)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpBody = body
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            // Handle the server response here
            print(data?.debugDescription)
            print(response.debugDescription)
            print(error.debugDescription)
        }
    }
}
