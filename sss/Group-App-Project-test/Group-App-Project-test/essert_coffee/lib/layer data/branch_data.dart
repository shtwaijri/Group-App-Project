class BranchData {
  String? selectedBranchId;
  String branchName() {
    if (selectedBranchId == '1') return 'Ar Rawabi Branch';
    if (selectedBranchId == '2') return 'Hittin Branch';
    return 'No Branch Selected';
  }
}
