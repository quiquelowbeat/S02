use optica // Creamos db óptica.
// Insertamos los proveedores.
db.suppliers.insertMany([

    {
        "_id": 1,
        "name": "Gafas Pérez", 
        "address": { 
            "street": "Calle del Milagro", 
            "building": 36, 
            "floor_door": "2", 
            "city": "Barcelona", 
            "zipcode": "08030", 
            "country": "España"
        },
        "phone_number": "659595959", 
        "fax_number": "933333456", 
        "nif": "B43555564L",
        "brands_id": [1,2]
    },
    
    {
        "_id": 2,
        "name": "Gafas la Visión", 
        "address": { 
            "street": "Calle de la Botella", 
            "building": 67, 
            "floor_door": "25B", 
            "city": "Barcelona", 
            "zipcode": "08027", 
            "country": "España"
        },
        "phone_number": "678675645", 
        "fax_number": "933333746", 
        "nif": "B63555564L",
        "brands_id": [3]
    },

    {
        "_id": 3,
        "name": "La Vista SL", 
        "address": { 
            "street": "Calle Progreso", 
            "building": 89, 
            "floor_door": "Local B", 
            "city": "Barcelona", 
            "zipcode": "08017", 
            "country": "España"
        },
        "phone_number": "678908756", 
        "fax_number": "913333456", 
        "nif": "B53555564L",
        "brands_id": [6]
    },

    {
        "_id": 4,
        "name": "El Niño Cegato", 
        "address": { 
            "street": "Calle Carmen", 
            "building": 365, 
            "floor_door": "Local 3", 
            "city": "Fuenlabrada", 
            "zipcode": "28940", 
            "country": "España"
        },
        "phone_number": "659595959", 
        "fax_number": "933333456", 
        "nif": "B78555564L",
        "brands_id": [5]
    },
    
    {
        "_id": 5,
        "name": "Noveoná SL", 
        "address": { 
            "street": "Calle de la Miopía", 
            "building": 43, 
            "floor_door": "Bajos", 
            "city": "Fuenlabrada", 
            "zipcode": "28941", 
            "country": "España"
        },
        "phone_number": "659590959", 
        "fax_number": "933333776", 
        "nif": "B73566564L",
        "brands_id": [4]
    }]),
