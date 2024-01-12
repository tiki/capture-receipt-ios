struct PhysicalScanCallbacks{
    let onResult: () -> Void
    var onCancel: () -> Void
    var onError: (Error) -> Void
}
