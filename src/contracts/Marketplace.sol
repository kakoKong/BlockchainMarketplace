pragma solidity >=0.5.0;

contract Marketplace {
    string public name;

    uint public productCount = 0;

    mapping(uint => Product) public products;

    struct Product {
        uint id;
        string name;
        uint price;
        address payable owner;
        bool purchased;
    }

    event ProductCreated(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    event ProductPurchased(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    constructor() public {
        name = "Blockchain Test App";
    }

    function createProduct(string memory _name, uint _price) public {
        //Make sure Parameter is correct
        require(bytes(_name).length > 0);
        require(_price > 0);
        //Increment Product Count
        productCount++;
        // Create Product
        products[productCount] = Product(productCount, _name, _price, msg.sender, false);
        //Trigger Event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }

    function purchaseProduct(uint _id) public payable {
        //Fetch Product
        Product memory _product = products[_id];

        //Fetch Owner
        address payable _seller = _product.owner;
        //Product valid id
        require(_product.id > 0 && _product.id <= productCount);
        //Require enough ether in transaction
        require(msg.value >= _product.price);
        // Require that the product has not been purchased
        require(!_product.purchased);
        // Require the buyer is not the seller
        require(_product.owner != msg.sender);
        //Transfer Ownership
        _product.owner = msg.sender;
        //Mark as Purchased
        _product.purchased = true;
        //Update the Product
        products[_id] = _product;

        //Pay seller by sending ether
        address(_seller).transfer(msg.value);

        emit ProductPurchased(productCount, _product.name, _product.price, msg.sender, true);

    }
}
