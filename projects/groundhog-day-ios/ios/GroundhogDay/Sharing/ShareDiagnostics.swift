#if DEBUG
import UIKit

enum SharePayloadVariant: String, CaseIterable, Identifiable {
    case imageAndText
    case imageOnly
    case textOnly
    case pngFileAndText
    case pngFileOnly

    var id: String { rawValue }

    var title: String {
        switch self {
        case .imageAndText: "Image + Text"
        case .imageOnly: "Image Only"
        case .textOnly: "Text Only"
        case .pngFileAndText: "PNG File + Text"
        case .pngFileOnly: "PNG File Only"
        }
    }
}

enum ShareTemporaryPNG {
    static func write(image: UIImage, dayNumber: Int) throws -> URL {
        AppLog.sharing.debug("PNG encoding started day=\(dayNumber, privacy: .public)")

        guard let data = image.pngData() else {
            AppLog.sharing.error("PNG encoding failed day=\(dayNumber, privacy: .public)")
            throw ShareTemporaryPNGError.encodingFailed
        }

        AppLog.sharing.debug("PNG encoding succeeded bytes=\(data.count, privacy: .public)")

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("groundhog-day-\(String(format: "%04d", min(max(1, dayNumber), 9999))).png")

        if FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.removeItem(at: url)
        }

        do {
            try data.write(to: url, options: .atomic)
            AppLog.sharing.debug("PNG temporary file written bytes=\(data.count, privacy: .public)")
            return url
        } catch {
            let nsError = error as NSError
            AppLog.sharing.error(
                "PNG file write failed domain=\(nsError.domain, privacy: .public) code=\(nsError.code, privacy: .public)"
            )
            throw error
        }
    }

    static func remove(_ url: URL?) {
        guard let url else { return }
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
                AppLog.sharing.debug("PNG temporary file removed")
            }
        } catch {
            let nsError = error as NSError
            AppLog.sharing.warning(
                "PNG temporary file cleanup failed domain=\(nsError.domain, privacy: .public) code=\(nsError.code, privacy: .public)"
            )
        }
    }
}

private enum ShareTemporaryPNGError: Error {
    case encodingFailed
}

enum SharePayloadBuilder {
    static func items(
        variant: SharePayloadVariant,
        image: UIImage,
        draft: String,
        temporaryPNGURL: URL?
    ) -> [Any] {
        switch variant {
        case .imageAndText:
            return [image, draft]
        case .imageOnly:
            return [image]
        case .textOnly:
            return [draft]
        case .pngFileAndText:
            if let temporaryPNGURL {
                return [temporaryPNGURL, draft]
            }
            return [draft]
        case .pngFileOnly:
            if let temporaryPNGURL {
                return [temporaryPNGURL]
            }
            return []
        }
    }

    static func runtimeTypeDescription(for items: [Any]) -> String {
        items.map { String(describing: type(of: $0)) }.joined(separator: ",")
    }
}
#endif
