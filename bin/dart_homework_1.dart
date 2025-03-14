import 'dart:io';

// 상품 클래스
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

// 쇼핑몰 클래스
class ShoppingMall {
  List<Product> products;
  Map<Product, int> cart = {};
  int total = 0;

  ShoppingMall(this.products);

  // 1. 상품 목록 출력
  void showProducts() {
    print("\n--- 판매하는 상품 목록 ---");
    for (var product in products) {
      print("${product.name} / ${product.price}원");
    }
  }

  // 2. 상품을 장바구니에 담기
  void addToCart() {
    print("\n장바구니에 담을 상품명을 입력하세요:");
    String? productName = stdin.readLineSync();

    print("구매할 개수를 입력하세요:");
    String? quantityInput = stdin.readLineSync();

    // 입력값 검증
    if (productName == null || quantityInput == null) {
      print("입력값이 올바르지 않아요 !");
      return;
    }

    int quantity;
    try {
      quantity = int.parse(quantityInput);
    } catch (e) {
      print("입력값이 올바르지 않아요 !");
      return;
    }

    if (quantity <= 0) {
      print("0개보다 많은 개수의 상품만 담을 수 있어요 !");
      return;
    }

    // 상품 찾기
    Product? selectedProduct = products.firstWhere(
      (p) => p.name == productName,
      orElse: () => Product("", 0),
    );

    if (selectedProduct.name.isEmpty) {
      print("입력값이 올바르지 않아요 !");
      return;
    }

    // 장바구니에 추가
    if (cart.containsKey(selectedProduct)) {
      cart[selectedProduct] = cart[selectedProduct]! + quantity;
    } else {
      cart[selectedProduct] = quantity;
    }
    total += selectedProduct.price * quantity;

    print("장바구니에 상품이 담겼어요 !");
  }

  // 3. 장바구니에 담긴 총 가격 출력
  void showTotal() {
    if (cart.isEmpty) {
      print("\n장바구니에 담긴 상품이 없습니다.");
      return;
    }

    String cartItems = cart.keys.map((p) => p.name).join(", ");
    print("\n장바구니에 $cartItems이(가) 담겨있네요. 총 ${total}원 입니다!");
  }

  // 4. 프로그램 종료 확인
  bool confirmExit() {
    print("\n정말 종료하시겠습니까? (5 입력 시 종료)");
    String? input = stdin.readLineSync();
    if (input == "5") {
      print("이용해 주셔서 감사합니다 ~ 안녕히 가세요 !");
      return true;
    } else {
      print("종료하지 않습니다.");
      return false;
    }
  }

  // 6. 장바구니 초기화 기능
  void clearCart() {
    if (cart.isEmpty) {
      print("\n이미 장바구니가 비어있습니다.");
    } else {
      cart.clear();
      total = 0;
      print("\n장바구니를 초기화합니다.");
    }
  }
}

void main() {
  ShoppingMall shoppingMall = ShoppingMall([
    Product("셔츠", 45000),
    Product("원피스", 30000),
    Product("반팔티", 35000),
    Product("반바지", 38000),
    Product("양말", 5000),
  ]);

  bool running = true;

  while (running) {
    print("\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품 목록 & 총 가격 보기");
    print("[4] 프로그램 종료 / [6] 장바구니 초기화");
    print("원하는 기능의 번호를 입력하세요:");

    String? input = stdin.readLineSync();

    switch (input) {
      case "1":
        shoppingMall.showProducts();
        break;
      case "2":
        shoppingMall.addToCart();
        break;
      case "3":
        shoppingMall.showTotal();
        break;
      case "4":
        running = !shoppingMall.confirmExit();
        break;
      case "6":
        shoppingMall.clearCart();
        break;
      default:
        print("지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..");
    }
  }
}
