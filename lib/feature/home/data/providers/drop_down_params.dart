class DropDownParams {
  final int docId;
  const DropDownParams(this.docId);
  @override
  operator ==(Object other) => other is DropDownParams && other.docId == docId;
  @override
  int get hashCode => docId.hashCode;
}
