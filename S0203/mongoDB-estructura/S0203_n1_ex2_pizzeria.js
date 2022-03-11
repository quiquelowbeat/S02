use pizzeria // Creamos db pizzería.
// Insertamos data de clientes.
db.costumers.insertMany([
    {
        "_id": 1,
        "name": "Josep",
        "last_name": "Pérez",
        "second_last_name": "Conde",
        "street": "Calle Pau", 
        "building": 38, 
        "floor_door": "Ent 2", 
        "city": "Fuenlabrada", 
        "zipcode": "28940", 
        "phone_number": "678908765",
        "locality_id": 1,
    },

    {
        "_id": 2,
        "name": "Enric",
        "last_name": "López",
        "second_last_name": "Borilla",
        "street": "Carrer Lou", 
        "building": 90, 
        "floor_door": "2-4", 
        "city": "Barcelona", 
        "zipcode": "08045", 
        "phone_number": "672334765",
        "locality_id": 2,
    },

    {
        "_id": 3,
        "name": "Arnau",
        "last_name": "Vilaseca",
        "second_last_name": "Torrat",
        "street": "Via Laietana", 
        "building": 380, 
        "floor_door": "Ent 7", 
        "city": "Barcelona", 
        "zipcode": "08001", 
        "phone_number": "671118765",
        "locality_id": 3,
    },

    {
        "_id": 4,
        "name": "Pepe",
        "last_name": "Camoiras",
        "second_last_name": "Aladid",
        "street": "Calle Congreso", 
        "building": 18, 
        "floor_door": "2-2", 
        "city": "Fuenlabrada", 
        "zipcode": "28940", 
        "phone_number": "678902235",
        "locality_id": 3,
    },

    {
        "_id": 5,
        "name": "Willy",
        "last_name": "Fonseca",
        "second_last_name": "Madeiros",
        "street": "Calle del Futuro", 
        "building": 8, 
        "floor_door": "Ent 1", 
        "city": "Fuenlabrada", 
        "zipcode": "28940", 
        "phone_number": "679878765",
        "locality_id": 1,
    }
])

// Insertamos provincias

db.locality.insertMany([
    {
        "_id": 1,
        "name": "Barcelona",
        "province_id": 1
    },

    {
        "_id": 2,
        "name": "Sitges",
        "province_id": 1
    },

    {
        "_id": 3,
        "name": "Roses",
        "province_id": 2
    }

])

db.province.insertMany([
    {
        "_id": 1,
        "name": "Barcelona",
    },

    {
        "_id": 2,
        "name": "Girona",
    }

])

db.stores.insertMany([
    {
        "_id": 1,
        "street": "Carrer Valencia",
        "building": 34,
        "floor": "Local 2",
        "zipcode": "08020",
        "locality_id": 1
    },

    {
        "_id": 2,
        "street": "Carrer Tramuntana",
        "building": 4,
        "floor": "78B",
        "zipcode": "17480",
        "locality_id": 3
    },

    {
        "_id": 3,
        "street": "Calle del Pecado",
        "building": 69,
        "floor": "Local 6",
        "zipcode": "08870",
        "locality_id": 2
    }
])

db.orders.insertMany([
    {
        "_id": 1,
        "costumer_id": 1,
        "store_id": 1,
        "order_date": new Date("2022-01-31T22:01:34Z"), // Per que el sistema registri la data real de la comanda en el moment de produir-se, fariem un "order_date": Date(),
        "status": "domicilio",
        "items": [
            {
                "pizza_id": 1,
                "quantity": 1
            },

            {
                "pizza_id": 2,
                "quantity": 1
            },

            {
                "burguer_id": 1,
                "quantity": 2
            },

            {
                "drink_id": 1,
                "quantity": 2
            },
        ],
        "total_price": 54.65

    },

    {
        "_id": 2,
        "costumer_id": 2,
        "store_id": 1,
        "order_date": new Date("2022-03-09T21:07:34Z"),
        "status": "domicilio",
        "items": [
            {
                "pizza_id": 2,
                "quantity": 1
            },

            {
                "burguer_id": 1,
                "quantity": 3
            },

            {
                "drink_id": 2,
                "quantity": 10
            },
        ],
        "total_price": 107.95
    }

])

