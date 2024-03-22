part of 'home_imports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyles.appBarTitle(),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _homeController.getExpenses();
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                CategoryWiseGraph(exapanses: _homeController.categoryWiseData),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Category Wise",
                        style:
                            TextStyles.mediumText(fontWeight: FontWeight.w700),
                      )),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return expenseTile(
                      title: _homeController.categories[index],
                      subTitle:
                          "${_homeController.categoryWiseData[_homeController.categories[index]]?.$1 ?? 0} times",
                      amount: _homeController
                              .categoryWiseData[
                                  _homeController.categories[index]]
                              ?.$2 ??
                          0.0,
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: Image.asset(
                          _homeController.categoryImgs[index],
                          height: 25,
                          width: 25,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemCount: _homeController.categories.length,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "All Expenses",
                        style:
                            TextStyles.mediumText(fontWeight: FontWeight.w700),
                      )),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    ExpenseModel data = _homeController.expenses[index];
                    return expenseTile(
                      title: data.title ?? '',
                      subTitle: data.createdAt == null
                          ? ''
                          : DateFormat('hh:mm a | dd MMM yyyy')
                              .format(DateTime.parse(data.createdAt!)),
                      amount: data.amount ?? 0.0,
                      tag: data.category,
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemCount: _homeController.expenses.length,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addExpense(
            save: () {
              _homeController.saveNewExpense();
            },
          );
        },
      ),
    );
  }

  Widget expenseTile(
      {required String title,
      required String subTitle,
      required double amount,
      String? tag,
      Widget? leading}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: AppColors.grey.withOpacity(0.5), blurRadius: 20),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leading ??
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    shape: BoxShape.circle),
                child: Text(
                  title[0].toUpperCase(),
                  style: TextStyles.mediumText(
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary.withOpacity(0.7)),
                ),
              ),
          const SizedBox(width: 8),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles.normalText(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subTitle.toUpperCase(),
                      style: TextStyles.smallText(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${amount.toStringAsFixed(1)}",
                    style: TextStyles.mediumText(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  tag == null
                      ? const SizedBox.shrink()
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            tag,
                            style: TextStyles.smallText(),
                          ),
                        ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  addExpense({required Function save}) {
    double space = 8;
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      barrierColor: AppColors.black.withOpacity(0.3),
      backgroundColor: AppColors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 14,
              bottom: (MediaQuery.of(Get.context!).viewInsets.bottom ?? 0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Add Expense',
                style: TextStyles.largText(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: space),
              CommonWidgets.input(
                  input: _homeController.title, hint: "Enter title"),
              SizedBox(height: space),
              CommonWidgets.input(
                  input: _homeController.amount,
                  hint: "Enter amount",
                  keyboardType: TextInputType.number),
              SizedBox(height: space),
              Obx(
                () => CommonWidgets.dropdown(
                  items: _homeController.categories,
                  value: _homeController.category.value,
                  onChanged: (v) {
                    _homeController.category.value = v ?? '';
                  },
                ),
              ),
              SizedBox(height: space),

              /// Add
              CommonWidgets.button(
                title: "Save",
                onClick: () => save(),
              ),
              SizedBox(height: space * 2),
            ],
          ),
        );
      },
    );
  }
}
