//
//  RemoteImageLoader.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import UIKit

final class RemoteImageLoader {

    static let shared = RemoteImageLoader()

    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cached = cache.object(forKey: url as NSURL) {
            completion(cached)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data, let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async { completion(image) }
        }.resume()
    }
}

private var associatedFlagURLKey: UInt8 = 0

extension UIImageView {

    private var pendingFlagURL: URL? {
        get { objc_getAssociatedObject(self, &associatedFlagURLKey) as? URL }
        set { objc_setAssociatedObject(self, &associatedFlagURLKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    func setFlagImage(from url: URL?) {
        image = nil
        pendingFlagURL = url
        guard let url else { return }

        RemoteImageLoader.shared.loadImage(from: url) { [weak self] downloadedImage in
            guard let self, self.pendingFlagURL == url else { return }
            self.image = downloadedImage
        }
    }
}
