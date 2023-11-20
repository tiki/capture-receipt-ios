struct PhysicalScanCallbacks{
    let onResult: (Receipt) -> Void
    var onCancel: () -> Void
    var onError: (Error) -> Void
}