// Insertamos las marcas de gafas.
db.brands.insertMany([

    {
        "_id": 1,
        "name": "Rayban",
    },

    {
        "_id": 2,
        "name": "Arnette",
    },

    {
        "_id": 3,
        "name": "Oakley",
    },

    {
        "_id": 4,
        "name": "Quiksilver",
    },

    {
        "_id": 5,
        "name": "Gant",
    },

    {
        "_id": 6,
        "name": "Hawkers",
    }

]),
// Insertamos los tipos de gafas que tenemos en stock.
db.glasses.insertMany([
    
    {
        "_id": 1,
        "brand_id": 4,
        "graduation_left": 1.5,
        "graduation_right": 1.2,
        "frame_type": "metallic",
        "frame_color": "black",
        "left_glass_color": "clear",
        "right_glass_color": "clear",
        "price": 150.50
    },

    {
        "_id": 2,
        "brand_id": 1,
        "graduation_left": 1.7,
        "graduation_right": 1.7,
        "frame_type": "wood",
        "frame_color": "brown",
        "left_glass_color": "black",
        "right_glass_color": "black",
        "price": 190.70
    },

    {
        "_id": 3,
        "brand_id": 2,
        "graduation_left": 5.0,
        "graduation_right": 7.0,
        "frame_type": "floating",
        "frame_color": "black",
        "left_glass_color": "clear",
        "right_glass_color": "clear",
        "price": 450.56
    },

    {
        "_id": 4,
        "brand_id": 5,
        "graduation_left": 1.0,
        "graduation_right": 1.2,
        "frame_type": "metallic",
        "frame_color": "silver",
        "left_glass_color": "brown",
        "right_glass_color": "brown",
        "price": 300.50
    },

    {
        "_id": 5,
        "brand_id": 3,
        "graduation_left": 0.5,
        "graduation_right": 0.7,
        "frame_type": "wood",
        "frame_color": "black",
        "left_glass_color": "clear",
        "right_glass_color": "clear",
        "price": 280.59
    }
]),
// Insertamos los datos de los clientes
db.costumers.insertMany([
    {
        "_id": 1,
        "name": "Josep",
        "last_name": "Pérez",
        "second_last_name": "Conde",
        "address":{
            "street": "Calle Pau", 
            "building": 38, 
            "floor_door": "Ent 2", 
            "city": "Fuenlabrada", 
            "zipcode": "28940", 
            "country": "España"
        },
        "phone_number": "678908765",
        "email": "joseppconde@terra.es",
        "registration_date": new Date("2016-04-23"),
        "recommended_by_costumer_id": null
    },

    {
        "_id": 2,
        "name": "Enric",
        "last_name": "López",
        "second_last_name": "Borilla",
        "address":{
            "street": "Carrer Lou", 
            "building": 90, 
            "floor_door": "2-4", 
            "city": "Barcelona", 
            "zipcode": "08045", 
            "country": "España"
        },
        "phone_number": "672334765",
        "email": "enricborillal@eresmas.es",
        "registration_date": new Date("2018-05-13"),
        "recommended_by_costumer_id": 1
    },

    {
        "_id": 3,
        "name": "Arnau",
        "last_name": "Vilaseca",
        "second_last_name": "Torrat",
        "address":{
            "street": "Via Laietana", 
            "building": 380, 
            "floor_door": "Ent 7", 
            "city": "Barcelona", 
            "zipcode": "08001", 
            "country": "España"
        },
        "phone_number": "671118765",
        "email": "arnauvt@arrakis.com",
        "registration_date": new Date("2014-01-20"),
        "recommended_by_costumer_id": 2
    },

    {
        "_id": 4,
        "name": "Pepe",
        "last_name": "Camoiras",
        "second_last_name": "Aladid",
        "address":{
            "street": "Calle Congreso", 
            "building": 18, 
            "floor_door": "2-2", 
            "city": "Fuenlabrada", 
            "zipcode": "28940", 
            "country": "España"
        },
        "phone_number": "678902235",
        "email": "pepecamoriasal@netscape.net",
        "registration_date": new Date("2022-01-23"),
        "recommended_by_costumer_id": null
    },

    {
        "_id": 5,
        "name": "Willy",
        "last_name": "Fonseca",
        "second_last_name": "Madeiros",
        "address":{
            "street": "Calle del Futuro", 
            "building": 8, 
            "floor_door": "Ent 1", 
            "city": "Fuenlabrada", 
            "zipcode": "28940", 
            "country": "España"
        },
        "phone_number": "679878765",
        "email": "willypati@ono.com",
        "registration_date": new Date("2011-02-03"),
        "recommended_by_costumer_id": 3
    }
]),
//Insertamos los datos de los empleados.
db.employees.insertMany([
    {
        "_id": 1,
        "name": "Quique",
        "last_name": "Sánchez",
        "second_last_name": "Flores"
    },

    {
        "_id": 2,
        "name": "Luis",
        "last_name": "López",
        "second_last_name": "Gaia"
    },

    {
        "_id": 3,
        "name": "Álex",
        "last_name": "Sancho",
        "second_last_name": "Vilatorrada"
    }

])
// Insertamos algunos pedidos.
db.orders.insertMany([
    {
        "_id": 1,
        "glasses_id": [1, 4, 5],
        "costumer_id": 5,
        "employee_id": 2,
        "order_date": new Date("2022-02-21")
    },

    {
        "_id": 2,
        "glasses_id": [2],
        "costumer_id": 2,
        "employee_id": 1,
        "order_date": new Date("2022-03-08")
    },

    {
        "_id": 3,
        "glasses_id": [1, 3],
        "costumer_id": 1,
        "employee_id": 3,
        "order_date": new Date("2022-03-01")
    }

])


