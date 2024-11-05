import 'package:zyra/model/product.dart';

final List<Product> hardcodedProducts = [
  Product(
    id: '1',
    categoryId: 'T-Shirts',
    companyId: 'Nike',
    name: 'Nike Sportswear Club T-Shirt',
    image:
        "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b9cdf024-8ef6-406d-84b1-562f76f6163d/AS+M+NSW+CLUB+TEE.png",
    price: 29,
    stock: 'In Stock',
    sizes: ['S', 'M', 'L', 'XL'],
    description:
        'Classic fit with a soft cotton feel. Perfect for everyday wear.',
  ),
  Product(
    id: '2',
    categoryId: 'Hoodies',
    companyId: 'Adidas',
    name: 'Adidas Originals Trefoil Hoodie',
    image:
        "https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/46856d7a4339450385e9af1200b27f38_9366/TREFOIL_HOODIE_Black_IA4883_01_laydown.jpg",
    price: 60,
    stock: 'Limited Stock',
    sizes: ['M', 'L', 'XL'],
    description:
        'A cozy hoodie made from soft fleece, featuring the iconic Trefoil logo.',
  ),
  Product(
    id: '3',
    categoryId: 'Jeans',
    companyId: 'Levi\'s',
    name: 'Levi\'s 501 Original Fit Jeans',
    image:
        'https://levi.in/cdn/shop/files/005012331_02_Front_066cfeeb-c076-4f31-be5a-ed7b0849cdce.jpg?v=1703571537',
    price: 89,
    stock: 'In Stock',
    sizes: ['28', '30', '32', '34', '36'],
    description:
        'Timeless straight-leg jeans with a classic fit, made from durable denim.',
  ),
  Product(
    id: '4',
    categoryId: 'Jackets',
    companyId: 'The North Face',
    name: 'The North Face Resolve Jacket',
    image:
        'https://assets.thenorthface.com/images/t_img/c_pad,b_white,f_auto,h_1510,w_1300,e_sharpen:70/NF0A7UQJ4H0-HERO/NF0A7UQJ4H0-in-TNF-Black.png',
    price: 120,
    stock: 'In Stock',
    sizes: ['S', 'M', 'L', 'XL'],
    description:
        'Waterproof, breathable jacket ideal for outdoor adventures and everyday wear.',
  ),
  Product(
    id: '5',
    categoryId: 'Sneakers',
    companyId: 'Puma',
    name: 'Puma Suede Classic Sneakers',
    image:
        'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_750,h_750/global/374915/01/sv01/fnd/IND/fmt/png/Suede-Classic-XXI-Unisex-Sneakers',
    price: 70,
    stock: 'Out of Stock',
    sizes: ['8', '9', '10', '11'],
    description:
        'Iconic low-top sneakers with a suede upper and classic Puma branding.',
  ),
  Product(
    id: '6',
    categoryId: 'Dresses',
    companyId: 'H&M',
    name: 'H&M Floral Print Dress',
    image:
        "https://image.hm.com/assets/hm/a4/8f/a48f996133b0b54e700d80fe158034fde642d4f5.jpg",
    price: 35,
    stock: 'In Stock',
    sizes: ['XS', 'S', 'M', 'L'],
    description:
        'Lightweight floral dress, perfect for spring and summer occasions.',
  ),
];