db.delivery_orders.insertMany([
    {
         "_id": 1,
         "order_id": 1,
         "delivery_datetime": new Date("2022-01-31T22:32:34Z"),
         "employee_id": 1
    },

    {
        "_id": 2,
        "order_id": 2,
        "delivery_datetime": new Date("2022-03-09T21:28:54Z"),
        "employee_id": 2
   }

])

db.employees.insertMany([
    {
        "_id": 1,
        "store_id": 1,
        "name": "Quique",
        "last_name": "Sanfrancisco",
        "second_last_name": "López",
        "nif": "43434343P",
        "phone_number": "659595959",
        "role": "reparto"
    },

    {
        "_id": 2,
        "store_id": 1,
        "name": "Will",
        "last_name": "Smith",
        "second_last_name": null,
        "nif": "43456343P",
        "phone_number": "659596859",
        "role": "reparto"
    },

    {
        "_id": 3,
        "store_id": 2,
        "name": "Satoshi",
        "last_name": "Nakamoto",
        "second_last_name": null,
        "nif": "21000000B",
        "phone_number": "657634859",
        "role": "cocina"
    }
])

db.drinks.insertMany([
    {
        "_id": 1,
        "name": "Cerveza Damm",
        "description": "Dorada con tonalidades ambarinas y algunos reflejos verdosos. Es limpia, brillante. Su espuma, de color crudo y de larga presencia.",
        "image_url": "https://m.media-amazon.com/images/I/51ccqjX9x8L._AC_SX342_.jpg",
        "price": 2.5
    },

    {
        "_id": 2,
        "name": "Cerveza Mahoo",
        "description": "Ejemplo de cerveza pilsen de inspiración alemana. Fermentación baja (Lager), con periodo de maduración para dejar evolucionar los sabores y filtración para dejarla brillante.",
        "image_url": "https://m.media-amazon.com/images/I/71UjBgM9NEL._AC_SX569_.jpg",
        "price": 2.45
    }
])

db.pizzas.insertMany([
    {
        "_id": 1,
        "name": "Pizza Margherita",
        "description": "La pizza más tradidional.",
        "image_url": "https://www.hola.com/imagenes/cocina/recetas/20190911149183/pizza-margarita/0-717-935/pizza-m.jpg",
        "price": 12.00,
        "pizza_category_id": 1
    },

    {
        "_id": 2,
        "name": "Pizza Napolitana",
        "description": "La pizza más atrevida.",
        "image_url": "https://novecentoweb.com/images/made/local/images/main/171124-como-es-la-verdadera-pizza-napolitana_555_370_s_c1.jpg",
        "price": 12.00,
        "pizza_category_id": 1
    },

    {
        "_id": 3,
        "name": "Pizza de Altramuces",
        "description": "Su sabor te sorprenderá.",
        "image_url": "https://www.grupobolanos.com/gran-canaria/wp-content/uploads/2021/08/altramuces.jpg",
        "price": 15.00,
        "pizza_category_id": 2
    }
])

db.pizza_categories.insertMany([
    {
        "_id": 1,
        "name": "Tradicionales"
    },

    {
        "_id": 2,
        "name": "De autor"
    }
])

db.burguers.insertMany([
    {
        "_id": 1,
        "name": "Cheese burguer",
        "description": "Patty de categoría con queso cheddar.",
        "image_url": "https://canalcocina.es/medias/_cache/zoom-c10264d03d948791641c5f1bdcad4ca4-920-518.jpg",
        "price": 10.00,
    },

    {
        "_id": 2,
        "name": "Bacon smashed burguer",
        "description": "Smashed patty con delicioso bacon ahumado.",
        "image_url": "https://img-global.cpcdn.com/recipes/0dce8fd07e63ce86/680x482cq70/smash-burger-foto-principal.jpg",
        "price": 11.50,
    }

])